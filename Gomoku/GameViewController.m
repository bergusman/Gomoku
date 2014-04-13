//
//  GameViewController.m
//  Gomoku
//
//  Created by Vitaly Berg on 12/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "GameViewController.h"

#import "BoardView.h"
#import "StoneView.h"

#import "GomokuBoard.h"

typedef NS_ENUM(NSInteger, GameState) {
    GameStateNone,
    GameStatePlaying,
    GameStateGameOver
};

@interface GameViewController ()

@property (weak, nonatomic) IBOutlet BoardView *boardView;
@property (strong, nonatomic) NSMutableArray *stoneViews;

@property (strong, nonatomic) GomokuBoard *board;

@property (assign, nonatomic) BOOL firstPlayerStep;
@property (assign, nonatomic) GameState gameState;

@end

@implementation GameViewController

#pragma mark - Setups

- (void)setupBoard {
    self.boardView.boardSize = GomokuSizeMake(10, 10);
    self.boardView.cellSize = CGSizeMake(32, 32);
}

#pragma mark - Content

- (void)resetGame {
    [self.stoneViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.stoneViews = [NSMutableArray array];
    self.board = [GomokuBoard gomokuBoardWithSize:GomokuSizeMake(10, 10)];
    self.boardView.highlightedCells = nil;
    
    self.gameState = GameStatePlaying;
}

- (void)makeStepWithPoint:(GomokuPoint)point {
    if (self.gameState != GameStatePlaying) {
        return;
    }
    
    if (![self.board isPointInBoard:point]) {
        return;
    }
    
    if ([self.board stoneAtPoint:point] == EmptyStone) {
        NSInteger stone = self.firstPlayerStep ? 1 : 2;
        self.firstPlayerStep = !self.firstPlayerStep;
        
        [self.board putStone:stone atPoint:point];
        
        StoneView *stoneView = [[StoneView alloc] init];
        stoneView.frame = CGRectMake(point.x * 32, point.y * 32, 32, 32);
        [self.boardView addSubview:stoneView];
        
        stoneView.label.text = stone == 1 ? @"X" : @"O";
        stoneView.label.textColor = stone == 1 ? RGB(220, 0, 0) : RGB(0, 100, 255);
        
        [self.stoneViews addObject:stoneView];
        
        GomokuLine *line = [self.board findFirstLine];
        if (line) {
            NSMutableArray *points = [NSMutableArray arrayWithCapacity:5];
            
            NSInteger dy = (line.to.y - line.from.y) / 4;
            NSInteger dx = (line.to.x - line.from.x) / 4;
            
            NSInteger x = line.from.x;
            NSInteger y = line.from.y;
            
            for (int i = 0; i < 5; i++) {
                [points addObject:[NSValue valueWithGomokuPoint:GomokuPointMake(x, y)]];
                
                x += dx;
                y += dy;
            }
            
            self.boardView.highlightedColor = [(line.stone == 1 ? RGB(220, 0, 0) : RGB(0, 100, 255)) colorWithAlphaComponent:0.2];
            self.boardView.highlightedCells = points;
            
            self.gameState = GameStateGameOver;
        }
    }
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    CGPoint location = [tap locationInView:self.boardView];
    
    GomokuPoint point = GomokuPointMake(location.x / 32, location.y / 32);
    [self makeStepWithPoint:point];
}

#pragma mark - Actions

- (IBAction)resetButtonTouchUpInside:(id)sender {
    [self resetGame];
}

- (IBAction)tap:(UITapGestureRecognizer *)tap {
    [self handleTap:tap];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBoard];
    [self resetGame];
}

@end
