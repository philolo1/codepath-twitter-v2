//
//  DetailsViewController.h
//  TwitterCodepath
//
//  Created by Patrick Klitzke on 11/1/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tweet.h"
#import "MainViewController.h"

@interface DetailsViewController : MainViewController

@property (nonatomic, weak) Tweet *tweet;

@end
