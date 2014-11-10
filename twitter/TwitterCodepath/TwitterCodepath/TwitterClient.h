//
//  TwitterClient.h
//  TwitterCodepath
//
//  Created by Patrick Klitzke on 10/29/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *)sharedInstance;

- (void)getProfileFromUserID:(NSString *)userID completion:(void (^)(User *user, NSError *error))completion;

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;

- (void)openUrl:(NSURL *)url;

- (void)homeTimeLineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;

- (void)postTweet:(NSString *)tweetContent replyID:(NSString *)replyID completion:(void (^)(id help, NSError *error))completion;

- (void)retweet:(NSString *)tweetID completion:(void (^)(id help, NSError *error))completion;

- (void)favourite:(NSString *)tweetID completion:(void (^)(id help, NSError *error))completion;

- (void)mentionTimeLineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;


@end
