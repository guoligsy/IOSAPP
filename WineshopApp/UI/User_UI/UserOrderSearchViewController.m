//
//  UserDetailViewController.m
//  Ctopus
//
//  Created by Eric Yang on 8/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserOrderSearchViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "OrderListViewController.h"

#define TEXTCOLOR [UIColor colorWithRed:99/255.0 green:89/255.0 blue:89/255.0 alpha:1]
#define PICTABLEVIEW_TAG 9008
#define PROTABLEVIEW_TAG 9007

@interface UserOrderSearchViewController ()

@end

@implementation UserOrderSearchViewController
-(void)dealloc{
    [orderSearchTable release];
    [super dealloc];
}

-(void)loadView{
    [super loadView];
    self.navigationItem.title = @"订单查询";
    self.navigationItem.rightBarButtonItem = nil;
    
    orderSearchTable = [[UITableView alloc] initWithFrame:CGRectMake(5, 5, 310, 150) style:UITableViewStyleGrouped];
    orderSearchTable.delegate = self;
    orderSearchTable.dataSource = self;
    [orderSearchTable setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:orderSearchTable];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

#pragma mark -
#pragma mark tableviewDelegate & datasource
///////// datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"orderSearch";
    UITableViewCell *orderSearchCell = [orderSearchTable dequeueReusableCellWithIdentifier:cellID];
    
    if (!orderSearchCell) {
        orderSearchCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 5, 60, 30)];
        [tagLabel setBackgroundColor:[UIColor clearColor]];
        [tagLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
        [tagLabel setAdjustsFontSizeToFitWidth:YES];
        [tagLabel setTag:9990];
        [orderSearchCell.contentView addSubview:tagLabel];
    }
    
    UILabel *label = (UILabel *)[orderSearchCell.contentView viewWithTag:9990];
    switch (indexPath.row) {
        case 0:
        {
            [label setText:@"手机号码："];
            if (!phoneTF) {
                phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(65, 5, 163, 30)];
                phoneTF.delegate = self;
                [orderSearchCell.contentView addSubview:phoneTF];
                [phoneTF setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                [phoneTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
                [phoneTF setPlaceholder:@"请输入手机号码"];
            }
            
            if (!getCodeBtn) {
                getCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(230, 7, 55, 26)];
                [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [getCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_BTN]];
                [getCodeBtn.titleLabel setAdjustsFontSizeToFitWidth:YES];
                [getCodeBtn setBackgroundImage:[UIImage imageNamed:@"OSBtnImg.jpg"] forState:UIControlStateNormal];
                [getCodeBtn setBackgroundImage:[UIImage imageNamed:@"OSBtnImg_Sel.jpg"] forState:UIControlStateHighlighted];
                [orderSearchCell.contentView addSubview:getCodeBtn];
                [getCodeBtn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
            }
        }
            break;
            
        case 1:
        {
            [label setText:@"验证码："];
            
            if (!codeTF) {
                codeTF = [[UITextField alloc] initWithFrame:CGRectMake(87, 5, 208, 30)];
                codeTF.delegate = self;
                [orderSearchCell.contentView addSubview:codeTF];
                [codeTF setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                [codeTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
                [codeTF setPlaceholder:@"请输入验证码"];
            }
        }
            break;
            
        default:
            break;
    }
    
    return orderSearchCell;
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
    UIView *footView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, orderSearchTable.frame.size.width, 60)] autorelease];
    float perHeight = 10;
    
    UIButton *logBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [logBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footView addSubview:logBtn];
    
    [logBtn setFrame:CGRectMake(5, perHeight, footView.frame.size.width - 10,40)];
    [logBtn setBackgroundImage:[UIImage imageNamed:@"YBigBtnImg.jpg"] forState:UIControlStateNormal];
    [logBtn setBackgroundImage:[UIImage imageNamed:@"YBigBtnImg_Sel.jpg"] forState:UIControlStateHighlighted];
    [logBtn setTitle:@"查询" forState:UIControlStateNormal];
    [logBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    return footView;
}

#pragma mark buttonAction
- (void)getCode
{
    
}

- (void)btnClick
{
    OrderListViewController *orderListVC = [[OrderListViewController alloc] init];
    [self.navigationController pushViewController:orderListVC animated:YES];
    [orderListVC release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end