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

@interface RoomViewController ()

@property (strong, nonatomic) UIActivityIndicatorView *spinnerView;

@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

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

- (NSString *)name {
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"PlayerName"];
}

- (void)setName:(NSString *)name {
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"PlayerName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)showSettingsIfNoName {
    if ([self.name length] == 0) {
        [self showSettingsAnimated:NO];
    }
}

- (void)showSettingsAnimated:(BOOL)animated {
    SettingsViewController *settingsVC = [[SettingsViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:settingsVC];
    [self presentViewController:nc animated:animated completion:nil];
}

- (void)showGame {
    GameViewController *gameVC = [[GameViewController alloc] init];
    [self presentViewController:gameVC animated:YES completion:nil];
}

#pragma mark - Actions

- (void)settingsAction:(id)sender {
    [self showSettingsAnimated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell.accessoryView) {
        UIActivityIndicatorView *spinnerView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        cell.accessoryView = spinnerView;
        [spinnerView startAnimating];
    }
    
    if ([indexPath isEqual:self.selectedIndexPath]) {
        [((UIActivityIndicatorView *)cell.accessoryView) startAnimating];
    } else {
        [((UIActivityIndicatorView *)cell.accessoryView) stopAnimating];
    }

    cell.textLabel.text = @"Vitaly Berg";
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"CHOOSE PLAYER...";
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectedIndexPath = indexPath;
    [self.tableView reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.selectedIndexPath = nil;
        [self showGame];
    });
    
    // TODO: select player
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationItem];
    [self setupTableView];
    
    [self showSettingsIfNoName];
}

@end
