//
//  ProfileViewController.m
//  TwitterCodepath
//
//  Created by Patrick Klitzke on 11/9/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController
{
  __weak IBOutlet UILabel *infoLabel;
  __weak IBOutlet UIImageView *imageViewController;
}

- (id)initWithUserID:(NSString *)userID
{
  if (self = [super init]) {

    [[TwitterClient sharedInstance] getProfileFromUserID:userID completion:^(User *user, NSError *error) {
      NSLog(@"Hallo");
      [imageViewController setImageWithURL:[NSURL URLWithString:user.backgroundUrl ]];
      
      self.title = [NSString stringWithFormat:@"%@'s Profile", user.name];
      
      
      infoLabel.text =
      [NSString stringWithFormat:@"%@ Tweets \t %@ Following \t %@ Followers", user.statusCount,user.followingCount, user.followersCount];
    }];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
