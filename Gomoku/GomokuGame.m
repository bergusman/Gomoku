//
//  GomokuGame.m
//  Gomoku
//
//  Created by Vitaly Berg on 20/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "GomokuGame.h"


GomokuStone const GomokuGameStoneX = 1;
GomokuStone const GomokuGameStoneO = 2;


@implementation GomokuGameStep

- (instancetype)initWithStone:(GomokuStone)stone at:(GomokuPoint)point {
    self = [super init];
    if (self) {
        _stone = stone;
        _point = point;
    }
    return self;
}

+ (GomokuGameStep *)gomokuGameStepWithStone:(GomokuStone)stone at:(GomokuPoint)point {
    return [[GomokuGameStep alloc] initWithStone:stone at:point];
}

@end


@interface GomokuGame ()

@property (strong, nonatomic) GomokuBoard *board;

@property (assign, nonatomic, readwrite) GomokuStone currentStepStone;
@property (assign, nonatomic, readwrite) BOOL gameOver;
@property (strong, nonatomic, readwrite) GomokuLine *winLine;
@property (assign, nonatomic, readwrite) BOOL draw;

@end

@implementation GomokuGame {
    NSMutableArray *_history;
}

@synthesize history = _history;

- (void)addToHistory:(GomokuGameStep *)step {
    [_history addObject:step];
}

- (void)setNextStone {
    if (self.currentStepStone == GomokuGameStoneX) {
        self.currentStepStone = GomokuGameStoneO;
    } else {
        self.currentStepStone = GomokuGameStoneX;
    }
}

- (BOOL)canMakeStepAt:(GomokuPoint)point {
    if (self.gameOver) {
        return NO;
    }
    
    return [self.board isEmptyStoneAtPoint:point];
}

- (BOOL)makeStepAt:(GomokuPoint)point {
    if (![self canMakeStepAt:point]) {
        return NO;
    }
    
    [self.board putStone:self.currentStepStone atPoint:point];
    
    GomokuGameStep *step = [GomokuGameStep gomokuGameStepWithStone:self.currentStepStone at:point];
    [self addToHistory:step];
    
    GomokuLine *line = [self.board findFirstLine];
    if (line) {
        self.gameOver = YES;
        self.winLine = line;
    } else {
        if ([self.board isFull]) {
            self.gameOver = YES;
            self.draw = YES;
        }
    }
    
    [self setNextStone];
    
    return YES;
}

- (instancetype)initWithBoard:(GomokuBoard *)board {
    self = [super init];
    if (self) {
        _history = [NSMutableArray array];
        _currentStepStone = GomokuGameStoneX;
        _board = board;
    }
    return self;
}

+ (GomokuGame *)gomokuGameWithBoard:(GomokuBoard *)board {
    return [[GomokuGame alloc] initWithBoard:board];
}

@end
