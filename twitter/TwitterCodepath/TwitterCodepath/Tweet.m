//
//  Tweet.m
//  TwitterCodepath
//
//  Created by Patrick Klitzke on 10/29/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (id)initWithDictionary:(NSDictionary *)dict
{
  self = [super init];
  if (self) {
    
    self.user = [[User alloc] initWithDictionary:dict[@"user"]];
    self.text = dict[@"text"];
    NSString *createAtString = dict[@"created_at"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
    self.createAt = [formatter dateFromString:createAtString];
    self.tweetId = dict[@"id"];
    self.favorited = dict[@"favorited"];
  }
  
  return self;
}

// gives us the information when it was created
// (how many hours ago)
- (NSString *)hourDistanceTime
{
  // Get the system calendar
  NSCalendar *sysCalendar = [NSCalendar currentCalendar];
  
  // Create the current date
  NSDate *currentDate = [[NSDate alloc] init];
  
  // Get conversion to months, days, hours, minutes
  unsigned int unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit;
  
  NSDateComponents *breakdownInfo = [sysCalendar components:unitFlags fromDate:currentDate  toDate:self.createAt  options:0];
  
  return [NSString stringWithFormat:@"%ldm", - [breakdownInfo minute]];
}

+ (NSArray *)tweetsWithArray:(NSArray *)array {
  NSMutableArray *tweets = [NSMutableArray array];
  
  for (NSDictionary *dictionary in array) {
   [tweets addObject: [[Tweet alloc] initWithDictionary:dictionary]];
  }
  
  return tweets;
}

@end
