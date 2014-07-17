//
//  TweetCell.h
//  Twitter
//
//  Created by Osvaldo Sabina on 7/6/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *canvasView;
@property (weak, nonatomic) IBOutlet UILabel *retweetedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *retweetedImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *retweetedLabelHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *retweetedImageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarImageTopMargin;

@property (strong,nonatomic) UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeAgoLabel;

@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;

@property (weak, nonatomic) IBOutlet UIButton *replyButton;
- (IBAction)replyButtonPushed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
- (IBAction)retweetButtonPushed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
- (IBAction)favoriteButtonPushed:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *avatarButton;
- (IBAction)avatarButtonPushed:(id)sender;

@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) Tweet *tweet;
@property (strong, nonatomic) NSDictionary *userInfo;

-(void)setupWithTweet: (Tweet *)tweet;
-(void)updateButtons;

@end
