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
    
    self.replyImage.image = [UIImage imageNamed:@"Reply"];
    self.retweetImage.image = [UIImage imageNamed:@"Retweet"];
    self.favoriteImage.image = [UIImage imageNamed:@"Favorite"];
    
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
        self.retweetedImageHeight = 0;
        self.retweetedLabelHeight = 0;
        self.retweetedMarginHeight = 0;
    } else {
        self.retweetedImage.hidden = false;
        self.retweetedLabel.hidden = false;
        self.retweetedLabel.text = [NSString stringWithFormat:@"%@ retweeted", tweet.retweetedHandle];
        self.retweetedImage.image = [UIImage imageNamed:@"Retweet"];
    }

    [self.canvasView layoutIfNeeded];
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
