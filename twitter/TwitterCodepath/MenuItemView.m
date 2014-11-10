//
//  MenuItemView.m
//  TwitterCodepath
//
//  Created by Patrick Klitzke on 11/9/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import "MenuItemView.h"

@implementation MenuItemView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame contentText:(NSString *)contentText
{
  if (self = [super initWithFrame:frame]) {
    
    UILabel *text = [[UILabel alloc] init];
    text.frame = CGRectMake(30, 0, 270, 50);
    text.font = [UIFont systemFontOfSize:20];
    text.text = contentText;
    [self addSubview:text];
  }
  
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
}

- (CGSize)sizeThatFits:(CGSize)size
{
  [super sizeThatFits:size];
  return CGSizeMake(size.width, 40);
}

@end
