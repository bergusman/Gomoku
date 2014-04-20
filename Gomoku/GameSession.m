//
//  GameSession.m
//  Gomoku
//
//  Created by Vitaly Berg on 20/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "GameSession.h"

@interface GameSession () <NearbyServiceDelegate>

@property (strong, nonatomic) NearbyService *service;

@end

@implementation GameSession

- (void)startWithOpponentStone:(NSString *)stone {

   
}

- (void)makeStepAtX:(NSInteger)x Y:(NSInteger)y {
    
}


#pragma mark - NearbyServiceDelegate

- (void)nearbyService:(NearbyService *)service didReceiveData:(NSData *)data fromPeer:(NearbyPeer *)peer {
    NSLog(@"%s", __func__);
}

#pragma mark - Init

- (instancetype)initWithService:(NearbyService *)service master:(BOOL)master {
    self = [super init];
    if (self) {
        _service = service;
        _master = master;
        
        _service.delegate = self;
    }
    return self;
}

@end
