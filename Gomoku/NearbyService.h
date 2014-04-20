//
//  NearbyService.h
//  Gomoku
//
//  Created by Vitaly Berg on 20/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NearbyPeer.h"

#import <MultipeerConnectivity/MultipeerConnectivity.h>

@protocol NearbyServiceDelegate;


@interface NearbyService : NSObject

@property (assign, nonatomic) id<NearbyServiceDelegate> delegate;

@property (strong, nonatomic, readonly) NSString *uuid;
@property (strong, nonatomic, readonly) NSString *serviceType;

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSArray *browsedPeers;
@property (strong, nonatomic) NSArray *connectedPeers;

- (void)startBrowsing;
- (void)stopBrowsing;

- (void)startAdvertising;
- (void)stopAdvertising;

- (void)invitePeer:(NearbyPeer *)peer;

- (void)sendData:(NSData *)data;

- (instancetype)initWithUUID:(NSString *)uuid type:(NSString *)type;
+ (NearbyService *)nearbyServiceWithUUID:(NSString *)uuid type:(NSString *)type;

@end


@protocol NearbyServiceDelegate <NSObject>

@optional

- (void)nearbyService:(NearbyService *)service foundPeer:(NearbyPeer *)peer;
- (void)nearbyService:(NearbyService *)service lostPeer:(NearbyPeer *)peer;
- (void)nearbyService:(NearbyService *)service didReceiveInvitationFromPeer:(NearbyPeer *)peer invitationHandler:(void(^)(BOOL accept))invitationHandler;

- (void)nearbyService:(NearbyService *)service didReceiveData:(NSData *)data fromPeer:(NearbyPeer *)peer;

- (void)nearbyServiceDidChangeSession:(NearbyService *)service;

- (void)nearbyService:(NearbyService *)service peer:(NearbyPeer *)peer didChangeState:(MCSessionState)state;

@end
