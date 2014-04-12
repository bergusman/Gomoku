//
//  BoardView.m
//  Gomoku
//
//  Created by Vitaly Berg on 12/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "BoardView.h"

@implementation BoardView

#pragma mark - Content

- (void)setHighlightedColor:(UIColor *)highlightedColor {
    _highlightedColor = highlightedColor;
    [self setNeedsDisplay];
}

- (void)setHighlightedCells:(NSArray *)highlightedCells {
    _highlightedCells = highlightedCells;
    [self setNeedsDisplay];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGFloat cw = self.cellSize.width;
    CGFloat ch = self.cellSize.height;
    
    CGFloat w = self.boardSize.width * cw;
    CGFloat h = self.boardSize.height * ch;
    
    [self.highlightedColor setFill];
    for (NSValue *value in self.highlightedCells) {
        GomokuPoint point = [value GomokuPointValue];
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(point.x * cw, point.y * ch, cw, ch)];
        [path fill];
    }
    
    [[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1] setStroke];
    
    for (int y = 1; y < self.boardSize.height; y++) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, 0.25 + y * ch)];
        [path addLineToPoint:CGPointMake(w, 0.25 + y * ch)];
        path.lineWidth = 0.5;
        [path stroke];
    }
    
    for (int x = 1; x < self.boardSize.width; x++) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0.25 + x * cw, 0)];
        [path addLineToPoint:CGPointMake(0.25 + x * cw, h)];
        path.lineWidth = 0.5;
        [path stroke];
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0.25, 0.25, w - 0.5, h - 0.5)];
    path.lineWidth = 0.5;
    [path stroke];
}

@end
