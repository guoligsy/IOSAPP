//
//  OrderResultViewController.m
//  WineshopApp
//
//  Created by gsy on 13-1-28.
//
//

#import "OrderResultViewController.h"

@interface OrderResultViewController ()

@end

@implementation OrderResultViewController

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
//    self.navigationItem.title = @"退订";或者订单提交成功（无导航栏按钮）
    [self.rightBtn setImage:nil forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"退出" forState:UIControlStateNormal];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 100)];
    [backView setBackgroundColor:[UIColor clearColor]];
    [backView.layer setBorderWidth:1];
    [backView.layer setBorderColor:[UIColor grayColor].CGColor];
    [backView.layer setCornerRadius:15];
    [self.view addSubview:backView];
    [backView release];
    
    UIImageView *iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(7, 11, 78, 78)];
    [iconImg setImage:[UIImage imageNamed:@"CommitOrder.jpg"]];
    [backView addSubview:iconImg];
    [iconImg setBackgroundColor:[UIColor clearColor]];
    [iconImg release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(90, 7, 80, 30)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setText:@"订单编号："];
    [label setFont:FONT_SIZE_CELL_LABEL];
    [backView addSubview:label];
    [label release];
    
    orderCodeLabel  = [[UILabel alloc] initWithFrame:CGRectMake(173, 7, 130, 30)];
    [orderCodeLabel setBackgroundColor:[UIColor clearColor]];
    [orderCodeLabel setFont:FONT_SIZE_CELL_LABEL];
    [backView addSubview:orderCodeLabel];
    [orderCodeLabel setText:@"121122001605"];
    
    UILabel *tiplabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 41, 210, 56)];
    tiplabel.numberOfLines = 0;
    [tiplabel setText:@"恭喜您成功提交订单，我们将尽快确认您的订单\n请保持手机畅通，稍后以短信的形式通知您。"];
    [tiplabel setBackgroundColor:[UIColor clearColor]];
    [backView addSubview:tiplabel];
    [tiplabel release];
    
    UIButton *continueBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 145, 132, 35)];
    [continueBtn setBackgroundImage:[UIImage imageNamed:@"OSBtnImg.jpg"] forState:UIControlStateNormal];
    [continueBtn setBackgroundImage:[UIImage imageNamed:@"OSBtnImg_Sel.jpg"] forState:UIControlStateHighlighted];
    [continueBtn setTitle:@"继续预订" forState:UIControlStateNormal];
    [continueBtn addTarget:self action:@selector(continueaAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:continueBtn];
    [continueBtn release];
    
    UIButton *showOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:showOrderBtn];
    [showOrderBtn setTitle:@"查看订单" forState:UIControlStateNormal];
    [showOrderBtn setFrame:CGRectMake(169, 145, 132,35)];
    [showOrderBtn setBackgroundImage:[UIImage imageNamed:@"BBtnImg.jpg"] forState:UIControlStateNormal];
    [showOrderBtn setBackgroundImage:[UIImage imageNamed:@"BBtnImg_Sel.jpg"] forState:UIControlStateHighlighted];
    [showOrderBtn addTarget:self action:@selector(showAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)continueaAction:(id)sender
{
    
}

- (void)showAction:(id)sender
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
