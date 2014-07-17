//
//  User.h
//  Twitter
//
//  Created by Osvaldo Sabina on 7/7/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import <Foundation/Foundation.h>

//@interface User : NSObject <NSCoding>
@interface User : NSObject


@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *handle;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *backgroundImageURL;

+ (User *)currentUser;
- (void)setupUser:(id) responseObject;

//- (void)encodeWithCoder:(NSCoder *)coder;
//- (id)initWithCoder:(NSCoder *)coder;

@end
