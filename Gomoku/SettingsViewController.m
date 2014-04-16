//
//  SettingsViewController.m
//  Gomoku
//
//  Created by Vitaly Berg on 16/04/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController () <UITextFieldDelegate>

@property (strong, nonatomic) UIBarButtonItem *doneBarButtonItem;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (assign, nonatomic) BOOL withCancelButton;

@end

@implementation SettingsViewController

#pragma mark - Setups

- (void)setupNavigationItem {
    self.navigationItem.title = @"Settings";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(cancelAction:)];
    
    self.doneBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                           target:self
                                                                           action:@selector(doneAction:)];
    self.navigationItem.rightBarButtonItem = self.doneBarButtonItem;
}

#pragma mark - Content

- (NSString *)name {
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"PlayerName"];
}

- (void)setName:(NSString *)name {
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"PlayerName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)fillForm {
    self.nameTextField.text = self.name;
    if ([self.name length] == 0) {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (BOOL)isNameTextFieldValid {
    return [self.nameTextField.text length] > 0;
}

- (void)validateForm {
    self.doneBarButtonItem.enabled = [self isNameTextFieldValid];
}

#pragma mark - Actions

- (void)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doneAction:(id)sender {
    self.name = self.nameTextField.text;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)nameTextFieldEditingChanged:(id)sender {
    [self validateForm];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationItem];
    [self fillForm];
    [self validateForm];
    
    [self.nameTextField becomeFirstResponder];
}

@end
