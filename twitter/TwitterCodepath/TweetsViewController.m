//
//  TweetsViewController.m
//  TwitterCodepath
//
//  Created by Patrick Klitzke on 10/30/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import "TweetsViewController.h"
#import "User.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "ComposerViewController.h"
#import "DetailsViewController.h"
#import "AppDelegate.h"
#import "ProfileViewController.h"

@interface TweetsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end


typedef enum {
  Loading,
  Finished,
  NoResult
} ResultSate;


@implementation TweetsViewController
{
  NSArray *_tweets;
  BOOL _showHome;
  ResultSate _mystate;
}




- (IBAction)onLogout:(id)sender {
  
  [User logout];
  
}

- (id)init
{
  if (self = [super init]) {
    _showHome = YES;
  }
  
  return self;
}

- (id)initWithShowHome:(BOOL)showHome
{
  if (self = [super init]) {
    _showHome = showHome;
    
    self.title = @"Home";
    self.view.userInteractionEnabled = YES;
    self.tableView.userInteractionEnabled = YES;
    
    _mystate = Loading;
  }
  
  return self;
}



#pragma mark TableView -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   if (_mystate == NoResult) {
    return 1;
  } else {
    return _tweets.count;
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (_mystate == NoResult) {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = @"\t\t\tNo Results found...";
    return cell;
  }
  
  Tweet *tweet = (Tweet *)_tweets[indexPath.row];
  TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
  cell.tweet = tweet;
  
  UITapGestureRecognizer *taptest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onImageClick:)];
  [cell.profileImageView addGestureRecognizer:taptest];
  
  UITapGestureRecognizer *restTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onCellClick:)];
  [cell addGestureRecognizer:restTap];
  return cell;
}

- (void)onImageClick:(UITapGestureRecognizer *)sender
{
  TweetCell *tweetCell = (TweetCell *) [[[sender view] superview] superview];
   AppDelegate *app = [[UIApplication sharedApplication] delegate];
  [app openProfileWithUserID:tweetCell.tweet.user.userID];
}

- (void)onCellClick:(UITapGestureRecognizer *)sender
{
  TweetCell *tweetCell = (TweetCell *) [sender view];
  DetailsViewController *vc = [[DetailsViewController alloc] init];
  vc.tweet = tweetCell.tweet;
  [self.navigationController pushViewController:vc animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];

  
  self.refreshControl = [[UIRefreshControl alloc] init];
  [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
  [self.tableView insertSubview:self.refreshControl atIndex:0];
  
  
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

  
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  

    UINib *movieCellNib = [UINib nibWithNibName:@"TweetCell" bundle:nil];
  [self.tableView registerNib:movieCellNib forCellReuseIdentifier:@"TweetCell"];

  UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(newTweet:)];
  self.navigationItem.rightBarButtonItem = rightButton;
  
  UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onLogout:)];
  self.navigationItem.leftBarButtonItem = leftButton;
  
  
     // Do any additional setup after loading the view from its nib.
}

- (void) onRefresh
{
  [self loadTweets];
}

- (void) loadTweets
{
  if (_showHome) {
    [[TwitterClient sharedInstance] homeTimeLineWithParams:nil completion:^(NSArray *result, NSError *error) {
      [self.refreshControl endRefreshing];
      _tweets = result;
      if (_tweets.count == 0) {
        _mystate = NoResult;
      } else {
          _mystate = Finished;
      }
      [self.tableView reloadData];
    }];
  } else {
    [[TwitterClient sharedInstance] mentionTimeLineWithParams:nil completion:^(NSArray *result, NSError *error) {
      [self.refreshControl endRefreshing];
      _tweets = result;
      if (_tweets.count == 0) {
        _mystate = NoResult;
      } else {
        _mystate = Finished;
      }
      [self.tableView reloadData];
    }];
  }
}

- (void)tweetOnRest:(TweetCell *)cell
{
  DetailsViewController *vc = [[DetailsViewController alloc] init];
  vc.tweet = cell.tweet;
  [self.navigationController pushViewController:vc animated:NO];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
}

- (void)newTweet:(id)sender
{
  ComposerViewController *vc = [[ComposerViewController alloc] init];
  UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
  
  [self.navigationController presentViewController:nvc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
  [self loadTweets];
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
