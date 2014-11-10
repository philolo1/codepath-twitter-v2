//
//  User.h
//  TwitterCodepath
//
//  Created by Patrick Klitzke on 10/29/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString * const UserDidLogoutNotification;

@interface User : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *screenName;
@property (nonatomic, copy) NSString *profileImageUrl;
@property (nonatomic, copy) NSString *tagline;
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *profileBannerUrl;
@property (nonatomic, copy) NSString *followersCount;
@property (nonatomic, copy) NSString *followingCount;



@property (nonatomic, copy) NSString *statusCount;
@property (nonatomic, copy) NSString *retweetCount;
@property (nonatomic, copy) NSString *favouriteCount;
@property (nonatomic, copy) NSString *favourited;
@property (nonatomic, copy) NSString *retweeted;
@property (nonatomic, copy) NSString *friendsCount;
@property (nonatomic, copy) NSString *backgroundUrl;

- (id)initWithDictionary:(NSDictionary *)dict;

+ (User *)currentUser;
+ (void)setCurrentUser:(User *)currentUser;

+ (void)logout;

@end
