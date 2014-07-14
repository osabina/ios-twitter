//
//  ComposeViewController.m
//  Twitter
//
//  Created by Osvaldo Sabina on 7/6/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import "Tweet.h"
#import "TwitterCommon.h"
#import "TwitterClient.h"

#import "ComposeViewController.h"
#import "TweetViewController.h"

#import <AFNetworking/UIImageView+AFNetworking.h>


@interface ComposeViewController ()

@property (strong, nonatomic) Tweet *tweet;

- (void)pushCancelButton;
- (void)pushTweetButton;
- (void)setupNavBar;

@end

@implementation ComposeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _is_reply = NO;
        _is_retweet = NO;
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
    [self setupView: self.userInfo];
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

- (void)setupView:(NSDictionary*)userInfo {
    // I don't know why this is not displaying!!
    self.nameLabel.text = @"Oz"; // userInfo[@"name"];
    self.handleLabel.text =  @"gatoroz"; //userInfo[@"screen_name"];
    //    [self.avatarImage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:userInfo[@"profile_image_url"]]] placeholderImage:[UIImage imageNamed:@"placeholder"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
    [self.avatarImage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://pbs.twimg.com/profile_images/300583089/twit_head_normal.jpg"]] placeholderImage:[UIImage imageNamed:@"placeholder"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        self.avatarImage.image = image;
        self.avatarImage.layer.masksToBounds = YES;
        self.avatarImage.layer.cornerRadius = 4.0;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        self.navigationItem.prompt = @"Failed to load profile image";
        NSLog(@"Failed to get profile view");
    }];
}

    
- (void)pushCancelButton {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)pushTweetButton {
    NSLog(@"Tweet Tweet");
    if (! [self.tweetTextView.text isEqualToString:@""]) {
        self.tweetTextView.editable = NO;
        [[TwitterClient instance] updateStatus:self.tweetTextView.text withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            // Tweet *t = [Tweet cookedFromRawTweet:responseObject];
            // Push this back to the view to show without reload.
            [self.navigationController popViewControllerAnimated:YES];

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            self.navigationItem.prompt = @"Unable to post tweet";
            NSLog(@"error: %@", error);
        }];
    }
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
