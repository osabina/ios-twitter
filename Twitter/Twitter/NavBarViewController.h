//
//  NavBarViewController.h
//  Twitter
//
//  Created by Osvaldo Sabina on 7/14/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MainViewController.h"

@interface NavBarViewController : UIViewController

@property (nonatomic, strong) AppDelegate *signout_delegate;
@property (nonatomic, strong) MainViewController *mainView;

@property (nonatomic) BOOL menuShowing;

@property (weak, nonatomic) IBOutlet UIView *navView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIView *fullView;

- (IBAction)pushNewButton:(id)sender;
- (IBAction)pushBurgerButton:(id)sender;

@end
