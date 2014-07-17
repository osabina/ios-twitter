//
//  Tweet.m
//  Twitter
//
//  Created by Osvaldo Sabina on 7/7/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

+ (NSArray *) tweetsFromRawResponse:(NSArray*) responseArray {
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:responseArray.count];
    for (NSDictionary *rawTweet in responseArray) {
        Tweet *tweet = [Tweet cookedFromRawTweet: rawTweet];
        [array addObject:tweet];
    }
    return array;
}

+ (Tweet *) cookedFromRawTweet:(NSDictionary*) rawTweet {
    Tweet * tweet = [[Tweet alloc] init];
    int retweetStatus = [rawTweet[@"retweeted"] integerValue];
    if (retweetStatus == 1) {
        tweet.retweeted = YES;
        tweet.name = rawTweet[@"retweeted_status"][@"user"][@"name"];
        tweet.handle = rawTweet[@"retweeted_status"][@"user"][@"screen_name"];
        tweet.avatarURL = rawTweet[@"retweeted_status"][@"user"][@"profile_image_url"];
        tweet.retweetedHandle = rawTweet[@"user"][@"screen_name"];
        tweet.body = rawTweet[@"retweeted_status"][@"text"];
    }
    else {
        tweet.retweeted = NO;
        tweet.name = rawTweet[@"user"][@"name"];
        tweet.handle = rawTweet[@"user"][@"screen_name"];
        tweet.avatarURL = rawTweet[@"user"][@"profile_image_url"];
        tweet.body = rawTweet[@"text"];
    }
    
    id retweets = rawTweet[@"retweet_count"];
    tweet.retweetCount = (retweets == nil) ? 0 : retweets;
    id favs = rawTweet[@"favorite_count"];
    tweet.favoriteCount = (favs == nil) ? 0 : favs;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat: @"EEE MMM dd HH:mm:ss Z yyyy"];
    tweet.tweetDate = [fmt dateFromString:rawTweet[@"created_at"]];
    return tweet;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"Tweet - name: %@ (@%@) %@ text: %@", self.name, self.handle, self.isRetweeted ? @"[RT]" : @"" , self.body];
}
@end




