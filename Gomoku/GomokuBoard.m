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

- (BOOL)isPointInBoard:(GomokuBoardPoint)point {
    return GomokuBoardPointInBoundsOfSize(point, _size);
}

- (BOOL)containsStoneAtPoint:(GomokuBoardPoint)point {
    if (GomokuBoardPointInBoundsOfSize(point, _size)) {
        return _board[point.y][point.x] != EmptyStone;
    }
    return NO;
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
    
    // Scan: ⟶
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
    
    // Scan: ↓
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
    
    // Scan: ↗︎
    NSInteger lc = (h + w - 1) - (_lineLength - 1);
    for (NSInteger l = (_lineLength - 1); l < lc; l++) {
        c = 1;
        NSInteger x = MAX(0, l - h + 1);
        NSInteger y = MIN(h - 1, l);
        
        x++ ,y--;
        
        for (; y >= 0 && x < w; x++, y--) {
            if (_board[y][x] == _board[y + 1][x - 1]) {
                c++;
                if (c >= _lineLength) {
                    return nil;
                }
            } else {
                c = 1;
            }
        }
    }
    
    // Scan: ↖︎
    lc = (h + w - 1) - (_lineLength - 1);
    for (NSInteger l = (_lineLength - 1); l < lc; l++) {
        c = 1;
        NSInteger x = MIN(w - 1, l);   //MAX(0, l - h + 1);
        NSInteger y = (h - 1) - MAX(0, l - w + 1);
        
        x--, y--;
        
        for (; y >= 0 && x >= 0; x--, y--) {
            if (_board[y][x] == _board[y + 1][x + 1]) {
                c++;
                if (c >= _lineLength) {
                    return nil;
                }
            } else {
                c = 1;
            }
        }
    }
    
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
        memset(board[i], 0, sizeof(NSInteger) * size.width);
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
