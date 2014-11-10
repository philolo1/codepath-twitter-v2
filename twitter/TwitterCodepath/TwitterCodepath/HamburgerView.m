//
//  HamburgerView.m
//  TwitterCodepath
//
//  Created by Patrick Klitzke on 11/8/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import "HamburgerView.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "MenuItemView.h"
#import "AppDelegate.h"

@implementation HamburgerView
{
  User *_user;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id) init
{
  if (self = [super init]) {
    self.backgroundColor = [[UIColor alloc] initWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    UIImageView *imageView = [[UIImageView alloc] init];
    _user = [User currentUser];
    
    CGFloat height = 20;
    
    [imageView setImageWithURL:[NSURL URLWithString:[_user profileImageUrl]]];
    imageView.frame =CGRectMake(20, 20, 100, 100);
    
    height += 100;
    
    [self addSubview:imageView];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.frame = CGRectMake(130, 25, 300, 25);
    nameLabel.text = [[User currentUser] name];
    nameLabel.font = [UIFont systemFontOfSize:22];
                              
    [self addSubview:nameLabel];
    
    UILabel *screenNameLabel = [[UILabel alloc] init];
    screenNameLabel.frame = CGRectMake(130, 50, 300, 30);
    screenNameLabel.text = [@"@" stringByAppendingString:[[User currentUser] screenName]];
    screenNameLabel.font = [UIFont systemFontOfSize:20];
    screenNameLabel.textColor = [UIColor grayColor];
    [self addSubview:screenNameLabel];
    
    
    
    UITapGestureRecognizer *rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onProfileTapped:)];
    MenuItemView *view = [[MenuItemView alloc] initWithFrame:CGRectZero contentText:@"View Profile"];
    view.frame = CGRectMake(0, height, 300, 50);
    [self addSubview:view];
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:rec];
    
    height += 50;
    
    rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTimeLineTapped:)];
    MenuItemView *timeLineView = [[MenuItemView alloc] initWithFrame:CGRectZero contentText:@"View Timeline"];
    timeLineView.frame = CGRectMake(0, height, 300, 50);
    [self addSubview:timeLineView];
    [timeLineView addGestureRecognizer:rec];
    
    height += 50;
    
    rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onMentionsTapped:)];
    MenuItemView *mentionsView = [[MenuItemView alloc] initWithFrame:CGRectZero contentText:@"View Mentions"];
    mentionsView.frame = CGRectMake(0, height, 300, 50);
    [self addSubview:mentionsView];
    [mentionsView addGestureRecognizer:rec];
    
    
  }
  return self;
}

- (void)onProfileTapped:(id)sender
{
  NSLog(@"Profile tapped");
  AppDelegate *app = [[UIApplication sharedApplication] delegate];
  [app openProfileWithUserID:[[User currentUser] userID]];
}

- (void)onMentionsTapped:(id)sender
{
  NSLog(@"Mentions tapped");
  AppDelegate *app = [[UIApplication sharedApplication] delegate];
  [app openMentions];
}

- (void)onTimeLineTapped:(id)sender
{
  NSLog(@"TimeLine tapped");
  AppDelegate *app = [[UIApplication sharedApplication] delegate];
  [app openTimeline];
}


@end
