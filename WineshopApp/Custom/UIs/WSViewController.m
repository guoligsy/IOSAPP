//
//  WSViewController.m
//  WineshopApp
//
//  Created by sy on 1/7/13.
//
//

#import "WSViewController.h"

@interface WSViewController ()

@end

@implementation WSViewController

@synthesize rightBtn,leftBtn;

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
    rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 30)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"NavBtn_WithTitle_Normal.jpg"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"NavBtn_WithTitle_Sel.jpg"] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(telAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:[UIImage imageNamed:@"phone.png"] forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    [rightBtnItem release];
    
    leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 30)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"NavBtn_WithTitle_Normal.jpg"] forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"NavBtn_WithTitle_Sel.jpg"] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(goBackAction) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    [leftBtnItem release];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)telAction
{
    NSString *urlStr = [NSString stringWithFormat:@"tel://%@",TEL_NUM];
   
    NSURL *telUrl = [NSURL URLWithString:urlStr];
    
    if ([[UIApplication sharedApplication] canOpenURL:telUrl]) {
        [[UIApplication sharedApplication] openURL:telUrl];
    }
    else
    {
        UIAlertView *tipAlert = [[UIAlertView alloc] initWithTitle:nil message:@"当前设备不支持拨打电话" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil ];
        [tipAlert show];
        [tipAlert release];
    }
}

- (void)goBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showWaiting:(NSString *)text withView:(UIView *)view {
    [hud release];
    hud = nil;
    
    hud = [[MBProgressHUD alloc] initWithView:view];
    [self.view addSubview:hud];
    hud.labelText = text;
    [hud show:YES];    
}

- (void)showWaiting:(NSString *)text {
    [self showWaiting:text withView:self.view];
}

- (void)hideWaiting {
    [hud hide:YES];
    [hud release];
    hud = nil;
}

- (void)dealloc {
    [hud release];
    hud = nil;
    
    [rightBtn release];
    rightBtn = nil;
    
    [leftBtn release];
    leftBtn = nil;
    
    [super dealloc];
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
