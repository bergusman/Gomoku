//
//  UserDefaults.h
//  Gomoku
//
//  Created by Vitaly Berg on 20/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject

@property (strong, nonatomic) NSString *uuid;
@property (strong, nonatomic) NSString *name;

+ (UserDefaults *)sharedUserDefaults;

@end
