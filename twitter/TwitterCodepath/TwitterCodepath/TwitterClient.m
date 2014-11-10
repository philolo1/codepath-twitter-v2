//
//  TwitterClient.m
//  TwitterCodepath
//
//  Created by Patrick Klitzke on 10/29/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import "TwitterClient.h"
#import "Tweet.h"

@interface  TwitterClient()

@property (nonatomic, strong) void (^loginCompletion)(User *, NSError *error);

@end

@implementation TwitterClient


NSString * const kTwitterConsumerKey = @"cHGDFYT94YkBfMUq99v5Cvn5c";
NSString * const kTwitterConsumerSecret = @"qCKUsH9VJKiWTsrmvwJFTt0BbeuxfXUGzfsKNwz1ykgbuiUJCb";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";
+ (TwitterClient *)sharedInstance {
  static TwitterClient *instance = nil;
  
  static dispatch_once_t onceToken;
  
  dispatch_once(&onceToken, ^{
  if (instance == nil) {
    instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl]
                                          consumerKey:kTwitterConsumerKey
                                       consumerSecret:kTwitterConsumerSecret];
  }
  });
  
  return instance;
}


- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion {

  self.loginCompletion = completion;
[self.requestSerializer removeAccessToken];
[self fetchRequestTokenWithPath:@"oauth/request_token"
                                                   method:@"GET"
                                              callbackURL:[NSURL URLWithString:@"cptwitterdemo://oauth"]
                                                    scope:nil
                                                  success:^(BDBOAuthToken *requestToken)
 {
   NSLog(@"got request token");
   NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
   
   
   [[UIApplication sharedApplication] openURL:url];
 } failure:^(NSError *error) {
   NSLog(@"token failed");
   self.loginCompletion(nil, error);
 }
 ];
}

- (void)getProfileFromUserID:(NSString *)userID completion:(void (^)(User *user, NSError *error))completion
{
    [self GET:@"1.1/users/lookup.json" parameters:@{@"user_id" : userID}
     
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
        User *user = [[User alloc] initWithDictionary:responseObject[0]];
        completion(user, nil);
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // NSLog(@"bad :(");
        completion(nil, error);
      }
     ];
}

- (void)openUrl:(NSURL *)url
{
  [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuthToken tokenWithQueryString:url.query] success:^(BDBOAuthToken *accessToken) {
    NSLog(@"Good");
    
    
    
    [self GET:@"1.1/account/verify_credentials.json" parameters:nil
     
                                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  NSLog(@"good : %@", responseObject);
                                  
                                  User *user = [[User alloc] initWithDictionary:responseObject];
                                  
                                  [User setCurrentUser:user];
                                  
                                  // NSLog(@"username : %@", user.name);
                                  self.loginCompletion(user, nil);
                                  
                                  
                                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                   // NSLog(@"bad :(");
                                  self.loginCompletion(nil, error);
                                }
     ];
    
    
    /*
    [[TwitterClient sharedInstance] GET:@"1.1/statuses/home_timeline.json" parameters:nil
     
                                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  NSLog(@"good : %@", responseObject);
                                  
                                  
                                  NSArray *tweets = [Tweet tweetsWithArray:responseObject];
                                  
                                  for (Tweet *tweet in tweets) {
                                    NSLog(@"tweet: %@, created: %@", tweet.text, tweet.createAt);
                                  }
                                  
                                  
                                  
                                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  NSLog(@"bad :(");
                                }
     ];
    
    */
    
    
    
    
  } failure:^(NSError *error) {
    NSLog(@"Bad");
  }];
}



- (void)homeTimeLineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion
{
  [self GET:@"1.1/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSArray *tweets = [Tweet tweetsWithArray:responseObject];
    completion(tweets, nil);
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    completion(nil,error);
  }];
}


- (void)mentionTimeLineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion
{
  [self GET:@"1.1/statuses/mentions_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSArray *tweets = [Tweet tweetsWithArray:responseObject];
    completion(tweets, nil);
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    completion(nil,error);
  }];
}


- (void)postTweet:(NSString *)tweetContent replyID:(NSString *)replyID completion:(void (^)(id help, NSError *error))completion
{
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  [dict setObject:tweetContent forKey:@"status"];
  
  if (replyID) {
    [dict setObject:replyID forKey:@"in_reply_to_status_id"];
  }
  
  [self POST:@"1.1/statuses/update.json" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
    completion(responseObject, nil);
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    completion(nil, error);
  }];
}

- (void)retweet:(NSString *)tweetID completion:(void (^)(id help, NSError *error))completion
{
  NSString *url = [NSString stringWithFormat:@"1.1/statuses/retweet/%@.json", tweetID ];
  
  [self POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    completion(responseObject, nil);
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    completion(nil, error);
  }];

}

- (void)favourite:(NSString *)tweetID completion:(void (^)(id help, NSError *error))completion
{
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  [dict setObject:tweetID forKey:@"id"];
  

  NSString *url = @"1.1/favorites/create.json";
  
  [self POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
    completion(responseObject, nil);
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    completion(nil, error);
  }];

}



@end
