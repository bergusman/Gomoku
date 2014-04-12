//
//  GomokuBoard.m
//  Gomoku
//
//  Created by Vitaly Berg on 12/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "GomokuBoard.h"

NSInteger const EmptyStone = 0;

@interface GomokuBoard () {
    NSInteger **_board;
    NSInteger _lineLength;
}

@end

@implementation GomokuBoard

- (void)putStone:(NSInteger)stone atPoint:(GomokuBoardPoint)point {
    if (GomokuBoardPointInBoundsOfSize(point, _size)) {
        _board[point.y][point.x] = stone;
    }
}

- (NSInteger)stoneAtPoint:(GomokuBoardPoint)point {
    if (GomokuBoardPointInBoundsOfSize(point, _size)) {
        return _board[point.y][point.x];
    }
    return EmptyStone;
}

- (NSUInteger)countOfStones:(NSInteger)stone {
    NSInteger w = _size.width;
    NSInteger h = _size.height;
    
    NSUInteger count = 0;
    
    for (NSInteger y = 0; y < h; y++) {
        for (NSInteger x = 0; x < w; x++) {
            if (_board[y][x] == stone) {
                count++;
            }
        }
    }
    
    return count;
}


- (GomokuBoardLine *)findFirstLine {
    NSInteger w = _size.width;
    NSInteger h = _size.height;
    NSInteger c = 0;
    
    // Horizontal rows
    for (NSInteger y = 0; y < h; y++) {
        c = 1;
        
        for (NSInteger x = 1; x < w; x++) {
            if (_board[y][x] == _board[y][x - 1]) {
                c++;
                if (c >= _lineLength) {
                    return nil;
                }
            } else {
                c = 1;
            }
        }
    }
    
    // Vertical rows
    for (NSInteger x = 0; x < w; x++) {
        c = 1;
        
        for (NSInteger y = 1; y < h; y++) {
            if (_board[y][x] == _board[y - 1][x]) {
                c++;
                if (c >= _lineLength) {
                    return nil;
                }
            } else {
                c = 1;
            }
        }
    }
    
    // General diagonal rows
    /*
    for (NSInteger y = 0; y < h; y++) {
        c = 1;
        
        for (NSInteger x = 1; x < w; x++) {
            if (_board[y][x] == _board[y][x - 1]) {
                c++;
                if (c >= _lineLength) {
                    return nil;
                }
            } else {
                c = 1;
            }
        }
    }
     */
    
    
    // Diagonal rows
    
    return nil;
}

- (NSArray *)findAllLines {
    return nil;
}

#pragma mark - Creation

+ (NSInteger **)allocBoardWithSize:(GomokuBoardSize)size {
    NSInteger **board = malloc(sizeof(NSInteger) * size.height);
    for (NSInteger i = 0; i < size.height; i++) {
        board[i] = malloc(sizeof(NSInteger) * size.width);
    }
    return board;
}

+ (void)deallocBoard:(NSInteger **)board withSize:(GomokuBoardSize)size {
    for (NSInteger i = 0; i < size.height; i++) {
        free(board[i]);
    }
    free(board);
}

- (instancetype)initWithSize:(GomokuBoardSize)size {
    if (size.width == 0 || size.height == 0) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        size.width = ABS(size.width);
        size.height = ABS(size.height);
        
        _size = size;
        _lineLength = 5;
        
        _board = [GomokuBoard allocBoardWithSize:size];
    }
    return self;
}

+ (GomokuBoard *)gomokuBoardWithSize:(GomokuBoardSize)size {
    return [[GomokuBoard alloc] initWithSize:size];
}

#pragma mark - Destruction

- (void)dealloc {
    [GomokuBoard deallocBoard:_board withSize:_size];
}

@end
