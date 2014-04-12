//
//  GomokuBoard.m
//  Gomoku
//
//  Created by Vitaly Berg on 12/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "GomokuBoard.h"

NSInteger const EmptyStone = 0;


@implementation GomokuLine

- (instancetype)initWithStone:(NSInteger)stone from:(GomokuPoint)from to:(GomokuPoint)to {
    self = [super init];
    if (self) {
        _stone = stone;
        _from = from;
        _to = to;
    }
    return self;
}

+ (GomokuLine *)gomokuLineWithStone:(NSInteger)stone from:(GomokuPoint)from to:(GomokuPoint)to {
    return [[GomokuLine alloc] initWithStone:stone from:from to:to];
}

@end


@interface GomokuBoard () {
    NSInteger **_board;
    NSInteger _lineLength;
}

@end

@implementation GomokuBoard

- (BOOL)putStone:(NSInteger)stone atPoint:(GomokuPoint)point {
    if (GomokuPointInBoundsOfSize(point, _size)) {
        _board[point.y][point.x] = stone;
        return YES;
    }
    return NO;
}

- (NSInteger)stoneAtPoint:(GomokuPoint)point {
    if (GomokuPointInBoundsOfSize(point, _size)) {
        return _board[point.y][point.x];
    }
    return EmptyStone;
}

- (BOOL)isPointInBoard:(GomokuPoint)point {
    return GomokuPointInBoundsOfSize(point, _size);
}

- (BOOL)containsStoneAtPoint:(GomokuPoint)point {
    if (GomokuPointInBoundsOfSize(point, _size)) {
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

- (GomokuLine *)findFirstLine {
    return [[self findLinesReturnFirst:YES] firstObject];
}

- (NSArray *)findAllLines {
    NSArray *result = [self findLinesReturnFirst:NO];
    return [result count] > 0 ? result : nil;
}

- (NSArray *)findLinesReturnFirst:(BOOL)first {
    NSMutableArray *lines = [NSMutableArray array];
    
    NSInteger w = _size.width;
    NSInteger h = _size.height;
    NSInteger c = 0;
    
    // Scan: ⟶
    for (NSInteger y = 0; y < h; y++) {
        c = 1;
        
        for (NSInteger x = 1; x < w; x++) {
            if (_board[y][x] != EmptyStone && _board[y][x] == _board[y][x - 1]) {
                c++;
                if (c >= _lineLength) {
                    GomokuLine *line = [GomokuLine gomokuLineWithStone:_board[y][x]
                                                                  from:GomokuPointMake(x - _lineLength + 1, y)
                                                                    to:GomokuPointMake(x, y)];
                    if (first) {
                        return @[line];
                    } else {
                        [lines addObject:line];
                    }
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
            if (_board[y][x] != EmptyStone && _board[y][x] == _board[y - 1][x]) {
                c++;
                if (c >= _lineLength) {
                    GomokuLine *line = [GomokuLine gomokuLineWithStone:_board[y][x]
                                                                  from:GomokuPointMake(x, y - _lineLength + 1)
                                                                    to:GomokuPointMake(x, y)];
                    if (first) {
                        return @[line];
                    } else {
                        [lines addObject:line];
                    }
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
            if (_board[y][x] != EmptyStone && _board[y][x] == _board[y + 1][x - 1]) {
                c++;
                if (c >= _lineLength) {
                    GomokuLine *line = [GomokuLine gomokuLineWithStone:_board[y][x]
                                                                  from:GomokuPointMake(x - _lineLength + 1, y + _lineLength - 1)
                                                                    to:GomokuPointMake(x, y)];
                    if (first) {
                        return @[line];
                    } else {
                        [lines addObject:line];
                    }
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
        NSInteger x = MIN(w - 1, l);
        NSInteger y = (h - 1) - MAX(0, l - w + 1);
        
        x--, y--;
        
        for (; y >= 0 && x >= 0; x--, y--) {
            if (_board[y][x] != EmptyStone && _board[y][x] == _board[y + 1][x + 1]) {
                c++;
                if (c >= _lineLength) {
                    GomokuLine *line = [GomokuLine gomokuLineWithStone:_board[y][x]
                                                                  from:GomokuPointMake(x + _lineLength - 1, y + _lineLength - 1)
                                                                    to:GomokuPointMake(x, y)];
                    if (first) {
                        return @[line];
                    } else {
                        [lines addObject:line];
                    }
                }
            } else {
                c = 1;
            }
        }
    }
    
    return lines;
}

#pragma mark - Creation

+ (NSInteger **)allocBoardWithSize:(GomokuSize)size {
    NSInteger **board = malloc(sizeof(NSInteger *) * size.height);
    for (NSInteger i = 0; i < size.height; i++) {
        board[i] = malloc(sizeof(NSInteger) * size.width);
        memset(board[i], 0, sizeof(NSInteger) * size.width);
    }
    return board;
}

+ (void)deallocBoard:(NSInteger **)board withSize:(GomokuSize)size {
    for (NSInteger i = 0; i < size.height; i++) {
        free(board[i]);
    }
    free(board);
}

- (instancetype)initWithSize:(GomokuSize)size {
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

+ (GomokuBoard *)gomokuBoardWithSize:(GomokuSize)size {
    return [[GomokuBoard alloc] initWithSize:size];
}

#pragma mark - Destruction

- (void)dealloc {
    [GomokuBoard deallocBoard:_board withSize:_size];
}

@end
