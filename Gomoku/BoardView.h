//
//  BoardView.h
//  Gomoku
//
//  Created by Vitaly Berg on 12/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoardView : UIView

@property (assign, nonatomic) NSUInteger boardWidth;
@property (assign, nonatomic) NSUInteger boardHeight;
@property (assign, nonatomic) CGSize cellSize;

@end
