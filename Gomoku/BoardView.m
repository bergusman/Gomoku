//
//  BoardView.m
//  Gomoku
//
//  Created by Vitaly Berg on 12/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "BoardView.h"

@implementation BoardView

- (void)drawRect:(CGRect)rect {
    CGFloat w = self.boardWidth * self.cellSize.width;
    CGFloat h = self.boardHeight * self.cellSize.height;
    
    //[[UIColor blackColor] setStroke];
    [[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1] setStroke];
    
    for (int y = 1; y < self.boardHeight; y++) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, 0.25 + y * self.cellSize.height)];
        [path addLineToPoint:CGPointMake(w, 0.25 + y * self.cellSize.height)];
        path.lineWidth = 0.5;
        [path stroke];
    }
    
    for (int x = 1; x < self.boardWidth; x++) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0.25 + x * self.cellSize.width, 0)];
        [path addLineToPoint:CGPointMake(0.25 + x * self.cellSize.width, h)];
        path.lineWidth = 0.5;
        [path stroke];
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0.25, 0.25, w - 0.5, h - 0.5)];
    path.lineWidth = 0.5;
    [path stroke];
}

@end
