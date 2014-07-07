//
//  TwitterClient.m
//  Twitter
//
//  Created by Osvaldo Sabina on 7/6/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import "TwitterClient.h"
#import "AFNetworking.h"

@implementation TwitterClient

#define TWITTER_BASE_URL [NSURL URLWithString:@"https://api.twitter.com/"]
#define TWITTER_API_KEY @"4AYa87SVjySjYaq7sAsRm6Hls"
#define TWITTER_API_SECRET @"KKwOH21LKeIJYM0NDcFhQQfgmYiA9J2InFIPx5CzGcys3bs0Ul"

+ (TwitterClient *)instance {
    static TwitterClient * instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com"] consumerKey:TWITTER_API_KEY consumerSecret:TWITTER_API_SECRET];
    });
    
    return instance;
}

- (void)login {
    if (self.isAuthorized) {
        return;
    }
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"POST" callbackURL:[NSURL URLWithString:@"oztwitter://oauth"] scope:nil success:^(BDBOAuthToken *requestToken) {
        NSLog(@"Request token: %@", requestToken);
        NSString *authURL = [NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:authURL]];
    } failure:^(NSError *error) {
        NSLog(@"Error getting reqeust token: %@", error);
    }];
}

- (void)logout {
    [self.requestSerializer removeAccessToken];
}

- (AFHTTPRequestOperation *)homeTimelineWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    return [self GET:@"1.1/statuses/user_timeline.json" parameters:nil success:success failure:failure];
}

- (AFHTTPRequestOperation *)getUserInfoWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    return [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:success failure:failure];
}

- (AFHTTPRequestOperation *)updateStatus:(NSString*)text
withSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    NSDictionary *parameters = @{@"status": text};
    return [self POST:@"1.1/statuses/update.json" parameters:parameters success:success failure:failure];
}
@end
