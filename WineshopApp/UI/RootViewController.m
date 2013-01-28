//
//  RootViewController.m
//  WineshopApp
//
//  Created by sy on 1/7/13.
//
//

#import "RootViewController.h"

#import "SearchViewController.h"
#import "MoreViewController.h"
#import "OrderViewController.h"
#import "RecommendViewController.h"
#import "UserViewController.h"

#import "CustomTabItem.h"
#import "CustomSelectionView.h"
#import "HelpTools.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    [_tabController release];
    [_clickNumArray release];
    
    WS_RELEASE_SAFELY(_searchViewController);
    WS_RELEASE_SAFELY(_specialViewController);
    WS_RELEASE_SAFELY(_orderViewController);
    WS_RELEASE_SAFELY(_userViewController);
    WS_RELEASE_SAFELY(_moreViewController);
    
    [super dealloc];
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _searchViewController = [[UINavigationController alloc] initWithRootViewController:[[[SearchViewController alloc] init] autorelease]];
    _specialViewController = [[UINavigationController alloc] initWithRootViewController:[[[RecommendViewController alloc] init] autorelease]];
    _orderViewController = [[UINavigationController alloc] initWithRootViewController:[[[OrderViewController alloc] init] autorelease]];
    _userViewController = [[UINavigationController alloc] initWithRootViewController:[[[UserViewController alloc] initWithReturnRoot:NO] autorelease]];
    _moreViewController = [[UINavigationController alloc] initWithRootViewController:[[[MoreViewController alloc] init] autorelease]];
    
    _tabController = [[UITabBarController alloc] init];
    _tabController.delegate = self;
    
   _tabController.viewControllers = [NSArray arrayWithObjects:_searchViewController,_specialViewController,_orderViewController,_userViewController,_moreViewController,nil];
    _tabController.view.frame = self.view.bounds;
    [self.view addSubview:_tabController.view];
    
    [_tabController.tabBar setBackgroundImage:[UIImage imageNamed:@"TabBarBackImg.png"]];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
    {
        _tabController.tabBar.selectionIndicatorImage = [UIImage imageNamed:IMG_TABBAR_SEL];
    }
    else
    {
        [self setTabbarBackImg];
    }
    
}

- (void)setTabbarBackImg
{
    NSArray * tabBarSubviews = [_tabController.tabBar subviews];
    
    int index4SelView;
    
    if(_tabController.selectedIndex+1 > 4)
    {//selected the last tab.
        index4SelView = [tabBarSubviews count]-1;
    }
    if([tabBarSubviews count] < index4SelView+1)
    {
        assert(false);
        return;
    }
    UIView * selView = [tabBarSubviews objectAtIndex:index4SelView];
    
    NSArray * selViewSubviews = [selView subviews];
    
    for(UIView * v in selViewSubviews)
    {
        if(v && [NSStringFromClass([v class]) isEqualToString:@"UITabBarSelectionIndicatorView"])
            
        {//the v is the highlight view.
            UIImageView *selBackImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:IMG_TABBAR_SEL]];
            [selView insertSubview:selBackImg belowSubview:v];
            [v removeFromSuperview];
            
            break;
            
        }
    }
}

#pragma mark UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    [viewController viewWillAppear:YES];
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([[tabBarController viewControllers] objectAtIndex:tabBarController.selectedIndex] == viewController)
    {
        return NO;
    }
    else
    {
        return YES;
    }   
}
@end
