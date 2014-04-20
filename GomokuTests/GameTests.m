//
//  GameTests.m
//  Gomoku
//
//  Created by Vitaly Berg on 20/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "GomokuGame.h"

@interface GameTests : XCTestCase

@end

@implementation GameTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testGame {
    GomokuBoard *board = [[GomokuBoard alloc] initWithSize:GomokuSizeMake(10, 10)];
    GomokuGame *game = [GomokuGame gomokuGameWithBoard:board];
    
    XCTAssertTrue([board isEmpty]);
    XCTAssertFalse([board isFull]);
    
    XCTAssertTrue([game.history count] == 0);
    
    XCTAssertTrue(game.currentStepStone == GomokuGameStoneX);
    
    [game makeStepAt:GomokuPointMake(0, 0)];
    
    XCTAssertTrue(game.currentStepStone == GomokuGameStoneO);
    
    [game makeStepAt:GomokuPointMake(0, 1)];
    [game makeStepAt:GomokuPointMake(1, 1)];
    [game makeStepAt:GomokuPointMake(0, 2)];
    [game makeStepAt:GomokuPointMake(2, 2)];
    [game makeStepAt:GomokuPointMake(0, 3)];
    [game makeStepAt:GomokuPointMake(3, 3)];
    [game makeStepAt:GomokuPointMake(0, 4)];
    [game makeStepAt:GomokuPointMake(4, 4)];
    
    XCTAssertTrue([game.history count] == 9);
    
    XCTAssertFalse([board isEmpty]);
    
    //NSLog(@"\n%@", [board textBoard]);
    
    XCTAssertTrue(game.gameOver);
    XCTAssertNotNil(game.winLine);
    
    XCTAssertTrue(GomokuPointEqualToPoint(game.winLine.from, GomokuPointMake(4, 4)));
    XCTAssertTrue(GomokuPointEqualToPoint(game.winLine.to, GomokuPointMake(0, 0)));
    XCTAssertTrue(game.winLine.stone == GomokuGameStoneX);
}

@end
