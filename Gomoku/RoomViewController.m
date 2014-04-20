//
//  RoomViewController.m
//  Gomoku
//
//  Created by Vitaly Berg on 16/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "RoomViewController.h"

#import "SettingsViewController.h"
#import "GameViewController.h"

#import "RoomSession.h"
#import "GameSession.h"

@interface RoomViewController () <RoomSessionDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UIActivityIndicatorView *spinnerView;

@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@property (strong, nonatomic) RoomSession *roomSession;

@property (strong, nonatomic) UIAlertView *invitationAlertView;
@property (copy, nonatomic) void (^invitationHandler)(BOOL accept);

@property (assign, nonatomic) BOOL master;

@end

@implementation RoomViewController

#pragma mark - Setups

- (void)setupNavigationItem {
    self.navigationItem.title = @"Room";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(settingsAction:)];
}

- (void)setupTableView {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.spinnerView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinnerView.center = CGPointMake(164, 40);
    [self.tableView addSubview:self.spinnerView];
    [self.spinnerView startAnimating];
}

#pragma mark - Content

/*
- (void)showSettingsIfNoName {
    if ([self.name length] == 0) {
        [self showSettingsAnimated:NO];
    }
}
 */

- (void)showSettingsAnimated:(BOOL)animated {
    SettingsViewController *settingsVC = [[SettingsViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:settingsVC];
    [self presentViewController:nc animated:animated completion:nil];
}

- (void)showGameWithPeer:(NearbyPeer *)peer {
    GameSession *gameSession = [[GameSession alloc] initWithService:[AppDelegate sharedAppDelegate].nearbyService master:self.master];
    gameSession.opponentUUID = peer.uuid;
    GameViewController *gameVC = [[GameViewController alloc] init];
    gameVC.gameSession = gameSession;
    [self presentViewController:gameVC animated:YES completion:nil];
}

- (void)createRoomSession {
    self.roomSession = [[RoomSession alloc] initWithService:[AppDelegate sharedAppDelegate].nearbyService];
    self.roomSession.delegate = self;
    [self.roomSession start];
}

#pragma mark - RoomSessionDelegate

- (void)roomSessionDidUpdatePeers:(RoomSession *)session {
    [self.tableView reloadData];
}

- (void)roomSession:(RoomSession *)session didReceiveInvitationFromPeer:(NearbyPeer *)peer invitationHandler:(void(^)(BOOL accept))invitationHandler {
    [self.invitationAlertView dismissWithClickedButtonIndex:0 animated:YES];
    if (self.invitationHandler) {
        self.invitationHandler(NO);
    }
    
    NSString *message = [NSString stringWithFormat:@"Would you like to play with %@", peer.name];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invitation"
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK", nil];
    
    self.invitationAlertView = alertView;
    self.invitationHandler = invitationHandler;
    
    [alertView show];
}

- (void)roomSession:(RoomSession *)session peer:(NearbyPeer *)peer didChangeState:(MCSessionState)state {
    NSLog(@"%s", __func__);
    [self.roomSession stop];
    [self showGameWithPeer:peer];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        if (self.invitationHandler) {
            self.invitationHandler(YES);
        }
    } else {
        if (self.invitationHandler) {
            self.invitationHandler(NO);
        }
    }
}

#pragma mark - Actions

- (void)settingsAction:(id)sender {
    [self showSettingsAnimated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.roomSession.peers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell.accessoryView) {
        UIActivityIndicatorView *spinnerView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        cell.accessoryView = spinnerView;
        //[spinnerView startAnimating];
    }
    
    NearbyPeer *peer = self.roomSession.peers[indexPath.row];
    cell.textLabel.text = peer.name;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"CHOOSE PLAYER...";
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NearbyPeer *peer = self.roomSession.peers[indexPath.row];
    [self.roomSession invitePeer:peer];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationItem];
    [self setupTableView];
    
    [self createRoomSession];
    
    //[self showSettingsIfNoName];
}

@end
