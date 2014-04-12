//
//  GomokuBoardGeometry.h
//  Gomoku
//
//  Created by Vitaly Berg on 12/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#ifndef GomokuBoardGeometry_h
#define GomokuBoardGeometry_h

typedef struct GomokuBoardPoint {
    NSInteger x;
    NSInteger y;
} GomokuBoardPoint;

typedef struct GomokuBoardSize {
    NSInteger width;
    NSInteger height;
} GomokuBoardSize;


static inline GomokuBoardPoint GomokuBoardPointMake(NSInteger x, NSInteger y);

static inline GomokuBoardSize GomokuBoardSizeMake(NSInteger width, NSInteger height);

static inline bool GomokuBoardPointInBoundsOfSize(GomokuBoardPoint point, GomokuBoardSize size);


static inline GomokuBoardPoint GomokuBoardPointMake(NSInteger x, NSInteger y) {
    GomokuBoardPoint p; p.x = x, p.y = y; return p;
}

static inline GomokuBoardSize GomokuBoardSizeMake(NSInteger width, NSInteger height) {
    GomokuBoardSize s; s.width = width; s.height = height; return s;
}

static inline bool GomokuBoardPointInBoundsOfSize(GomokuBoardPoint point, GomokuBoardSize size) {
    return point.x >= 0 && point.x < size.width && point.y >= 0 && point.y < size.height;
}

#endif
