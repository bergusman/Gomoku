//
//  GameSession.h
//  Gomoku
//
//  Created by Vitaly Berg on 20/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GameSessionDelegate;


@interface GameSession : NSObject

@property (assign, nonatomic) id<GameSessionDelegate> delegate;

@property (assign, nonatomic, readonly) BOOL master;

@property (assign, nonatomic) NSString *opponentUUID;

- (void)startWithOpponentStone:(NSString *)stone;
- (void)makeStepAtX:(NSInteger)x Y:(NSInteger)y;

- (instancetype)initWithService:(NearbyService *)service master:(BOOL)master;

@end


@protocol GameSessionDelegate <NSObject>

- (void)gameSession:(GameSession *)session didStartWithOpponentStone:(NSString *)stone;
- (void)gameSession:(GameSession *)session didMakeStepAtX:(NSInteger)x Y:(NSInteger)y;

@end
