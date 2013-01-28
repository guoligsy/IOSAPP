//
//  UserViewController.m
//  OneByOneV3
//
//  Created by michael on 8/21/12.
//
//

#import "UserViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UserRegisterViewController.h"
#import "UserFindPsdViewController.h"
#import "UserOrderSearchViewController.h"
#import "UserDetailViewController.h"
#import "HelpTools.h"

#define LOG_STATUS 1
#define SEARCH_STATUS 2

@interface UserViewController ()

@end

@implementation UserViewController

-(void)dealloc{
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.navigationItem.title = @"用户";
        
        NSString *iconName = [NSString stringWithFormat:@"accountItem.png"];
        NSString *iconNameHL = [NSString stringWithFormat:@"accountItem.png"];
        UITabBarItem *barItem  = [[UITabBarItem alloc] initWithTitle:@"用户" image:[UIImage imageNamed:iconName] tag:0];
        if ([barItem respondsToSelector:@selector(setFinishedSelectedImage:withFinishedUnselectedImage:)]) {
            [barItem setFinishedSelectedImage:[UIImage imageNamed:iconNameHL] withFinishedUnselectedImage:[UIImage imageNamed:iconName]];
        }
        self.tabBarItem = barItem;
        [barItem release];
    }
    return self;
}

- (id)initWithLeftItem:(BOOL)isShowLeftItem
{
    isShowBackBtn = isShowLeftItem;
    return [self init];
}

- (id)initWithReturnRoot:(BOOL)isShowRoot1
{
    isShowRoot = isShowRoot1;
    return [self init];
}

-(void)loadView{
    [super loadView];
    
//    if (!isShowBackBtn) {
//        [self.leftBtn setHidden:!isShowBackBtn];
//    }
    [self.leftBtn setHidden:YES];
    
    CGRect tRect = self.view.bounds;
    tRect.origin.x = 5;
    tRect.origin.y = 5;
    tRect.size.width -= 10;
    tRect.size.height -= 10;
    groupView = [[UITableView alloc] initWithFrame:tRect style:UITableViewStyleGrouped];
    groupView.delegate = self;
    groupView.dataSource = self;
    [groupView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:groupView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if ([HelpTools isLogin]) {
        UserDetailViewController *detailVC = [[UserDetailViewController alloc] init];
        [self.navigationController pushViewController:detailVC animated:YES];
        [detailVC release];
    }
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

#pragma mark -
#pragma mark tableviewDelegate & datasource
///////// datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"userLog";
    UITableViewCell *logCell = [groupView dequeueReusableCellWithIdentifier:cellID];
    
    if (!logCell) {
        logCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 80, 30)];
        [tagLabel setBackgroundColor:[UIColor clearColor]];
        [tagLabel setTag:9990];
        [logCell.contentView addSubview:tagLabel];
    }
    
    UILabel *label = (UILabel *)[logCell.contentView viewWithTag:9990];
    if(indexPath.row == 0)
    {
        [label setText:@"登录名："];
        if (!nameTF) {
            nameTF = [[UITextField alloc] initWithFrame:CGRectMake(87, 5, 208, 30)];
            nameTF.delegate = self;
            [logCell.contentView addSubview:nameTF];
            [nameTF setPlaceholder:@"请输入昵称或手机号码"];
        }
    }
    else
    {
        [label setText:@"密  码："];
        
        if (!passTF) {
            passTF = [[UITextField alloc] initWithFrame:CGRectMake(87, 5, 208, 30)];
            passTF.delegate = self;
            [logCell.contentView addSubview:passTF];
            [passTF setPlaceholder:@"6-12位英文或数字"];
        }
    }
            
    return logCell;
}
//////// delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 170;//根据状态判断
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, groupView.frame.size.width, 170)] autorelease];
    float yPoint = 0,perHeight = 10;
    
    UIButton *logBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [logBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footView addSubview:logBtn];
    
    [logBtn setFrame:CGRectMake(5, perHeight, footView.frame.size.width - 10,35)];
    [logBtn setBackgroundImage:[UIImage imageNamed:@"YBigBtnImg.jpg"] forState:UIControlStateNormal];
    [logBtn setBackgroundImage:[UIImage imageNamed:@"YBigBtnImg_Sel.jpg"] forState:UIControlStateHighlighted];
    logBtn.tag = LOG_STATUS;
    [logBtn setTitle:@"登录" forState:UIControlStateNormal];
    [logBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    yPoint = logBtn.frame.origin.y + logBtn.frame.size.height + perHeight;
    UILabel *regLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, yPoint, 100, 30)];
    regLabel.userInteractionEnabled = YES;
    [regLabel setBackgroundColor:[UIColor clearColor]];
    regTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(regAction)];
    [regLabel addGestureRecognizer:regTap];
    [regLabel setTextColor:[UIColor orangeColor]];
    [regLabel setText:@"免费注册 >>"];
    [footView addSubview:regLabel];
    [regTap release];
    [regLabel release];
    
    
    UILabel *psdFindLabel = [[UILabel alloc] initWithFrame:CGRectMake(footView.frame.size.width + footView.frame.origin.x -107, yPoint, 100, 30)];
    psdFindLabel.userInteractionEnabled = YES;
    [psdFindLabel setBackgroundColor:[UIColor clearColor]];
    findPsdTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(findPSDAction)];
    [psdFindLabel addGestureRecognizer:findPsdTap];
    [footView addSubview:psdFindLabel];
    [psdFindLabel setText:@"忘记密码 >>"];
    [psdFindLabel setTextColor:[UIColor orangeColor]];
    [findPsdTap release];
    [psdFindLabel release];
    
    yPoint = psdFindLabel.frame.origin.y + psdFindLabel.frame.size.height + 20;
    UILabel *tipLabel  = [[UILabel alloc] initWithFrame:CGRectMake(15, yPoint, footView.frame.size.width - 30, 25)];
    [tipLabel setText:@"不是会员也可以直接预定，享受快捷"];
    [tipLabel setBackgroundColor:[UIColor clearColor]];
    [footView addSubview:tipLabel];
    [tipLabel release];
    
    yPoint += tipLabel.frame.size.height + 15;
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footView addSubview:searchBtn];
    
    [searchBtn setFrame:CGRectMake(5, yPoint, footView.frame.size.width - 10,35)];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"BBigBtnImg.jpg"] forState:UIControlStateNormal];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"BBigBtnImg_Sel.jpg"] forState:UIControlStateHighlighted];
    searchBtn.tag = SEARCH_STATUS;
    [searchBtn setTitle:@"非会员订单查询" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return footView;
}

#pragma mark -
#pragma mark 按事件
- (void)btnClick:(id)sender
{
    UIButton *tempBtn = (UIButton *)sender;
    if (tempBtn.tag == LOG_STATUS) {
        if (isShowRoot) {
            [HelpTools setAppParam:@"nini" key:@"accountNum"];
            [HelpTools setAppParam:@"nini" key:@"password"];
            [HelpTools setAppParam:@"1" key:@"userId"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            UserDetailViewController *userDetailVC = [[UserDetailViewController alloc] init];
            [self.navigationController pushViewController:userDetailVC animated:YES];
            [userDetailVC release];
        }
    }
    else
    {
        UserOrderSearchViewController *orderSearchVC = [[UserOrderSearchViewController alloc] init];
        [self.navigationController pushViewController:orderSearchVC animated:YES];
        [orderSearchVC release];
    }
}

- (void)regAction
{
    UserRegisterViewController *userRegVC = [[UserRegisterViewController alloc] init];
    [self.navigationController pushViewController:userRegVC animated:YES];
    [userRegVC release];
}

- (void)findPSDAction
{
    UserFindPsdViewController *findPSDVC= [[UserFindPsdViewController alloc] init];
    [self.navigationController pushViewController:findPSDVC animated:YES];
    [findPSDVC release];
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

@end
