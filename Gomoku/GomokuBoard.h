//
//  GomokuBoard.h
//  Gomoku
//
//  Created by Vitaly Berg on 12/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GomokuGeometry.h"


extern NSInteger const EmptyStone;


@interface GomokuLine : NSObject

@property (assign, nonatomic, readonly) NSInteger stone;

@property (assign, nonatomic) GomokuPoint from;
@property (assign, nonatomic) GomokuPoint to;

- (instancetype)initWithStone:(NSInteger)stone from:(GomokuPoint)from to:(GomokuPoint)to;
+ (GomokuLine *)gomokuLineWithStone:(NSInteger)stone from:(GomokuPoint)from to:(GomokuPoint)to;

@end;


@interface GomokuBoard : NSObject

@property (assign, nonatomic, readonly) GomokuSize size;

- (BOOL)putStone:(NSInteger)stone atPoint:(GomokuPoint)point;
- (NSInteger)stoneAtPoint:(GomokuPoint)point;

- (BOOL)isPointInBoard:(GomokuPoint)point;
- (BOOL)containsStoneAtPoint:(GomokuPoint)point; // -[GomokuBoard stoneAtPoint:] != EmptyStone

- (NSUInteger)countOfStones:(NSInteger)stone;

- (GomokuLine *)findFirstLine;
- (NSArray *)findAllLines;

- (instancetype)initWithSize:(GomokuSize)size;
+ (GomokuBoard *)gomokuBoardWithSize:(GomokuSize)size;

@end
