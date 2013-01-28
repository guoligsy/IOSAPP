//
//  FeedBackViewController.m
//  WineshopApp
//
//  Created by sy on 1/21/13.
//
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()

@end

@implementation FeedBackViewController

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
    
    feedBackTV = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 300, 180)];
    feedBackTV.delegate = self;
    [feedBackTV.layer setBorderWidth:1];
    [feedBackTV.layer setBorderColor:[UIColor grayColor].CGColor];
    [feedBackTV.layer setCornerRadius:15];
    [self.view addSubview:feedBackTV];
    
    tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 25)];
    if ([self.navigationItem.title isEqualToString:@"反馈"]) {
        [tipLabel setText:@"请留下您的宝贵意见，我们会进一步完善。"];
    }
    else
    {
        [tipLabel setText:@"请输入您的要求"];
    }
    
    [tipLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_BTN]];
    [self.view addSubview:tipLabel];
    [tipLabel setTextColor:[UIColor grayColor]];
    
    if ([self.navigationItem.title isEqualToString:@"反馈"]) {
        emailTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 205, 280, 35)];
        emailTF.delegate = self;
        emailTF.placeholder = @"请输入您的邮箱";
        emailTF.borderStyle = UITextBorderStyleRoundedRect;
        [self.view addSubview:emailTF];
        
        sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 270, 280, 35)];
        [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    }
    else
    {
        sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 205, 280, 35)];
        [sendBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    }
    
    [sendBtn setBackgroundImage:[UIImage imageNamed:@"YBigBtnImg.jpg"] forState:UIControlStateNormal];
    [sendBtn setBackgroundImage:[UIImage imageNamed:@"YBigBtnImg_Sel.jpg"] forState:UIControlStateHighlighted];
    
    [sendBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [tipLabel setHidden:YES];
    return YES;
}

- (void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
