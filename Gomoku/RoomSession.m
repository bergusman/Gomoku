//
//  RoomSession.m
//  Gomoku
//
//  Created by Vitaly Berg on 20/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "RoomSession.h"

@interface RoomSession ()

@property (strong, nonatomic) NearbyService *service;

@end

@implementation RoomSession {
    NSMutableArray *_peers;
}

#pragma mark - NearbyServiceDelegate

- (void)nearbyService:(NearbyService *)service foundPeer:(NearbyPeer *)peer {
    NSLog(@"%s", __func__);
    [_peers addObject:peer];
    
    if ([self.delegate respondsToSelector:@selector(roomSessionDidUpdatePeers:)]) {
        [self.delegate roomSessionDidUpdatePeers:self];
    }
}

- (void)nearbyService:(NearbyService *)service lostPeer:(NearbyPeer *)peer {
    NSLog(@"%s", __func__);
    [_peers removeObject:peer];
    
    if ([self.delegate respondsToSelector:@selector(roomSessionDidUpdatePeers:)]) {
        [self.delegate roomSessionDidUpdatePeers:self];
    }
}

- (void)nearbyService:(NearbyService *)service peer:(NearbyPeer *)peer didChangeState:(MCSessionState)state {
    NSLog(@"%s", __func__);
    if ([self.delegate respondsToSelector:@selector(roomSession:peer:didChangeState:)]) {
        [self.delegate roomSession:self peer:peer didChangeState:state];
    }
}

- (void)nearbyService:(NearbyService *)service didReceiveInvitationFromPeer:(NearbyPeer *)peer invitationHandler:(void(^)(BOOL accept))invitationHandler {
    NSLog(@"%s", __func__);
    if ([self.delegate respondsToSelector:@selector(roomSession:didReceiveInvitationFromPeer:invitationHandler:)]) {
        [self.delegate roomSession:self didReceiveInvitationFromPeer:peer invitationHandler:invitationHandler];
    }
}

#pragma mark - Content

- (void)start {
    NSLog(@"%s", __func__);
    self.service.delegate = self;
    [self.service startAdvertising];
    [self.service startBrowsing];
}

- (void)stop {
    NSLog(@"%s", __func__);
    [self.service stopAdvertising];
    [self.service stopBrowsing];
}

- (void)invitePeer:(NearbyPeer *)peer {
    NSLog(@"%s", __func__);
    [self.service invitePeer:peer];
}

- (instancetype)initWithService:(NearbyService *)service {
    self = [super init];
    if (self) {
        _service = service;
        _peers = [NSMutableArray array];
    }
    return self;
}

@end
