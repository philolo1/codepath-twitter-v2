//
//  Tweet.h
//  TwitterCodepath
//
//  Created by Patrick Klitzke on 10/29/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createAt;
@property (nonatomic, strong) User *user;
@property (nonatomic, copy) NSString *profileUrl;
@property (nonatomic, copy) NSString *tweetId;
@property (nonatomic, strong) NSNumber* favorited;

- (id)initWithDictionary:(NSDictionary *)dict;
+ (NSArray *)tweetsWithArray:(NSArray *)array;

- (NSString *)hourDistanceTime;


@end
