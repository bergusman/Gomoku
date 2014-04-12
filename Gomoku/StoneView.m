//
//  StoneView.m
//  Gomoku
//
//  Created by Vitaly Berg on 12/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "StoneView.h"

@implementation StoneView

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    UILabel *label = [[UILabel alloc] init];
    label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    label.frame = self.bounds;
    label.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:24];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    
    self.label = label;
}

@end
