//
//  ComposeViewController.h
//  Twitter
//
//  Created by Osvaldo Sabina on 7/6/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Tweet.h"

@interface ComposeViewController : UIViewController <UINavigationControllerDelegate> {
    UINavigationController *navController;
}
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

@property (strong,nonatomic) Tweet *orig_tweet;
@property (nonatomic) BOOL is_reply;
@property (nonatomic) BOOL is_retweet;

@end
