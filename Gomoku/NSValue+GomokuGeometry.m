//
//  NSValue+GomokuGeometry.m
//  Gomoku
//
//  Created by Vitaly Berg on 13/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "NSValue+GomokuGeometry.h"

@implementation NSValue (GomokuGeometry)

+ (NSValue *)valueWithGomokuPoint:(GomokuPoint)point {
    return [NSValue valueWithBytes:&point objCType:@encode(GomokuPoint)];
}

+ (NSValue *)valueWithGomokuSize:(GomokuSize)size {
    return [NSValue valueWithBytes:&size objCType:@encode(GomokuSize)];
}

- (GomokuPoint)GomokuPointValue {
    GomokuPoint point;
    [self getValue:&point];
    return point;
}

- (GomokuSize)GomokuSizeValue {
    GomokuSize size;
    [self getValue:&size];
    return size;
}

@end
