//
//  TileMenuView.m
//  Ctopus
//
//  Created by yueyang zheng on 12-7-18.
//  Copyright (c) 2012年 yhiker. All rights reserved.
//

#import "TileMenuView.h"

@implementation TileMenuView
@synthesize controller;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
//    [controller.bezelColor set];
//    controller.bezelColor = [UIColor colorWithWhite:0 alpha:0.50];
    [controller.bezelColor set];
	[[controller _bezelPath] fill];
}


@end
