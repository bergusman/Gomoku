//
//  GomokuBoard.h
//  Gomoku
//
//  Created by Vitaly Berg on 12/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GomokuBoardGeometry.h"

@interface GomokuBoardLine : NSObject

@property (assign, nonatomic, readonly) NSInteger stone;
@property (strong, nonatomic, readonly) NSArray *points;

- (instancetype)initWithStone:(NSInteger)stone points:(NSArray *)points;
+ (GomokuBoardLine *)gomokuBoardLineWithStone:(NSInteger)stone points:(NSArray *)points;

@end;

extern NSInteger const EmptyStone;

@interface GomokuBoard : NSObject

@property (assign, nonatomic, readonly) GomokuBoardSize size;

- (void)putStone:(NSInteger)stone atPoint:(GomokuBoardPoint)point;
- (NSInteger)stoneAtPoint:(GomokuBoardPoint)point;

- (NSUInteger)countOfStones:(NSInteger)stone;

- (GomokuBoardLine *)findFirstLine;
- (NSArray *)findAllLines;

- (instancetype)initWithSize:(GomokuBoardSize)size;
+ (GomokuBoard *)gomokuBoardWithSize:(GomokuBoardSize)size;

@end
