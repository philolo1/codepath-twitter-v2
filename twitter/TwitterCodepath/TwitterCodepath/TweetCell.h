//
//  TweetCell.h
//  TwitterCodepath
//
//  Created by Patrick Klitzke on 11/2/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@class TweetCell;

@protocol TweetCellProtocol

- (void)tweetOnImage:(TweetCell *)cell;
- (void)tweetOnRest:(TweetCell *)cell;

@end

@interface TweetCell : UITableViewCell

@property (nonatomic, weak) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (nonatomic, weak) id<TweetCellProtocol> mydelegate;


@end
