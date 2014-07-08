//
//  TweetViewController.m
//  Twitter
//
//  Created by Osvaldo Sabina on 7/6/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import "TwitterCommon.h"
#import "TweetViewController.h"
#import "ComposeViewController.h"

#import <AFNetworking/UIImageView+AFNetworking.h>
#import <NSDate+DateTools.h>

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
    [self setupWithTweet: self.tweet];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushReplyButton {
    [self.navigationController pushViewController:[[ComposeViewController alloc] init] animated:YES];

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



-(void)setupWithTweet: (Tweet *)tweet {
    self.tweet = tweet;
    
    self.nameLabel.text = tweet.name;
    [self.nameLabel sizeToFit];
    
    self.handleLabel.text = [NSString stringWithFormat:@"@%@", tweet.handle];
    self.tweetBody.text = tweet.body;
    [self.avatarImage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:tweet.avatarURL]] placeholderImage:[UIImage imageNamed:@"placeholder"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        self.avatarImage.image = image;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"Failed to get profile view");
    }];

    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateStyle:NSDateFormatterShortStyle];
    [fmt setTimeStyle:NSDateFormatterShortStyle];
    self.timeLabel.text = [ fmt stringFromDate: tweet.tweetDate];
    
    self.numRetweetsLabel.text = [tweet.retweetCount stringValue];
    self.numFavoritesLabel.text = [tweet.favoriteCount stringValue];
    
    if (tweet.isRetweeted == NO) {
        self.retweetedImage.hidden = true;
        self.retweetedLabel.hidden = true;
        self.retweetedImageHeight.constant = 0.0;
        self.retweetedLabelHeight.constant = 0.0;
        self.retweetedMarginHeight.constant = 0.0;
    } else {
        self.retweetedImage.hidden = false;
        self.retweetedLabel.hidden = false;
        self.retweetedLabel.text = [NSString stringWithFormat:@"%@ retweeted", tweet.retweetedHandle];
        self.retweetedImage.image = [UIImage imageNamed:@"Retweet"];
    }

    [self updateButtons];
    [self.canvasView layoutIfNeeded];
}

-(void)updateButtons{
    // Reply Button
    [self.replyButton setTitle:@"" forState:UIControlStateNormal];
    [self.replyButton setBackgroundImage:[UIImage imageNamed:@"Reply"] forState:UIControlStateNormal];
    // Retweet Button
    [self.retweetButton setTitle:@"" forState:UIControlStateNormal];
    [self.retweetButton setBackgroundImage:[UIImage imageNamed:@"Retweet"] forState:UIControlStateNormal];
    
    // Favorite Button
    [self.favoriteButton setTitle:@"" forState:UIControlStateNormal];
    if (self.tweet.favoriteCount.intValue <= 0) {
        [self.favoriteButton setBackgroundImage:[UIImage imageNamed:@"Favorite"] forState:UIControlStateNormal];
    } else {
        [self.favoriteButton setBackgroundImage:[UIImage imageNamed:@"FavoriteSelected"] forState:UIControlStateNormal];
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


- (IBAction)replyButtonPushed:(id)sender {
    ComposeViewController *cvc = [[ComposeViewController alloc] init];
    cvc.orig_tweet = self.tweet;
    cvc.is_reply = YES;
    [self.navigationController pushViewController:cvc animated:YES];
}

- (IBAction)retweetButtonPushed:(id)sender {
    ComposeViewController *cvc = [[ComposeViewController alloc] init];
    cvc.orig_tweet = self.tweet;
    cvc.is_retweet = YES;
    [self.navigationController pushViewController:cvc animated:YES];
}


- (IBAction)favoriteButtonPushed:(UIButton *)sender {
    self.tweet.favoriteCount = @(self.tweet.favoriteCount.intValue + 1);
    // If we maintained state, we could use this as a toggle instead
    sender.enabled = NO;
    [self updateButtons];
}
@end
