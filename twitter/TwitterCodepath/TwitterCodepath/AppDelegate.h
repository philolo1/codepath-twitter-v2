//
//  AppDelegate.h
//  TwitterCodepath
//
//  Created by Patrick Klitzke on 10/29/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)openProfileWithUserID:(NSString *)userID;
- (void)openTimeline;
- (void)openMentions;

@end

