//
//  TileMenuController.h
//  Ctopus
//
//  Created by yueyang zheng on 12-7-18.
//  Copyright (c) 2012年 yhiker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TileMenuDelegate.h"

@interface TileMenuController : UIViewController
{
    BOOL _appeared;
    BOOL _tilesArranged;
    NSMutableArray *_tileButtons;
    NSMutableArray *_animationOrder;
}
@property(nonatomic,retain)NSMutableArray *tileButtons;
@property(nonatomic,retain)NSMutableArray *animationOrder;

@property(nonatomic,assign)id<TileMenuDelegate> delegate;
@property (nonatomic, readonly) CGPoint centerPoint; // in parent view's coordinate system. If menu not visible, will be CGPointZero
@property (nonatomic, assign, readonly) UIView *parentView;
@property (nonatomic, readonly) BOOL isVisible;
@property (nonatomic, readonly) NSInteger currentPage;

// N.B. All of the following properties should be set BEFORE displaying the menu.
@property (nonatomic) BOOL dismissAfterTileActivated; // automatically dismiss menu after a tile is activated (YES; default)
@property (nonatomic) BOOL rightHanded; // leave gap for right-handed finger (YES; default) or left-handed (NO)
@property (nonatomic) BOOL shadowsEnabled; // whether to draw shadows below bezel and tiles (default: YES)
@property (nonatomic) NSInteger tileSide; // width and height of each tile, in pixels (default 72 pixels)
@property (nonatomic) NSInteger tileGap; // horizontal and vertical gaps between tiles, in pixels (default: 20 pixels)
@property (nonatomic) NSInteger tileTopGap; // horizontal and vertical gaps between tiles, in pixels (default: 20 pixels)
@property (nonatomic) CGFloat cornerRadius; // corner radius for bezel and all tiles, in pixels (default: 12.0 pixels)
@property (nonatomic) CGGradientRef tileGradient; // gradient to apply to tile backgrounds (default: a lovely blue)
@property (nonatomic) NSInteger selectionBorderWidth; // default: 5 pixels
@property (nonatomic) CGGradientRef selectionGradient; // default: a subtle white (top) to grey (bottom) gradient
@property (nonatomic, retain) UIColor *bezelColor; // color of the background bezel/HUD; default: black, 50% opaque
@property (nonatomic, retain) UIImage *pageButtonImage; // default: nil (which renders an ellipsis "...")
@property (nonatomic) BOOL shouldMoveToStayVisibleAfterRotation; // whether the menu should automatically move to remain fully visible after the device has been rotated (default: YES)
@property (nonatomic)CGFloat menuWidth;
@property (nonatomic)CGFloat tileMenu_Line1Width;
@property (nonatomic)CGFloat tileMenu_Line2Width;

//method
-(id)initWithDelegate:(id<TileMenuDelegate>)theDelegate;

-(CGPoint)displayMenuCenteredOnPoint:(CGPoint)centerPt inView:(UIView*)parentView;

- (CGPoint)displayMenuPage:(NSInteger)pageNum centeredOnPoint:(CGPoint)centerPt inView:(UIView *)parentView;

- (void)dismissMenu;

// Utilities
CGRect MinimallyOverlapRects(CGRect inner, CGRect outer, CGFloat padding);
CGPoint CenterPoint(CGRect rect);
CGGradientRef CreateGradientWithColors(UIColor *topColorRGB, UIColor *bottomColorRGB); // assumes colors in RGB colorspace
- (UIBezierPath *)_bezelPath;
- (CGRect)frameForTileAtIndex:(NSInteger)tileNumber; // zero-based tileNumber, 0-5 (excludes central Close button position)
- (CGRect)frameForCenteredTile;
- (UIImage *)tileBackgroundImageHighlighted:(BOOL)highlighted;
- (UIImage *)tileBackgroundImageForTile:(NSInteger)tileNumber highlighted:(BOOL)highlighted;
- (void)tileActivated:(id)sender; // action for when each tile is actually activated/chosen, switched on tag index.
- (void)tileSelected:(id)sender; // action for when each tile is highlighted, switched on tag index.
- (void)tileDeselected:(id)sender; // action for each tile is unhighlighted, switched on tag index.
- (void)animateTilesForCurrentPage;
- (void)setAllTilesInteractionEnabled:(BOOL)enabled;
@end
