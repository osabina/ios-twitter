//
//  Tweet.h
//  Twitter
//
//  Created by Osvaldo Sabina on 7/7/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *handle;
@property (strong, nonatomic) NSString *body;
@property (strong, nonatomic) NSString *avatarURL;
@property (strong, nonatomic) NSDate *tweetDate;
@property (strong, nonatomic) NSString *retweetedHandle;
@property (assign, nonatomic, getter=isRetweeted) BOOL retweeted;
@property (strong, nonatomic) NSNumber *retweetCount;
@property (strong, nonatomic) NSNumber *favoriteCount;

+ (NSArray *) tweetsFromRawResponse:(NSArray*) responseArray;
+ (Tweet *) cookedFromRawTweet:(NSDictionary*) rawTweet;

@end
