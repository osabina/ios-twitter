//
//  User.m
//  Twitter
//
//  Created by Osvaldo Sabina on 7/7/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import "User.h"

@implementation User


+ (User *)userfromUserInfo: (NSDictionary *)userInfo {
    User *myuser = [[User alloc] init];
    
    myuser.name = userInfo[@"name"];
    myuser.name = userInfo[@"handle"];
    
    return myuser;
}

@end
