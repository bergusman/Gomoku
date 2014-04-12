//
//  AppDelegate.m
//  Gomoku
//
//  Created by Vitaly Berg on 12/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "AppDelegate.h"

#import "GomokuBoard.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    GomokuBoard *board = [GomokuBoard gomokuBoardWithSize:GomokuBoardSizeMake(10, 10)];
    [board putStone:1 atPoint:GomokuBoardPointMake(1, 0)];
    [board putStone:1 atPoint:GomokuBoardPointMake(2, 0)];
    [board putStone:1 atPoint:GomokuBoardPointMake(3, 0)];
    [board putStone:1 atPoint:GomokuBoardPointMake(4, 0)];
    [board putStone:1 atPoint:GomokuBoardPointMake(5, 0)];
    [board findFirstLine];
    
    return YES;
}

@end
