//
//  MainViewController.h
//  Twitter
//
//  Created by Osvaldo Sabina on 7/16/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface MainViewController : UIViewController

@property (nonatomic, strong) AppDelegate *signout_delegate;


@property (strong, nonatomic) IBOutlet UIView *navView;
@property (strong, nonatomic) IBOutlet UIView *contentView;

- (IBAction)onPanGesture:(UIPanGestureRecognizer *)sender;

- (void)showMenu;
- (void)showMenuWithSecs:(float)secs;
- (void)hideMenu;
- (void)hideMenuWithSecs:(float)secs;

@end
