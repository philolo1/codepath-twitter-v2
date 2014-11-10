//
//  DetailsViewController.m
//  TwitterCodepath
//
//  Created by Patrick Klitzke on 11/1/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import "DetailsViewController.h"
#import "ComposerViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startHighlighButton;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;

@end

@implementation DetailsViewController

- (void)setTweet:(Tweet *)tweet
{
  _tweet = tweet;
  UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Reply" style:UIBarButtonItemStylePlain target:self action:@selector(onReply:)];
  self.navigationItem.rightBarButtonItem = rightButton;
  
  
  NSString *userLineString = [NSString stringWithFormat:@"%@ @%@", _tweet.user.name, _tweet.user.screenName];
  
  NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:userLineString attributes:nil];
  
  [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(_tweet.user.name.length + 1, _tweet.user.screenName.length + 1)];
  
  self.nameLabel.attributedText = attrString;
  _hourLabel.text = [_tweet hourDistanceTime];
  
  _tweetLabel.text = [_tweet text];
  
  [_profileImage setImageWithURL:[NSURL URLWithString:_tweet.user.profileImageUrl]];
  
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Tweet";
}
- (IBAction)replyClicked:(id)sender {
  [self onReply:sender];
}

- (IBAction)retweetClick:(id)sender {
  [[TwitterClient sharedInstance] retweet:_tweet.tweetId completion:^(id help, NSError *error) {
    NSLog(@"Test retweet");
    [self.navigationController popToRootViewControllerAnimated:YES];
  }];
}
- (IBAction)starClicked:(id)sender {
  
  [[TwitterClient sharedInstance] favourite:_tweet.tweetId completion:^(id help, NSError *error) {
    [self.navigationController popToRootViewControllerAnimated:YES];
  }];
}

- (void)onReply:(id)sender
{
  ComposerViewController *vc = [[ComposerViewController alloc] init];
  vc.replyID = _tweet.tweetId;
  vc.replyScreenName = _tweet.user.screenName;
  UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
  
  [self presentViewController:nvc animated:YES completion:nil];
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
