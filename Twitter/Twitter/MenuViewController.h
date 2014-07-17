//
//  MenuViewController.h
//  Twitter
//
//  Created by Osvaldo Sabina on 7/13/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MenuViewController : UIViewController

@property (nonatomic, strong)AppDelegate *signout_delegate;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UIView *contentView;
- (IBAction)pushProfileButton:(id)sender;
- (IBAction)pushTimelineButton:(id)sender;
- (IBAction)pushMentionsButton:(id)sender;
- (IBAction)pushLogoutButton:(id)sender;


@end
