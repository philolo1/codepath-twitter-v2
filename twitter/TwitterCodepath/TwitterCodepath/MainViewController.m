//
//  MainViewController.m
//  TwitterCodepath
//
//  Created by Patrick Klitzke on 11/8/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import "MainViewController.h"
#import "HamburgerView.h"
#import "TweetsViewController.h"
#import "ViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
{
  BOOL _canMoveLeft;
}

-(id)init
{
  if (self = [super init]) {
    _canMoveLeft = YES;
    self.hamburgerView = [[HamburgerView alloc] init];
    self.hamburgerView.userInteractionEnabled = YES;
    self.hamburgerView.hidden = YES;
    
    CGRect frame = self.view.frame;
    frame.origin.y = 63;
    frame.size.height = 1000;
    frame.size.width = 300;
    frame.origin.x = -frame.size.width;
    self.view.userInteractionEnabled = YES;
    
    self.hamburgerView.frame = frame;
    
    [self.view addSubview:self.hamburgerView];
    
    UIPanGestureRecognizer *help = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(onSuperDrag:)];
    [self.view addGestureRecognizer:help];
  }
  
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)onSuperDrag:(UIPanGestureRecognizer *)sender
{
  CGFloat velocityX = (0.2*[(UIPanGestureRecognizer*)sender velocityInView:self.view].x);
  if (sender.state == UIGestureRecognizerStateBegan) {
    if (velocityX > 0) {
      if (!_canMoveLeft) {
        return;
      }
      _canMoveLeft = NO;
      self.hamburgerView.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
      
      for (UIView *subview in self.view.subviews)
      {
        CGRect frame = subview.frame;
        frame.origin.x += 300;
        subview.frame = frame;
      }
    }];
    } else if (velocityX < 0) {
      if (_canMoveLeft) {
        return;
      }
      _canMoveLeft = YES;
      [UIView animateWithDuration:0.3 animations:^{
        for (UIView *subview in self.view.subviews)
        {
          CGRect frame = subview.frame;
          frame.origin.x -= 300;
          subview.frame = frame;
        }

      } completion:^(BOOL finished) {
        self.hamburgerView.hidden = YES;
      }];

    }
  }
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
