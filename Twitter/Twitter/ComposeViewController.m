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
#import "MainViewController.h"

#import <AFNetworking/UIImageView+AFNetworking.h>


@interface ComposeViewController ()

@property (strong, nonatomic) Tweet *tweet;

- (void)onCancelButton:(id) sender;
- (void)onTweetButton:(id) sender;

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
    self.tweetTextView.text = @"";
    [self.tweetTextView becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)setupView {
    User *me = [User currentUser];
    NSLog(@"current user: %@", me.handle);
    
    self.handleLabel.text = me.handle;
    self.nameLabel.text = me.name;
    [self.avatarImage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:me.imageURL]] placeholderImage:[UIImage imageNamed:@"placeholder"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        self.avatarImage.image = image;
        self.avatarImage.layer.masksToBounds = YES;
        self.avatarImage.layer.cornerRadius = 4.0;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        self.navigationItem.prompt = @"Failed to load profile image";
        NSLog(@"Failed to get profile view");
    }];
}

    

- (IBAction)onTweetButton:(id)sender {
    NSLog(@"Tweet Tweet");
    if (! [self.tweetTextView.text isEqualToString:@""]) {
        self.tweetTextView.editable = NO;
        [[TwitterClient instance] updateStatus:self.tweetTextView.text withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            // Tweet *t = [Tweet cookedFromRawTweet:responseObject];
            // Push this back to the view to show without reload.
            MainViewController *mvc = [[MainViewController alloc]init];
            [self presentViewController:mvc animated:YES completion:nil];

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            self.navigationItem.prompt = @"Unable to post tweet";
            NSLog(@"error: %@", error);
        }];

    }
}

- (IBAction)onCancelButton:(id)sender {
     MainViewController *mvc = [[MainViewController alloc]init];
    [self presentViewController:mvc animated:YES completion:nil];
}

@end