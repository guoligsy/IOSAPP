//
//  HelpViewController.m
//  WineshopApp
//
//  Created by sy on 1/21/13.
//
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

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
    self.navigationItem.title = @"帮助";
    
    searchTip = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 25)];
    [searchTip setText:@"如何查询订单？"];
    [searchDTip setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
    [searchTip setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:searchTip];
    
    searchDTip = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 300, 50)];
    [searchDTip setText:@"请登陆后，选择“订单”选项或账户“酒店订单”，即可看到。"];
    [searchDTip setBackgroundColor:[UIColor clearColor]];
    searchDTip.numberOfLines = 0;
    [searchDTip setLineBreakMode:UILineBreakModeWordWrap];
    [searchDTip setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_BTN]];
    [self.view addSubview:searchDTip];
    
    backPayTip = [[UILabel alloc] initWithFrame:CGRectMake(10, 95, 300, 25)];
    [backPayTip setText:@"如何退款？"];
    [backPayTip setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
    [backPayTip setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:backPayTip];
    
    backPayDTip = [[UILabel alloc] initWithFrame:CGRectMake(10, 95, 300, 25)];
    [backPayTip setText:@"当日预定不可退款，如需退款请过两个工作日后再进行退款。"];
    [backPayDTip setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_BTN]];
    backPayTip.numberOfLines = 0;
    [backPayTip setLineBreakMode:UILineBreakModeWordWrap];
    [backPayTip setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:backPayTip];
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
