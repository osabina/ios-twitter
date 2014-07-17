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



- (void)pushSignOutButton {
    [self.signout_delegate onSignOut];
}

- (void)pushNewButton {
    [self.navigationController pushViewController:[[ComposeViewController alloc] init] animated:YES];
}

- (void)pushBurgerButton {
    // stub - will bring out menu
    //    [self.navigationController pushViewController:[[ComposeViewController alloc] init] animated:YES];
}

- (void)setupNavBar {
    UINavigationBar *nb = self.navigationController.navigationBar;
    nb.tintColor = [UIColor whiteColor];
    nb.barTintColor = UIColorFromRGB(0x77b6e9);
    nb.barStyle = UIBarStyleBlack;
    
    id barButtonAppearance = [UIBarButtonItem appearance];
    NSMutableDictionary *barButtonTextAttributes = [NSMutableDictionary dictionaryWithCapacity:1];
    //    [barButtonTextAttributes setObject:[UIFont fontWithName:@"HelveticaNeue" size:14.0f] forKey:NSFontAttributeName];
    //    [barButtonTextAttributes setObject:[UIFont systemFontOfSize:13.0f] forKey:NSFontAttributeName];
    [barButtonTextAttributes setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName ];
    
    [barButtonAppearance setTitleTextAttributes:barButtonTextAttributes
                                       forState:UIControlStateNormal];
    [barButtonAppearance setTitleTextAttributes:barButtonTextAttributes
                                       forState:UIControlStateHighlighted];
    
    self.title = @"Home";
    //    UIBarButtonItem *twitterButton = [[UIBarButtonItem alloc]
    //                                      initWithImage:[UIImage imageNamed:@"Twitter"]
    //                                      style:UIBarButtonItemStylePlain target:self
    //                                      action:@selector(pushTwitterButton)];
    //    twitterButton.enabled = NO;
    
    UIImageView *twitterIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Twitter"]];
    [twitterIV setTintColor: [UIColor whiteColor]];
    
    
    UIBarButtonItem *burgerButton =  [[UIBarButtonItem alloc]
                                      initWithImage:[UIImage imageNamed:@"Burger"]
                                      style:UIBarButtonItemStylePlain target:self
                                      action:@selector(pushBurgerButton)];
    
    UIBarButtonItem *newButton =  [[UIBarButtonItem alloc]
                                   initWithImage:[UIImage imageNamed:@"Quill"]
                                   style:UIBarButtonItemStylePlain target:self
                                   action:@selector(pushNewButton)];
    
    
    //    UIBarButtonItem *signOutButton = [[UIBarButtonItem alloc]
    //                                      initWithTitle:@"Sign Out"
    //                                      style:UIBarButtonItemStylePlain
    //                                      target:self
    //                                      action:@selector(pushSignOutButton)];
    
    
    self.navigationItem.leftBarButtonItem = burgerButton;
    self.navigationItem.rightBarButtonItem = newButton;
    self.navigationItem.titleView = twitterIV;

}

- (IBAction)pushProfileButton:(id)sender {
    // do some animation shit
}

- (IBAction)pushTimelineButton:(id)sender {
    // do some animation shit
}

- (IBAction)pushMentionsButton:(id)sender {
    // do some animation shit
}

- (IBAction)pushLogoutButton:(id)sender {
    [self.signout_delegate onSignOut];
}
@end
