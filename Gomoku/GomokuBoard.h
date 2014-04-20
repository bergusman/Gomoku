//
//  GomokuBoard.h
//  Gomoku
//
//  Created by Vitaly Berg on 12/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GomokuGeometry.h"


typedef NSInteger GomokuStone;

extern GomokuStone const EmptyStone;


@interface GomokuLine : NSObject

@property (assign, nonatomic, readonly) GomokuStone stone;

@property (assign, nonatomic, readonly) GomokuPoint from;
@property (assign, nonatomic, readonly) GomokuPoint to;

- (instancetype)initWithStone:(GomokuStone)stone from:(GomokuPoint)from to:(GomokuPoint)to;
+ (GomokuLine *)gomokuLineWithStone:(GomokuStone)stone from:(GomokuPoint)from to:(GomokuPoint)to;

@end;


@interface GomokuBoard : NSObject

@property (assign, nonatomic, readonly) GomokuSize size;

- (BOOL)putStone:(GomokuStone)stone atPoint:(GomokuPoint)point;
- (GomokuStone)stoneAtPoint:(GomokuPoint)point;

- (BOOL)isPointInBoard:(GomokuPoint)point;
- (BOOL)containsStoneAtPoint:(GomokuPoint)point;    // -[GomokuBoard stoneAtPoint:] != EmptyStone && point in bounds of board
- (BOOL)isEmptyStoneAtPoint:(GomokuPoint)point;     // -[GomokuBoard stoneAtPoint:] == EmptyStone && point in bounds of board

- (BOOL)isFull;
- (BOOL)isEmpty;

- (NSUInteger)countOfStones:(GomokuStone)stone;

- (GomokuLine *)findFirstLine;
- (NSArray *)findAllLines;

- (instancetype)initWithSize:(GomokuSize)size;
+ (GomokuBoard *)gomokuBoardWithSize:(GomokuSize)size;

- (NSString *)textBoard;

@end
