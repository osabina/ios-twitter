//
//  TweetCell.m
//  Twitter
//
//  Created by Osvaldo Sabina on 7/6/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

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
    
    self.replyImage.image = [UIImage imageNamed:@"Reply"];
    self.retweetImage.image = [UIImage imageNamed:@"Retweet"];
    self.favoriteImage.image = [UIImage imageNamed:@"Favorite"];
    
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
        self.retweetedImageHeight = 0;
        self.retweetedLabelHeight = 0;
    } else {
        self.retweetedImage.hidden = false;
        self.retweetedLabel.hidden = false;
        self.retweetedLabel.text = [NSString stringWithFormat:@"%@ retweeted", tweet.retweetedHandle];
        self.retweetedImage.image = [UIImage imageNamed:@"Retweet"];
    }
    
//    [self layoutIfNeeded]; // see http://stackoverflow.com/questions/19395766/where-to-update-auto-layout-constant
    
//    [self updateRetweets];
//    [self updateFavourites];
    
}

@end
