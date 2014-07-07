//
//  TweetViewController.m
//  Twitter
//
//  Created by Osvaldo Sabina on 7/6/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import "TwitterCommon.h"
#import "TweetViewController.h"

@interface TweetViewController ()

- (void)pushReplyButton;

@end

@implementation TweetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [self setupNavBar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.replyImage.image = [UIImage imageNamed:@"Reply"];
    self.retweetImage.image = [UIImage imageNamed:@"Retweet"];
    self.favoriteImage.image = [UIImage imageNamed:@"Favorite"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushReplyButton {
    // stub
}

- (void)setupNavBar {

    self.title = @"Tweet";
    UIBarButtonItem *replyButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Reply"
                                    style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(pushReplyButton)];
    
    self.navigationItem.rightBarButtonItem = replyButton;
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
    
    
    
}

// navigation view controller delegate methods
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [viewController viewWillAppear:animated];
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [viewController viewDidAppear:animated];
}


@end
