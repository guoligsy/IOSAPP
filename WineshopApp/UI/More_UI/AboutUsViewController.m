//
//  AboutUsViewController.m
//  WineshopApp
//
//  Created by sy on 1/21/13.
//
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    self.navigationItem.title = @"关于我们";
    
    float y = self.view.center.y,x = self.view.center.x;
    
    iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(x-80, y-60, 160, 60)];
    [iconImgView setBackgroundColor:[UIColor clearColor]];
    [iconImgView setImage:[UIImage imageNamed:@"logo.png"]];
    [self.view addSubview:iconImgView];
    
     NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    vLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, y+30, 300, 25)];
    [vLabel setTextAlignment:UITextAlignmentCenter];
    [vLabel setText:[NSString stringWithFormat:@"版本号：V%@",version]];
    [vLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:vLabel];
    
    telLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, y+70, 100, 25)];
    [telLabel setTextAlignment:UITextAlignmentRight];
    [telLabel setText:@"客服电话："];
    [telLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:telLabel];
    
    telDLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, y+70, 110, 25)];
    [telDLabel setTextAlignment:UITextAlignmentLeft];
    [telDLabel setText:TEL_NUM];
    [telDLabel setTextColor:[UIColor orangeColor]];
    [telDLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:telDLabel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
