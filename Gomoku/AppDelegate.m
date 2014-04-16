//
//  AppDelegate.m
//  Gomoku
//
//  Created by Vitaly Berg on 12/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "AppDelegate.h"

#import "RoomViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];

    RoomViewController *roomVC = [[RoomViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:roomVC];
    self.window.rootViewController = nc;

    return YES;
}

@end
