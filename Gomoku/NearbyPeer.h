//
//  NearbyPeer.h
//  Gomoku
//
//  Created by Vitaly Berg on 20/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearbyPeer : NSObject

@property (strong, nonatomic, readonly) NSString *uuid;
@property (strong, nonatomic, readonly) NSString *name;

- (instancetype)initWithUUID:(NSString *)uuid name:(NSString *)name;

@end
