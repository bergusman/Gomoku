//
//  GomokuGame.h
//  Gomoku
//
//  Created by Vitaly Berg on 20/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GomokuBoard.h"


extern GomokuStone const GomokuGameStoneX;
extern GomokuStone const GomokuGameStoneO;


@interface GomokuGameStep : NSObject

@property (assign, nonatomic, readonly) GomokuStone stone;
@property (assign, nonatomic, readonly) GomokuPoint point;

- (instancetype)initWithStone:(GomokuStone)stone at:(GomokuPoint)point;
+ (GomokuGameStep *)gomokuGameStepWithStone:(GomokuStone)stone at:(GomokuPoint)point;

@end


@interface GomokuGame : NSObject

@property (strong, nonatomic, readonly) NSArray *history;
@property (assign, nonatomic, readonly) GomokuStone currentStepStone;

@property (assign, nonatomic, readonly) BOOL gameOver;

@property (strong, nonatomic, readonly) GomokuLine *winLine;
@property (assign, nonatomic, readonly) BOOL draw;

- (BOOL)canMakeStepAt:(GomokuPoint)point;
- (BOOL)makeStepAt:(GomokuPoint)point;

- (instancetype)initWithBoard:(GomokuBoard *)board;
+ (GomokuGame *)gomokuGameWithBoard:(GomokuBoard *)board;

@end
