//
//  TweetCell.m
//  TwitterCodepath
//
//  Created by Patrick Klitzke on 11/2/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

@interface TweetCell()

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;

@end

@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
  self.userInteractionEnabled = YES;

}

- (void)setTweet:(Tweet *)tweet
{
  _tweet = tweet;
  self.tweetLabel.preferredMaxLayoutWidth = self.tweetLabel.frame.size.width;
  
  NSString *userLineString = [NSString stringWithFormat:@"%@ @%@", _tweet.user.name, _tweet.user.screenName];
  
  NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:userLineString attributes:nil];
  
  [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(_tweet.user.name.length + 1, _tweet.user.screenName.length + 1)];
  
  self.authorLabel.attributedText = attrString;
  
  
  _hourLabel.text = [_tweet hourDistanceTime];
  
  _tweetLabel.text = [_tweet text];
  
  [_profileImageView setImageWithURL:[NSURL URLWithString:_tweet.user.profileImageUrl]];
  _profileImageView.userInteractionEnabled = YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
