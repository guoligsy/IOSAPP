//
//  TileMenuButton.m
//  MGTileMenu
//
//  Created by yueyang zheng on 12-7-18.
//  Copyright (c) 2012年 Instinctive Code. All rights reserved.
//

#import "TileMenuButton.h"

@implementation TileMenuButton
@synthesize button = _button;
@synthesize buttonName = _buttonName;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		_button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
		_buttonName = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.width+5, frame.size.width, 20)];//add by Even zheng
		_buttonName.backgroundColor = [UIColor clearColor];
		[_buttonName setFont:[UIFont systemFontOfSize:14]];
		_buttonName.textColor = [UIColor darkGrayColor];
		_buttonName.textAlignment = UITextAlignmentCenter;
		[self addSubview:_button];
		[self addSubview:_buttonName];
    }
    return self;
}

-(void)dealloc
{
	[super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
