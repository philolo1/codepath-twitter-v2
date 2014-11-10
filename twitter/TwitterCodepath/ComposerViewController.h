//
//  ComposerViewController.h
//  TwitterCodepath
//
//  Created by Patrick Klitzke on 11/1/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "MainViewController.h"

@interface ComposerViewController : MainViewController

@property (nonatomic, copy) NSString *replyID;
@property (nonatomic, copy) NSString *replyScreenName;


@end
