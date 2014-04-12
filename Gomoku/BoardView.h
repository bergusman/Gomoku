//
//  BoardView.h
//  Gomoku
//
//  Created by Vitaly Berg on 12/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GomokuGeometry.h"
#import "NSValue+GomokuGeometry.h"

@interface BoardView : UIView

@property (assign, nonatomic) GomokuSize boardSize;
@property (assign, nonatomic) CGSize cellSize;

@property (strong, nonatomic) UIColor *highlightedColor;
@property (strong, nonatomic) NSArray *highlightedCells; // Array of NSValue with GomokuPoint (+[NSValue valueWithGomokuPoint:])

@end
