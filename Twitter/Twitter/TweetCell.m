//
//  TweetCell.m
//  Twitter
//
//  Created by Osvaldo Sabina on 7/6/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import "ComposeViewController.h"
#import "TweetCell.h"

#import <AFNetworking/UIImageView+AFNetworking.h>
#import <NSDate+DateTools.h>

@implementation TweetCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupWithTweet: (Tweet *)tweet {
    self.tweet = tweet;
    
    self.nameLabel.text = tweet.name;
    [self.nameLabel sizeToFit];

    self.handleLabel.text = [NSString stringWithFormat:@"@%@", tweet.handle];
    self.bodyLabel.text = tweet.body;
    self.timeAgoLabel.text = tweet.tweetDate.shortTimeAgoSinceNow;
    [self.avatarImage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:tweet.avatarURL]] placeholderImage:[UIImage imageNamed:@"placeholder"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        self.avatarImage.image = image;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"Failed to get profile view");
    }];
    
    if (tweet.isRetweeted == NO) {
        self.retweetedImage.hidden = true;
        self.retweetedLabel.hidden = true;
        self.retweetedImageHeight.constant = 0.0;
        self.retweetedLabelHeight.constant = 0.0;
        self.avatarImageTopMargin.constant = 10.0;
    } else {
        self.retweetedImage.hidden = false;
        self.retweetedLabel.hidden = false;
        self.retweetedLabel.text = [NSString stringWithFormat:@"%@ retweeted", tweet.retweetedHandle];
        self.retweetedImage.image = [UIImage imageNamed:@"Retweet"];
    }
    
    [self layoutIfNeeded];
    
//    [self updateRetweets];
    [self updateButtons];
    
}

- (void) updateButtons {
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

- (IBAction)favoriteButtonPushed:(UIButton *)sender {
    self.tweet.favoriteCount = @(self.tweet.favoriteCount.intValue + 1);
    // If we maintained state, we could use this as a toggle instead
    sender.enabled = NO;
    [self updateButtons];
}
- (IBAction)replyButtonPushed:(id)sender {
    ComposeViewController *cvc = [[ComposeViewController alloc] init];
    cvc.orig_tweet = self.tweet;
    cvc.is_reply = YES;
    [self.navController pushViewController:cvc animated:YES];
}

- (IBAction)retweetButtonPushed:(id)sender {
    ComposeViewController *cvc = [[ComposeViewController alloc] init];
    cvc.orig_tweet = self.tweet;
    cvc.is_retweet = YES;
    [self.navController pushViewController:cvc animated:YES];
}
@end
