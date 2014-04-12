//
//  GomokuGeometry.h
//  Gomoku
//
//  Created by Vitaly Berg on 12/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#ifndef GomokuGeometry_h
#define GomokuGeometry_h

typedef struct GomokuPoint {
    NSInteger x;
    NSInteger y;
} GomokuPoint;

typedef struct GomokuSize {
    NSInteger width;
    NSInteger height;
} GomokuSize;


static inline GomokuPoint GomokuPointMake(NSInteger x, NSInteger y);
static inline bool GomokuPointEqualToPoint(GomokuPoint point1, GomokuPoint point2);

static inline GomokuSize GomokuSizeMake(NSInteger width, NSInteger height);

static inline bool GomokuPointInBoundsOfSize(GomokuPoint point, GomokuSize size);


static inline GomokuPoint GomokuPointMake(NSInteger x, NSInteger y) {
    GomokuPoint p; p.x = x, p.y = y; return p;
}

static inline bool GomokuPointEqualToPoint(GomokuPoint p1, GomokuPoint p2) {
    return p1.x == p2.x && p1.y == p2.y;
}

static inline GomokuSize GomokuSizeMake(NSInteger width, NSInteger height) {
    GomokuSize s; s.width = width; s.height = height; return s;
}

static inline bool GomokuPointInBoundsOfSize(GomokuPoint point, GomokuSize size) {
    return point.x >= 0 && point.x < size.width && point.y >= 0 && point.y < size.height;
}

#endif
