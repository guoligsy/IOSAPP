//
//  OrderViewController.m
//  WineshopApp
//
//  Created by sy on 1/7/13.
//
//

#import "OrderViewController.h"
#import "OrderListViewController.h"
#import "UserViewController.h"
#import "HelpTools.h"

@interface OrderViewController ()

@end

@implementation OrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"订单";
        NSString *iconName = [NSString stringWithFormat:@"searchItem.png"];
        NSString *iconNameHL = [NSString stringWithFormat:@"searchItem.png"];
        UITabBarItem *barItem  = [[UITabBarItem alloc] initWithTitle:@"订单" image:[UIImage imageNamed:iconName] tag:0];
        if ([barItem respondsToSelector:@selector(setFinishedSelectedImage:withFinishedUnselectedImage:)]) {
            [barItem setFinishedSelectedImage:[UIImage imageNamed:iconNameHL] withFinishedUnselectedImage:[UIImage imageNamed:iconName]];
        }
        self.tabBarItem = barItem;
        [barItem release];
        
        self.navigationItem.leftBarButtonItem = nil;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self.leftBtn setHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if (![HelpTools isLogin]) {
        UserViewController *userVC = [[UserViewController alloc] initWithReturnRoot:YES];
        [self.navigationController pushViewController:userVC animated:YES];
        [userVC release];
    }
    else
    {
        OrderListViewController *orderListVC = [[OrderListViewController alloc] init];
        [self.view addSubview:orderListVC.view];
        [orderListVC release];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
