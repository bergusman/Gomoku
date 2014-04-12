//
//  NSValue+GomokuGeometry.h
//  Gomoku
//
//  Created by Vitaly Berg on 13/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GomokuGeometry.h"

@interface NSValue (GomokuGeometry)

+ (NSValue *)valueWithGomokuPoint:(GomokuPoint)point;
+ (NSValue *)valueWithGomokuSize:(GomokuSize)size;

- (GomokuPoint)GomokuPointValue;
- (GomokuSize)GomokuSizeValue;

@end
