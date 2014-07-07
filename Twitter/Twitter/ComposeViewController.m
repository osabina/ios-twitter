//
//  ComposeViewController.m
//  Twitter
//
//  Created by Osvaldo Sabina on 7/6/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import "ComposeViewController.h"
#import "TwitterCommon.h"
#import "TweetViewController.h"

@interface ComposeViewController ()

- (void)pushCancelButton;
- (void)pushTweetButton;
- (void)setupNavBar;

@end

@implementation ComposeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom stuff
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [self setupNavBar];
    self.tweetTextView.text = @"";
    [self.tweetTextView becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupNavBar {
    id barButtonAppearance = [UIBarButtonItem appearance];
    NSMutableDictionary *barButtonTextAttributes = [NSMutableDictionary dictionaryWithCapacity:1];
    //    [barButtonTextAttributes setObject:[UIFont fontWithName:@"HelveticaNeue" size:14.0f] forKey:NSFontAttributeName];
    //    [barButtonTextAttributes setObject:[UIFont systemFontOfSize:13.0f] forKey:NSFontAttributeName];
    [barButtonTextAttributes setObject: UIColorFromRGB(0x77b6e9) forKey:NSForegroundColorAttributeName ];
    
    [barButtonAppearance setTitleTextAttributes:barButtonTextAttributes
                                       forState:UIControlStateNormal];
    [barButtonAppearance setTitleTextAttributes:barButtonTextAttributes
                                       forState:UIControlStateHighlighted];
    
    UINavigationController *nvc = self.navigationController;
    nvc.navigationBar.barStyle = UIBarStyleDefault;
    nvc.navigationBar.barTintColor = UIColorFromRGB(0xf9f9f9);
    nvc.navigationBar.tintColor = UIColorFromRGB(0x77b6e9);
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Cancel"
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(pushCancelButton)];
    
    UIBarButtonItem *tweetButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Tweet"
                                    style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(pushTweetButton)];
    
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.rightBarButtonItem = tweetButton;
    
    
}
    
- (void)pushCancelButton {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)pushTweetButton {
    NSLog(@"Tweet Tweet");
    // This is temp for testing
    [self.navigationController pushViewController:[[TweetViewController alloc] init] animated:YES];
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
