//
//  User.m
//  TwitterCodepath
//
//  Created by Patrick Klitzke on 10/29/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import "TwitterClient.h"
#import "User.h"

NSString * const UserDidLogoutNotification = @"UserDidLogoutNotification";

@interface User()

@property (nonatomic, weak) NSDictionary *dictionary;

@end

@implementation User

- (id)initWithDictionary:(NSDictionary *)dict{
  self = [super init];
  
  if (self) {
    self.name = dict[@"name"];
    self.profileBannerUrl = dict[@"profile_banner_url"];
    self.userID = dict[@"id"];
    self.screenName = dict[@"screen_name"];
    self.profileImageUrl = dict[@"profile_image_url"];
    self.tagline = dict[@"description"];
    self.dictionary = dict;
    self.statusCount = dict[@"statuses_count"];
    self.retweetCount = dict[@"retweet_count"];
    self.favouriteCount = dict[@"favorite_count"];
    self.favourited = dict[@"favorited"];
    self.retweeted = dict[@"retweeted"];
    self.followingCount = dict[@"friends_count"];
    self.followersCount = dict[@"followers_count"];
    self.friendsCount = dict[@"friends_count"];
    self.backgroundUrl = dict[@"profile_background_image_url"];
    
  }
  
  return self;
}

static User *_currentUser = nil;

NSString *const kCurrentUserKey = @"kCurrentUserKey";

+ (User *)currentUser {
  
  if (_currentUser == nil) {
    NSData *data =[[NSUserDefaults standardUserDefaults] objectForKey:kCurrentUserKey];
    
    if (data != nil) {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:0
                                                           error:NULL];
      _currentUser = [[User alloc] initWithDictionary:dict];
      
    }
  }
  
  return  _currentUser;
}

+ (void)setCurrentUser:(User *)currentUser {
  _currentUser = currentUser;
  
  if (_currentUser != nil) {
    NSData *data = [NSJSONSerialization dataWithJSONObject:currentUser.dictionary options:0 error:NULL];
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kCurrentUserKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
  } else {
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kCurrentUserKey];
  }
}

+ (void)logout {
  _currentUser = nil;
  
  [[TwitterClient sharedInstance].requestSerializer removeAccessToken];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLogoutNotification object:nil];
}

@end
