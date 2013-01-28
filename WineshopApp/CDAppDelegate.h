//
//  CDAppDelegate.h
//  WineshopApp
//
//  Created by sy on 1/7/13.
//
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface CDAppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController *mainViewController;

+(CDAppDelegate *)instance;
@end
