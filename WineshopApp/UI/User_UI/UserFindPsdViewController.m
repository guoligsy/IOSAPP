//
//  OneLoginViewController.m
//  Ctopus
//
//  Created by Eric Yang on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserFindPsdViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation UserFindPsdViewController

-(void)dealloc{
    [findPSDTable release];
    [phoneNumTF release];
    [codeTF release];
    [getCodeBtn release];
    
    [super dealloc];
}

-(void)loadView{
    [super loadView];
    self.navigationItem.title = @"忘记密码";
    
    CGRect tRect = self.view.bounds;
    tRect.origin.x = 5;
    tRect.origin.y = 5;
    tRect.size.width -= 10;
    tRect.size.height = 180;
    findPSDTable = [[UITableView alloc] initWithFrame:tRect style:UITableViewStyleGrouped];
    findPSDTable.delegate = self;
    findPSDTable.dataSource = self;
    [findPSDTable setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:findPSDTable];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark -
#pragma mark tableviewDelegate & datasource
///////// datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"userReg";
    UITableViewCell *findPsdCell = [findPSDTable dequeueReusableCellWithIdentifier:cellID];
    
    if (!findPsdCell) {
        findPsdCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 5,66, 30)];
        [tagLabel setBackgroundColor:[UIColor clearColor]];
        [tagLabel setAdjustsFontSizeToFitWidth:YES];
        [tagLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
        [tagLabel setTag:9990];
        [findPsdCell.contentView addSubview:tagLabel];
    }
    
    UILabel *label = (UILabel *)[findPsdCell.contentView viewWithTag:9990];
    switch (indexPath.row) {
        case 0:
        {
            [label setText:@"手机号码："];
            if (!phoneNumTF) {
                phoneNumTF = [[UITextField alloc] initWithFrame:CGRectMake(70, 5, 163, 30)];
                phoneNumTF.delegate = self;
                [findPsdCell.contentView addSubview:phoneNumTF];
                [phoneNumTF setPlaceholder:@"请输写绑定的手机号码"];
                [phoneNumTF setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                [phoneNumTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
            }
            
            if (!getCodeBtn) {
                getCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(235, 7, 50, 26)];
                [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [getCodeBtn.titleLabel setAdjustsFontSizeToFitWidth:YES];
                [getCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_BTN]];
                [getCodeBtn setBackgroundImage:[UIImage imageNamed:@"OSBtnImg.jpg"] forState:UIControlStateNormal];
                [getCodeBtn setBackgroundImage:[UIImage imageNamed:@"OSBtnImg_Sel.jpg"] forState:UIControlStateHighlighted];
                [findPsdCell.contentView addSubview:getCodeBtn];
                [getCodeBtn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
            }
        }
            break;
            
        case 1:
        {
            [label setText:@"输入验证码："];
            [label setFrame:CGRectMake(3, 5,80, 30)];
            
            if (!codeTF) {
                codeTF = [[UITextField alloc] initWithFrame:CGRectMake(85, 5, 200, 30)];
                codeTF.delegate = self;
                [findPsdCell.contentView addSubview:codeTF];
                [codeTF setPlaceholder:@"4位字符"];
                [codeTF setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                [codeTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
            }
        }
            break;
            
        case 2:
        {
            [label setFrame:CGRectMake(3, 2, 282, 38)];
            label.numberOfLines = 0;
            [label setLineBreakMode:UILineBreakModeWordWrap];
            [label setFont:[UIFont systemFontOfSize:12]];
            [label setText:@"重置密码每天限使用三次\n收到密码后，请在24小时内登录“我的果粒网”修改。"];
        }
            break;
            
        default:
            break;
    }
    
    return findPsdCell;
}
//////// delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60;//根据状态判断
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, findPSDTable.frame.size.width, 60)] autorelease];
    float perHeight = 10;
    
    UIButton *logBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [logBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footView addSubview:logBtn];
    
    [logBtn setFrame:CGRectMake(5, perHeight, footView.frame.size.width - 10,40)];
    [logBtn setBackgroundImage:[UIImage imageNamed:@"YBigBtnImg.jpg"] forState:UIControlStateNormal];
    [logBtn setBackgroundImage:[UIImage imageNamed:@"YBigBtnImg_Sel.jpg"] forState:UIControlStateHighlighted];
    [logBtn setTitle:@"发送密码至手机" forState:UIControlStateNormal];
    [logBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    return footView;
}

#pragma mark buttonAction
- (void)getCode
{
    
}

- (void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark PrivatedMethod
//判断电话号码的合法性
-(BOOL)isValidaeTelephone:(NSString *)telephone{
    NSString *telRegex = @"(^(1)+\\d{10}$)";
    NSPredicate *telTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex]; 
    return [telTest evaluateWithObject:telephone];
}
//判断email的合法性
-(BOOL)isValidateEmail:(NSString *)email{
    NSString *emailRegex = @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    return [emailTest evaluateWithObject:email];
}

#pragma mark buttonAction
//登录
-(void)buttonActionOK:(UIButton *)button{
    [phoneNumTF resignFirstResponder];
    [codeTF resignFirstResponder];
    
    
    NSString *alertStr = nil;
//    if(!_loginModule){
//        _loginModule = [[UserLoginModule alloc]init];
//        _loginModule.loginDataModuleDelegate = self;
//    }
    
    if([phoneNumTF.text length] == 0){
        alertStr = @"请先输入您的帐号";
    }else
        if([self isValidaeTelephone:phoneNumTF.text]){
//        _loginModule.loginType = [NSNumber numberWithInt:2];
    }else
        if([self isValidateEmail:phoneNumTF.text]){
//        _loginModule.loginType = [NSNumber numberWithInt:1];
    }else{
        alertStr = @"您输入的账号格式有误，请确认后重新输入";
    }

    if([phoneNumTF.text length] != 0 && [codeTF.text length] == 0){
        alertStr = @"请输入您的帐号密码";
    }
    
    if(alertStr){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"沃游提醒您" 
                                                           message:alertStr 
                                                          delegate:self 
                                                 cancelButtonTitle:@"确定" 
                                                 otherButtonTitles:nil, nil];
        
        [alertView show];
        [alertView release];
    }else {
//        _loginModule.pwd = codeTF.text;
//        _loginModule.accountNum = phoneNumTF.text;
//        [_loginModule requestLoginData];
    }
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if([string isEqualToString:@"\n"]){
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
