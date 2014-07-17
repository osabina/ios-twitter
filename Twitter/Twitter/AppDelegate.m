//
//  AppDelegate.m
//  Twitter
//
//  Created by Osvaldo Sabina on 7/6/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import "AppDelegate.h"
#import "TwitterCommon.h"
#import "TwitterClient.h"
#import "User.h"

#import "LoginViewController.h"
#import "MainViewController.h"

@interface AppDelegate()
@property (assign) BOOL isNavLoaded;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self setupRootView];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation     {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSArray *pairs = [url.query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [parameters setObject:val forKey:key];

        if (parameters[@"oauth_token"] && parameters[@"oauth_verifier"]) {
            [[TwitterClient instance] fetchAccessTokenWithPath:@"/oauth/access_token" method:@"POST" requestToken:[BDBOAuthToken tokenWithQueryString:url.query] success:^(BDBOAuthToken *accessToken) {
                [[TwitterClient instance].requestSerializer saveAccessToken:accessToken];
                NSLog(@"Got the access token!");
                [self setupRootView];
            } failure:^(NSError *error) {
                NSLog(@"Failed to get access token");
            }];
        }
    }
    return YES;
}

- (void) setupRootView {

    // Set up user if not already set
    if ([User currentUser] == nil) {
        [[TwitterClient instance] getUserInfoWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            [[User alloc] setupUser: responseObject];
            NSLog(@"------ Initialized user ------");
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error retrieving user info: %@", [error description]);
        }];
    }

    // Display login or main view
    if ([TwitterClient instance].isAuthorized) {
        MainViewController *mvc = [[MainViewController alloc] init];
        mvc.signout_delegate = self;
        self.window.rootViewController = mvc;
    }
    else {
        self.window.rootViewController = [[LoginViewController alloc] init];
        self.window.backgroundColor = [UIColor whiteColor];
        self.isNavLoaded = NO;
//        [self.window makeKeyAndVisible];
    }
}

- (void) onSignOut {
    [[TwitterClient instance] logout];
    NSLog(@"Logged out!");
    [self setupRootView];
}

@end
