//
//  GameViewController.h
//  Gomoku
//
//  Created by Vitaly Berg on 12/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameSession;

@interface GameViewController : UIViewController

@property (strong, nonatomic) GameSession *gameSession;

@end
