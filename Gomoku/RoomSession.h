//
//  RoomSession.h
//  Gomoku
//
//  Created by Vitaly Berg on 20/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NearbyService.h"


@protocol RoomSessionDelegate;


@interface RoomSession : NSObject <NearbyServiceDelegate>

@property (assign, nonatomic) id<RoomSessionDelegate> delegate;

@property (strong, nonatomic, readonly) NSArray *peers;

- (void)start;
- (void)stop;

- (void)invitePeer:(NearbyPeer *)peer;

- (instancetype)initWithService:(NearbyService *)service;

@end


@protocol RoomSessionDelegate <NSObject>

- (void)roomSessionDidUpdatePeers:(RoomSession *)session;
- (void)roomSession:(RoomSession *)session didReceiveInvitationFromPeer:(NearbyPeer *)peer invitationHandler:(void(^)(BOOL accept))invitationHandler;

- (void)roomSession:(RoomSession *)session peer:(NearbyPeer *)peer didChangeState:(MCSessionState)state;

@end
