//
//  MenuViewController.m
//  Twitter
//
//  Created by Osvaldo Sabina on 7/13/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import "MenuViewController.h"
#import "ComposeViewController.h"

#import "TwitterCommon.h"
#import "User.h"

#import <AFNetworking/UIImageView+AFNetworking.h>

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    User *me = [User currentUser];
    NSLog(@"current user: %@", me.handle);

    self.handleLabel.text = me.handle;
    self.nameLabel.text = me.name;
    [self.avatarImage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:me.imageURL]] placeholderImage:[UIImage imageNamed:@"placeholder"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        self.avatarImage.image = image;
        self.avatarImage.layer.masksToBounds = YES;
        self.avatarImage.layer.cornerRadius = 8.0;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"Failed to get profile view");
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pushProfileButton:(id)sender {
    NSLog(@"Profile button pushed");
    // do some animation shit
}

- (IBAction)pushTimelineButton:(id)sender {
    NSLog(@"Timeline button pushed");
    // do some animation shit
}

- (IBAction)pushMentionsButton:(id)sender {
    NSLog(@"Mentions button pushed");
    // do some animation shit
}

- (IBAction)onLogoutButton:(id)sender {
    NSLog(@"Logout pushed");
    [self.signout_delegate onSignOut];
}

@end
