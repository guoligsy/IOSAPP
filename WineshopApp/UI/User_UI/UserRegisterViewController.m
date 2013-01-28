//
//  UserRegisterViewController.m
//  Ctopus
//
//  Created by Eric Yang on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserRegisterViewController.h"
#import <QuartzCore/QuartzCore.h>
#define PHONEOKTAG 99900
#define MAILOKTAG 99901

@interface UserRegisterViewController (PrivateMethod)
-(void)removeLoadingView;
-(void)popLoadingView;
-(BOOL)isValidaeTelephone:(NSString *)telephone;
-(BOOL)isValidaeTelephoneNum:(NSString *)telephone;
-(BOOL)isValidateEmail:(NSString *)email;
-(BOOL)isValidatePwdCount:(NSString *)password;
-(BOOL)isValidateContentCount:(NSString *)content;
@end

@implementation UserRegisterViewController

-(void)dealloc{
    [phoneTF release];
    [psdTF release];
    [confirmPsdTF release];
    [verifyTF release];

    [regTableView release];
    [super dealloc];
}

-(void)loadView{
    [super loadView];
    self.navigationItem.title = @"注册";
    self.navigationItem.rightBarButtonItem = nil;
    
    CGRect tRect = self.view.bounds;
    tRect.origin.x = 5;
    tRect.origin.y = 5;
    tRect.size.width -= 10;
    tRect.size.height = 210;
    
    regTableView = [[UITableView alloc] initWithFrame:tRect style:UITableViewStyleGrouped];
    regTableView.delegate = self;
    regTableView.dataSource = self;
    [regTableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:regTableView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}

#pragma mark -
#pragma mark tableviewDelegate & datasource
///////// datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"userReg";
    UITableViewCell *regCell = [regTableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!regCell) {
        regCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 5, 66, 30)];
        [tagLabel setBackgroundColor:[UIColor clearColor]];
        [tagLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
        [tagLabel setAdjustsFontSizeToFitWidth:YES];
        [tagLabel setTag:9990];
        [regCell.contentView addSubview:tagLabel];
    }
    
    UILabel *label = (UILabel *)[regCell.contentView viewWithTag:9990];
    switch (indexPath.row) {
        case 0:
        {
            [label setText:@"手机号码："];
            if (!phoneTF) {
                phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(70, 5, 165, 30)];
                phoneTF.delegate = self;
                [regCell.contentView addSubview:phoneTF];
                [phoneTF setPlaceholder:@"请输入手机号码作为登录名"];
                [phoneTF setFont:[UIFont systemFontOfSize:13]];
                [phoneTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
            }
            
            if (!getCodeBtn) {
                getCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(237, 7, 50,26)];
                [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [getCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_BTN]];
                [getCodeBtn.titleLabel setAdjustsFontSizeToFitWidth:YES];
                [getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [getCodeBtn setBackgroundImage:[UIImage imageNamed:@"OSBtnImg.jpg"] forState:UIControlStateNormal];
                [getCodeBtn setBackgroundImage:[UIImage imageNamed:@"OSBtnImg_Sel.jpg"] forState:UIControlStateHighlighted];
                [regCell.contentView addSubview:getCodeBtn];
                [getCodeBtn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
            }
        }
            break;
            
        case 1:
        {
            [label setText:@"密  码："];
            
            if (!psdTF) {
                psdTF = [[UITextField alloc] initWithFrame:CGRectMake(70, 5, 220, 30)];
                psdTF.delegate = self;
                [regCell.contentView addSubview:psdTF];
                [psdTF setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                [psdTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
                [psdTF setPlaceholder:@"6-12位字符"];
            }
        }
            break;
            
        case 2:
        {
            [label setText:@"确认密码："];
            
            if (!confirmPsdTF) {
                confirmPsdTF = [[UITextField alloc] initWithFrame:CGRectMake(70, 5, 220, 30)];
                confirmPsdTF.delegate = self;
                [regCell.contentView addSubview:confirmPsdTF];
                [confirmPsdTF setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                [confirmPsdTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
                [confirmPsdTF setPlaceholder:@"6-12位字符"];
            }
        }
            break;
            
        case 3:
        {
            [label setFrame:CGRectMake(3, 5, 80, 30)];
            [label setText:@"输入验证码："];
            
            if (!verifyTF) {
                verifyTF = [[UITextField alloc] initWithFrame:CGRectMake(85, 5, 200, 30)];
                verifyTF.delegate = self;
                [regCell.contentView addSubview:verifyTF];
                [verifyTF setPlaceholder:@"4位字符"];
                verifyTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                [verifyTF setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
            }
        }
            break;
            
        default:
            break;
    }

    return regCell;
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
    UIView *footView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, regTableView.frame.size.width,60)] autorelease];
    float perHeight = 7;
    
    UIButton *logBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [logBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footView addSubview:logBtn];
    
    [logBtn setFrame:CGRectMake(5, perHeight, footView.frame.size.width - 10,40)];
    [logBtn setBackgroundImage:[UIImage imageNamed:@"YBigBtnImg.jpg"] forState:UIControlStateNormal];
    [logBtn setBackgroundImage:[UIImage imageNamed:@"YBigBtnImg_Sel.jpg"] forState:UIControlStateHighlighted];
    [logBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [logBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    return footView;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark buttonAction
- (void)getCode
{

}

- (void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
    }else{
        return YES;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height-216.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }else{
//        [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, _buttonOK.frame.origin.y + 50 + 60)];
    }
    [UIView commitAnimations];

}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
//    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, _buttonOK.frame.origin.y + 50)];
    [textField resignFirstResponder];
    [UIView commitAnimations];
}

@end
