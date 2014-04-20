//
//  NearbyPeer.m
//  Gomoku
//
//  Created by Vitaly Berg on 20/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "NearbyPeer.h"

@implementation NearbyPeer

- (instancetype)initWithUUID:(NSString *)uuid name:(NSString *)name {
    self = [super init];
    if (self) {
        _uuid = uuid;
        _name = name;
    }
    return self;
}

@end
