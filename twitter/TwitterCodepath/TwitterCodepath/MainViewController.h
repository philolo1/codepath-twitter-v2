//
//  MainViewController.h
//  TwitterCodepath
//
//  Created by Patrick Klitzke on 11/8/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HamburgerView;

@interface MainViewController : UIViewController

@property (strong, nonatomic) HamburgerView *hamburgerView;

- (void)onSuperDrag:(UIPanGestureRecognizer *)sender;


@end
