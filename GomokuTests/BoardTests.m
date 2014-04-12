//
//  BoardTests.m
//  Gomoku
//
//  Created by Vitaly Berg on 13/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "GomokuBoard.h"

@interface BoardTests : XCTestCase

@end

@implementation BoardTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testCountOfStones {
    GomokuBoard *board = [GomokuBoard gomokuBoardWithSize:GomokuSizeMake(20, 20)];
    [board putStone:3 atPoint:GomokuPointMake(0, 0)];
    [board putStone:3 atPoint:GomokuPointMake(10, 4)];
    [board putStone:3 atPoint:GomokuPointMake(2, 17)];
    [board putStone:3 atPoint:GomokuPointMake(8, 3)];
    [board putStone:4 atPoint:GomokuPointMake(18, 9)];
    [board putStone:4 atPoint:GomokuPointMake(3, 7)];
    [board putStone:5 atPoint:GomokuPointMake(0, 0)];
    [board putStone:5 atPoint:GomokuPointMake(13, 12)];
    [board putStone:5 atPoint:GomokuPointMake(11, 4)];
    [board putStone:7 atPoint:GomokuPointMake(11, 24)];
    [board putStone:7 atPoint:GomokuPointMake(23, 1)];
    [board putStone:7 atPoint:GomokuPointMake(0, -1)];
    [board putStone:7 atPoint:GomokuPointMake(-20, 0)];
    [board putStone:7 atPoint:GomokuPointMake(20, 20)];
    
    XCTAssertTrue([board countOfStones:3] == 3);
    XCTAssertTrue([board countOfStones:4] == 2);
    XCTAssertTrue([board countOfStones:5] == 3);
    XCTAssertTrue([board countOfStones:7] == 0);
    XCTAssertTrue([board countOfStones:0] == (20 * 20 - 3 - 2 - 3));
}

- (void)testPutStone {
    GomokuBoard *board = [GomokuBoard gomokuBoardWithSize:GomokuSizeMake(20, 20)];
    
    [board putStone:4 atPoint:GomokuPointMake(19, 19)];
    XCTAssertTrue([board stoneAtPoint:GomokuPointMake(19, 19)] == 4);
    
    [board putStone:5 atPoint:GomokuPointMake(19, 19)];
    XCTAssertTrue([board stoneAtPoint:GomokuPointMake(19, 19)] == 5);
    
    BOOL result = [board putStone:4 atPoint:GomokuPointMake(20, 20)];
    XCTAssertFalse(result);
    
    result = [board putStone:4 atPoint:GomokuPointMake(-1, -1)];
    XCTAssertFalse(result);
    
    result = [board putStone:7 atPoint:GomokuPointMake(4, 4)];
    XCTAssertTrue(result);
}

- (void)testFindFirstLine {
    GomokuBoard *board;
    GomokuLine *line;
    
    // ⟶
    board = [self horizontalBoard];
    [board putStone:8 atPoint:GomokuPointMake(0, 0)];
    [board putStone:8 atPoint:GomokuPointMake(1, 0)];
    [board putStone:8 atPoint:GomokuPointMake(2, 0)];
    [board putStone:8 atPoint:GomokuPointMake(3, 0)];
    line = [board findFirstLine];
    XCTAssertNil(line);
    
    [board putStone:8 atPoint:GomokuPointMake(4, 0)];
    line = [board findFirstLine];
    XCTAssertTrue(line.stone == 8 &&
                  GomokuPointEqualToPoint(line.from, GomokuPointMake(0, 0)) &&
                  GomokuPointEqualToPoint(line.to, GomokuPointMake(4, 0)));
    
    board = [self horizontalBoard];
    [board putStone:8 atPoint:GomokuPointMake(7, 5)];
    [board putStone:8 atPoint:GomokuPointMake(8, 5)];
    [board putStone:8 atPoint:GomokuPointMake(9, 5)];
    [board putStone:8 atPoint:GomokuPointMake(10, 5)];
    [board putStone:8 atPoint:GomokuPointMake(11, 5)];
    line = [board findFirstLine];
    XCTAssertTrue(line.stone == 8 &&
                  GomokuPointEqualToPoint(line.from, GomokuPointMake(7, 5)) &&
                  GomokuPointEqualToPoint(line.to, GomokuPointMake(11, 5)));
    
    [board putStone:8 atPoint:GomokuPointMake(6, 5)];
    line = [board findFirstLine];
    XCTAssertTrue(line.stone == 8 &&
                  GomokuPointEqualToPoint(line.from, GomokuPointMake(6, 5)) &&
                  GomokuPointEqualToPoint(line.to, GomokuPointMake(10, 5)));
    
    // ↓
    board = [self horizontalBoard];
    [board putStone:8 atPoint:GomokuPointMake(11, 1)];
    [board putStone:8 atPoint:GomokuPointMake(11, 2)];
    [board putStone:8 atPoint:GomokuPointMake(11, 3)];
    [board putStone:8 atPoint:GomokuPointMake(11, 4)];
    line = [board findFirstLine];
    XCTAssertNil(line);
    
    [board putStone:8 atPoint:GomokuPointMake(11, 5)];
    line = [board findFirstLine];
    XCTAssertTrue(line.stone == 8 &&
                  GomokuPointEqualToPoint(line.from, GomokuPointMake(11, 1)) &&
                  GomokuPointEqualToPoint(line.to, GomokuPointMake(11, 5)));
    
    
    [board putStone:8 atPoint:GomokuPointMake(11, 0)];
    line = [board findFirstLine];
    XCTAssertTrue(line.stone == 8 &&
                  GomokuPointEqualToPoint(line.from, GomokuPointMake(11, 0)) &&
                  GomokuPointEqualToPoint(line.to, GomokuPointMake(11, 4)));
    
    // ↗︎
    board = [self horizontalBoard];
    [board putStone:8 atPoint:GomokuPointMake(0, 4)];
    [board putStone:8 atPoint:GomokuPointMake(1, 3)];
    [board putStone:8 atPoint:GomokuPointMake(2, 2)];
    [board putStone:8 atPoint:GomokuPointMake(3, 1)];
    line = [board findFirstLine];
    XCTAssertNil(line);
    
    [board putStone:8 atPoint:GomokuPointMake(4, 0)];
    line = [board findFirstLine];
    XCTAssertTrue(line.stone == 8 &&
                  GomokuPointEqualToPoint(line.from, GomokuPointMake(0, 4)) &&
                  GomokuPointEqualToPoint(line.to, GomokuPointMake(4, 0)));
    
    board = [self horizontalBoard];
    [board putStone:8 atPoint:GomokuPointMake(7, 5)];
    [board putStone:8 atPoint:GomokuPointMake(8, 4)];
    [board putStone:8 atPoint:GomokuPointMake(9, 3)];
    [board putStone:8 atPoint:GomokuPointMake(10, 2)];
    line = [board findFirstLine];
    XCTAssertNil(line);
    
    [board putStone:8 atPoint:GomokuPointMake(11, 1)];
    line = [board findFirstLine];
    XCTAssertTrue(line.stone == 8 &&
                  GomokuPointEqualToPoint(line.from, GomokuPointMake(7, 5)) &&
                  GomokuPointEqualToPoint(line.to, GomokuPointMake(11, 1)));
    
    board = [self verticalBoard];
    [board putStone:8 atPoint:GomokuPointMake(0, 11)];
    [board putStone:8 atPoint:GomokuPointMake(1, 10)];
    [board putStone:8 atPoint:GomokuPointMake(2, 9)];
    [board putStone:8 atPoint:GomokuPointMake(3, 8)];
    [board putStone:8 atPoint:GomokuPointMake(4, 7)];
    line = [board findFirstLine];
    XCTAssertTrue(line.stone == 8 &&
                  GomokuPointEqualToPoint(line.from, GomokuPointMake(0, 11)) &&
                  GomokuPointEqualToPoint(line.to, GomokuPointMake(4, 7)));
    
    // ↖︎
    board = [self horizontalBoard];
    [board putStone:8 atPoint:GomokuPointMake(0, 0)];
    [board putStone:8 atPoint:GomokuPointMake(1, 1)];
    [board putStone:8 atPoint:GomokuPointMake(2, 2)];
    [board putStone:8 atPoint:GomokuPointMake(3, 3)];
    [board putStone:8 atPoint:GomokuPointMake(4, 4)];
    line = [board findFirstLine];
    XCTAssertTrue(line.stone == 8 &&
                  GomokuPointEqualToPoint(line.from, GomokuPointMake(4, 4)) &&
                  GomokuPointEqualToPoint(line.to, GomokuPointMake(0, 0)));
    
    
    [board putStone:8 atPoint:GomokuPointMake(5, 5)];
    line = [board findFirstLine];
    XCTAssertTrue(line.stone == 8 &&
                  GomokuPointEqualToPoint(line.from, GomokuPointMake(5, 5)) &&
                  GomokuPointEqualToPoint(line.to, GomokuPointMake(1, 1)));
    
    board = [self verticalBoard];
    [board putStone:8 atPoint:GomokuPointMake(0, 7)];
    [board putStone:8 atPoint:GomokuPointMake(1, 8)];
    [board putStone:8 atPoint:GomokuPointMake(2, 9)];
    [board putStone:8 atPoint:GomokuPointMake(3, 10)];
    [board putStone:8 atPoint:GomokuPointMake(4, 11)];
    line = [board findFirstLine];
    XCTAssertTrue(line.stone == 8 &&
                  GomokuPointEqualToPoint(line.from, GomokuPointMake(4, 11)) &&
                  GomokuPointEqualToPoint(line.to, GomokuPointMake(0, 7)));
}

- (GomokuBoard *)horizontalBoard {
    GomokuBoard *board = [GomokuBoard gomokuBoardWithSize:GomokuSizeMake(12, 6)];
    return board;
}

- (GomokuBoard *)verticalBoard {
    GomokuBoard *board = [GomokuBoard gomokuBoardWithSize:GomokuSizeMake(6, 12)];
    return board;
}

@end
