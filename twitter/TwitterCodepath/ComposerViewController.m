//
//  ComposerViewController.m
//  TwitterCodepath
//
//  Created by Patrick Klitzke on 11/1/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import "ComposerViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"

@interface ComposerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UITextView *editTextView;

@end

@implementation ComposerViewController

- (void)setReplyID:(NSString *)replyID
{
  _replyID = replyID;
    self.title = @"Reply Tweet";
}

- (void)setReplyScreenName:(NSString *)replyScreenName
{
  _replyScreenName = replyScreenName;
  _editTextView.text =  [@"@" stringByAppendingString:_replyScreenName];

}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweet:)];
  self.navigationItem.rightBarButtonItem = rightButton;
  
  UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel:)];
  self.navigationItem.leftBarButtonItem = leftButton;
    
  self.nameLabel.text = [User currentUser].name;
  self.screenNameLabel.text = [User currentUser].screenName;
  
  [_profileImageView setImageWithURL:[NSURL URLWithString:[User currentUser].profileImageUrl]];
  [_editTextView becomeFirstResponder];
    // Do any additional setup after loading the view from its nib.
}

- (void)onCancel:(id)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onTweet:(id)sender
{
  NSString *text = _editTextView.text;
  [[TwitterClient sharedInstance] postTweet:text replyID:_replyID  completion:^(id help, NSError *error) {
    
    [self dismissViewControllerAnimated:YES completion:nil];
  }];
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
