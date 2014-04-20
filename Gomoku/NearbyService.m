//
//  NearbyService.m
//  Gomoku
//
//  Created by Vitaly Berg on 20/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "NearbyService.h"

#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface NearbyService () <MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate, MCSessionDelegate>

@property (strong, nonatomic) MCPeerID *peerID;
@property (strong, nonatomic) MCNearbyServiceBrowser *browser;
@property (strong, nonatomic) MCNearbyServiceAdvertiser *advertiser;
@property (strong, nonatomic) MCSession *session;

@property (strong, nonatomic) NSMutableDictionary *peerIDsByUUIDs;
@property (strong, nonatomic) NSMutableDictionary *peersByUUIDs;

@end

@implementation NearbyService {
    NSMutableArray *_connectedPeers;
}

#pragma mark - Content

- (void)startBrowsing {
    self.browser = [[MCNearbyServiceBrowser alloc] initWithPeer:self.peerID serviceType:self.serviceType];
    self.browser.delegate = self;
    [self.browser startBrowsingForPeers];
}

- (void)stopBrowsing {
    [self.browser stopBrowsingForPeers];
}

- (void)startAdvertising {
    id info = @{@"name": self.name};
    
    self.advertiser = [[MCNearbyServiceAdvertiser alloc] initWithPeer:self.peerID discoveryInfo:info serviceType:self.serviceType];
    self.advertiser.delegate = self;
    [self.advertiser startAdvertisingPeer];
}

- (void)stopAdvertising {
    [self.advertiser stopAdvertisingPeer];
}

- (void)invitePeer:(NearbyPeer *)peer {
    MCPeerID *peerID = self.peerIDsByUUIDs[peer.uuid];
    [self.browser invitePeer:peerID toSession:self.session withContext:nil timeout:30];
}

- (void)sendData:(NSData *)data {
    NSLog(@"%s", __func__);
    NSError *error;
    [self.session sendData:data toPeers:nil withMode:MCSessionSendDataReliable error:&error];
    NSLog(@"%@", error);
}

#pragma mark - MCNearbyServiceBrowserDelegate

- (void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info {
    NSLog(@"%s", __func__);
    
    self.peerIDsByUUIDs[peerID.displayName] = peerID;
    
    NearbyPeer *peer = [[NearbyPeer alloc] initWithUUID:peerID.displayName name:info[@"name"]];
    self.peersByUUIDs[peer.uuid] = peer;
    
    if ([self.delegate respondsToSelector:@selector(nearbyService:foundPeer:)]) {
        [self.delegate nearbyService:self foundPeer:peer];
    }
}

- (void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID {
    NSLog(@"%s", __func__);
    
    NearbyPeer *peer = self.peersByUUIDs[peerID.displayName];
    
    //[self.peersByUUIDs removeObjectForKey:peerID.displayName];
    //[self.peerIDsByUUIDs removeObjectForKey:peerID.displayName];
    
    if ([self.delegate respondsToSelector:@selector(nearbyService:lostPeer:)]) {
        [self.delegate nearbyService:self lostPeer:peer];
    }
}

- (void)browser:(MCNearbyServiceBrowser *)browser didNotStartBrowsingForPeers:(NSError *)error {
    NSLog(@"%s", __func__);
}

#pragma mark - MCNearbyServiceAdvertiserDelegate

- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(MCPeerID *)peerID withContext:(NSData *)context invitationHandler:(void(^)(BOOL accept, MCSession *session))invitationHandler {
    NSLog(@"%s", __func__);
    
    if ([self.delegate respondsToSelector:@selector(nearbyService:didReceiveInvitationFromPeer:invitationHandler:)]) {
        
        void (^handler)(BOOL accept) = ^(BOOL accept) {
            invitationHandler(YES, self.session);
        };
        
        NearbyPeer *peer = self.peersByUUIDs[peerID.displayName];
        [self.delegate nearbyService:self didReceiveInvitationFromPeer:peer invitationHandler:handler];
    }
}

- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didNotStartAdvertisingPeer:(NSError *)error {
    NSLog(@"%s", __func__);
}

#pragma mark - MCSessionDelegate

- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state {
    NSLog(@"%s", __func__);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.peerIDsByUUIDs[peerID] = peerID.displayName;
        NearbyPeer *peer = self.peersByUUIDs[peerID.displayName];
        
        if (state == MCSessionStateNotConnected) {
            [_connectedPeers removeObject:peer];
        } else if (state == MCSessionStateConnected) {
            if (![_connectedPeers containsObject:peer]) {
                [_connectedPeers addObject:peer];
            }
        }
        
        if ([self.delegate respondsToSelector:@selector(nearbyService:peer:didChangeState:)]) {
            [self.delegate nearbyService:self peer:peer didChangeState:state];
        }
    });
}

- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
    NSLog(@"%s", __func__);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.peerIDsByUUIDs[peerID] = peerID.displayName;
        NearbyPeer *peer = self.peersByUUIDs[peerID.displayName];
        
        if ([self.delegate respondsToSelector:@selector(nearbyService:didReceiveData:fromPeer:)]) {
            [self.delegate nearbyService:self didReceiveData:data fromPeer:peer];
        }
    });
}

- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID {}
- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress {}
- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error {}

#pragma mark - Creation

- (instancetype)initWithUUID:(NSString *)uuid type:(NSString *)type {
    self = [super init];
    if (self) {
        _uuid = uuid;
        _serviceType = type;
        _peerID = [[MCPeerID alloc] initWithDisplayName:_uuid];
        
        _peerIDsByUUIDs = [NSMutableDictionary dictionary];
        _peersByUUIDs = [NSMutableDictionary dictionary];
        
        _session = [[MCSession alloc] initWithPeer:_peerID];
        _session.delegate = self;
        
        _connectedPeers = [NSMutableArray array];
    }
    return self;
}

+ (NearbyService *)nearbyServiceWithUUID:(NSString *)uuid type:(NSString *)type {
    return [[NearbyService alloc] initWithUUID:uuid type:type];
}

@end
