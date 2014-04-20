//
//  UserDefaults.m
//  Gomoku
//
//  Created by Vitaly Berg on 20/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "UserDefaults.h"

@implementation UserDefaults

#pragma mark - uuid

- (NSString *)uuid {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"GomokuUUID"];
}

- (void)setUuid:(NSString *)uuid {
    [[NSUserDefaults standardUserDefaults] setObject:uuid forKey:@"GomokuUUID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - name

- (NSString *)name {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"GomokuPlayerName"];
}

- (void)setName:(NSString *)name {
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"GomokuPlayerName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Singleton

+ (UserDefaults *)sharedUserDefaults {
    static UserDefaults *_userDefaults;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _userDefaults = [[UserDefaults alloc] init];
    });
    
    return _userDefaults;
}

@end
