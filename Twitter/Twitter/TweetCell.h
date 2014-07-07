//
//  TweetCell.h
//  Twitter
//
//  Created by Osvaldo Sabina on 7/6/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *retweetedLabel;
@property (weak, nonatomic) IBOutlet UIView *retweetedImage;

@property (weak, nonatomic) IBOutlet UIView *avatarImage;
@property (weak, nonatomic) IBOutlet UIView *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *handleLabel;

@property (weak, nonatomic) IBOutlet UIView *timeAgoLabel;

@property (weak, nonatomic) IBOutlet UIView *tweetContentsLabel;


@property (weak, nonatomic) IBOutlet UIImageView *replyImage;
@property (weak, nonatomic) IBOutlet UIImageView *retweetImage;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteImage;

@end
