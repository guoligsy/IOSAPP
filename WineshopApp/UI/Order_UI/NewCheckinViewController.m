//
//  NewCheckinViewController.m
//  WineshopApp
//
//  Created by sy on 1/28/13.
//
//

#import "NewCheckinViewController.h"

@interface NewCheckinViewController ()

@end

@implementation NewCheckinViewController

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
    [self.rightBtn setHidden:YES];
    self.navigationItem.title = @"新增入住人";
    
    backView = [[UIView alloc] initWithFrame:CGRectMake(5, 10, 310, 40)];
    [backView setBackgroundColor:[UIColor clearColor]];
    backView.layer.cornerRadius = 10;
    [self.view addSubview:backView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 5, 60, 30)];
    [nameLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
    [nameLabel setText:@"姓  名："];
    [backView addSubview:nameLabel];
    [nameLabel release];
    
    nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(65, 3, 245, 35)];
    nameTextField.delegate = self;
    [nameTextField setPlaceholder:@"中文或英文"];
    [backView addSubview:nameTextField];
    [nameTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [nameTextField setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 60, 300, 40)];
    [button.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
    [button setTitle:@"确认添加" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button setBackgroundImage:[UIImage imageNamed:@"YBigBtnImg.jpg"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"YBigBtnImg_Sel.jpg"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [button release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)addAction:(id)sender
{

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
