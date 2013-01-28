//
//  TileMenuButton.h
//  MGTileMenu
//
//  Created by yueyang zheng on 12-7-18.
//  Copyright (c) 2012年 Instinctive Code. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TileMenuButton : UIView
{
	UIButton* _button;
	UILabel* _buttonName;
}
@property(nonatomic,retain)UIButton* button;
@property(nonatomic,retain)UILabel* buttonName;

@end
