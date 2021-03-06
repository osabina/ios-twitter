//
//  TweetViewController.h
//  Twitter
//
//  Created by Osvaldo Sabina on 7/6/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetViewController : UIViewController <UINavigationControllerDelegate> {
    UINavigationController *navController;
}
@property (strong, nonatomic) IBOutlet UIView *canvasView;

@property (weak, nonatomic) IBOutlet UIImageView *retweetedImage;
@property (weak, nonatomic) IBOutlet UILabel *retweetedLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *retweetedImageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *retweetedLabelHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *retweetedMarginHeight;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;

@property (weak, nonatomic) IBOutlet UILabel *tweetBody;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numRetweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *numFavoritesLabel;

@property (weak, nonatomic) IBOutlet UIButton *replyButton;
- (IBAction)replyButtonPushed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
- (IBAction)retweetButtonPushed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
- (IBAction)favoriteButtonPushed:(id)sender;

@property (strong,nonatomic) Tweet *tweet;

-(void)setupWithTweet: (Tweet *)tweet;
-(void)updateButtons;

@end
