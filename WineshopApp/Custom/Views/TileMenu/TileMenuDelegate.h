//
//  TileMenuDelegate.h
//  Ctopus
//
//  Created by yueyang zheng on 12-7-18.
//  Copyright (c) 2012年 yhiker. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TileMenuController;
@protocol TileMenuDelegate <NSObject>
@required
-(NSInteger)numberOfTilesInMenu:(TileMenuController*)tileMenu;
-(UIImage*)imageForTile:(NSInteger)tileNumber inMenu:(TileMenuController*)tileMenu;
-(NSString*)labelForTile:(NSInteger)tileNumber inMenu:(TileMenuController*)tileMenu;
-(NSString*)bottomLabelForTile:(NSInteger)tileNumber inMenu:(TileMenuController*)tileMenu;
-(NSString*)descriptionForTile:(NSInteger)tileNumber inMenu:(TileMenuController*)tileMenu;
@optional
-(BOOL)isTileEnabled:(NSInteger)tileNumber inMenu:(TileMenuController*)tileMenu;

// Tile backgrounds.
@optional
- (UIImage *)backgroundImageForTile:(NSInteger)tileNumber inMenu:(TileMenuController *)tileMenu; // zero-based tileNumber
- (CGGradientRef)gradientForTile:(NSInteger)tileNumber inMenu:(TileMenuController *)tileMenu; // zero-based tileNumber
- (UIColor *)colorForTile:(NSInteger)tileNumber inMenu:(TileMenuController *)tileMenu; // zero-based tileNumber

// Interaction/notification
@required
- (void)tileMenu:(TileMenuController *)tileMenu didActivateTile:(NSInteger)tileNumber; // zero-based tileNumber
// N.B. The above method fires when the user has pressed and released a given tile, thus choosing or activating it.

@optional
- (void)tileMenuWillDisplay:(TileMenuController *)tileMenu;
- (void)tileMenuDidDisplay:(TileMenuController *)tileMenu;

- (BOOL)tileMenuShouldDismiss:(TileMenuController *)tileMenu;
- (void)tileMenuWillDismiss:(TileMenuController *)tileMenu;
- (void)tileMenuDidDismiss:(TileMenuController *)tileMenu;

- (void)tileMenu:(TileMenuController *)tileMenu didSelectTile:(NSInteger)tileNumber; // zero-based tileNumber
- (void)tileMenu:(TileMenuController *)tileMenu didDeselectTile:(NSInteger)tileNumber; // zero-based tileNumber

- (BOOL)tileMenu:(TileMenuController *)tileMenu shouldSwitchToPage:(NSInteger)pageNumber; // zero-based pageNumber
- (void)tileMenu:(TileMenuController *)tileMenu willSwitchToPage:(NSInteger)pageNumber; // zero-based pageNumber
- (void)tileMenu:(TileMenuController *)tileMenu didSwitchToPage:(NSInteger)pageNumber; // zero-based pageNumber
@end
