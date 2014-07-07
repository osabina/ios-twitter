//
//  ComposeViewController.h
//  Twitter
//
//  Created by Osvaldo Sabina on 7/6/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposeViewController : UIViewController <UINavigationControllerDelegate> {
    UINavigationController *navController;
}
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

@end
