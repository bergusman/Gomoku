//
//  AppDelegate.m
//  Gomoku
//
//  Created by Vitaly Berg on 12/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "AppDelegate.h"

#import "RoomViewController.h"

#import "UserDefaults.h"

@implementation AppDelegate

#pragma mark - Content

- (void)setupUUID {
    if (![UserDefaults sharedUserDefaults].uuid) {
        NSUUID *uuid = [NSUUID UUID];
        [UserDefaults sharedUserDefaults].uuid = [uuid UUIDString];
    }
}

- (void)setupName {
    if (![UserDefaults sharedUserDefaults].name) {
        NSString *name = [UIDevice currentDevice].name;
        [UserDefaults sharedUserDefaults].name = name;
    }
}

- (void)setupNearbyService {
    self.nearbyService = [NearbyService nearbyServiceWithUUID:[UserDefaults sharedUserDefaults].uuid type:@"gomoku"];
    self.nearbyService.name = [UserDefaults sharedUserDefaults].name;
}

- (void)setupWindow {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
}

- (void)showRoomVC {
    RoomViewController *roomVC = [[RoomViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:roomVC];
    self.window.rootViewController = nc;
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupUUID];
    [self setupName];
    [self setupNearbyService];
    [self setupWindow];
    [self showRoomVC];
    return YES;
}

#pragma mark - Singleton

+ (AppDelegate *)sharedAppDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

@end
