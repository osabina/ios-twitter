//
//  User.m
//  Twitter
//
//  Created by Osvaldo Sabina on 7/7/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import "User.h"

@implementation User

static User *currentUser = nil;

+ (User *)currentUser {
    if (currentUser == nil){
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        NSData *data = [def objectForKey:@"current_user"];
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];

        if (dict) {
            currentUser = [[User alloc] initWithDictionary: dict];
        }

    }
    return currentUser;
}

- (void)setupUser:(id)response {
    currentUser = [[User alloc] initWithDictionary:response];
    NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:response];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:[NSKeyedArchiver archivedDataWithRootObject:dict] forKey:@"current_user"];
    [def synchronize];
//    currentUser = [[User alloc] initWithDictionary: (NSDictionary *) response];
//    self = [[User alloc] initWithDictionary:response];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:self] forKey:@"current_user"];
//    [defaults synchronize];
//
//    return self;
}

- (id)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.handle = dict[@"screen_name"];
        self.name = dict[@"name"];
        self.imageURL = dict[@"profile_image_url"];
        self.backgroundImageURL = dict[@"profile_background_image_url"];
    }
    return self;
}

//- (void)encodeWithCoder:(NSCoder *)coder {
//    [coder encodeObject:self.handle forKey:@"Handle"];
//    [coder encodeObject:self.name forKey:@"Name"];
//    [coder encodeObject:self.imageURL forKey:@"ImageURL"];
//}
//- (id)initWithCoder:(NSCoder *)coder {
//    self = [super init];
//    if (self) {
//        _name = [coder decodeObjectForKey:@"Name"];
//        _handle = [coder decodeObjectForKey:@"Handle"];
//        _imageURL = [coder decodeObjectForKey:@"ImageURL"];
//    }
//    return self;
//}


@end
