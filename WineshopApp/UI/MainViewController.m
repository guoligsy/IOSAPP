//
//  MainViewController.m
//  WineshopApp
//
//  Created by sy on 1/8/13.
//
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UINavigationBar *naviBar = [[UINavigationBar alloc] init];
    if ([naviBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"NavBarItemImg.png"] forBarMetrics:UIBarMetricsDefault];
    }
    [naviBar release];
    
    _rootTabController = [[RootViewController alloc] init];
    _rootTabController.view.frame = self.view.bounds;
	[self.view insertSubview:_rootTabController.view atIndex:0];
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
