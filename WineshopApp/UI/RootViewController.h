//
//  RootViewController.h
//  WineshopApp
//
//  Created by sy on 1/7/13.
//
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UITabBarControllerDelegate>
{
    UINavigationController *_searchViewController;
    UINavigationController *_specialViewController;
    UINavigationController *_orderViewController;
    UINavigationController *_userViewController;
    UINavigationController *_moreViewController;
    UITabBarController *_tabController;
    
    NSMutableArray *_clickNumArray;
}

@end
