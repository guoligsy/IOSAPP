//
//  UserDetailViewController.m
//  WineshopApp
//
//  Created by sy on 1/21/13.
//
//

#import "UserDetailViewController.h"

#import "ModifyViewController.h"
#import "OrderListViewController.h"
#import "FavoriteViewController.h"
#import "UserInfoEditViewController.h"

@interface UserDetailViewController ()

@end

@implementation UserDetailViewController

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
    self.navigationItem.title = @"我的果粒网";
    [self.rightBtn setImage:nil forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"退出" forState:UIControlStateNormal];
    
    CGRect tRect = self.view.bounds;
    tRect.origin.x = 5;
    tRect.origin.y = 5;
    tRect.size.width -= 10;
    tRect.size.height -= 10;
    
    userDetailTabel = [[UITableView alloc] initWithFrame:tRect style:UITableViewStyleGrouped];
    userDetailTabel.delegate = self;
    userDetailTabel.dataSource = self;
    [userDetailTabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:userDetailTabel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark -
#pragma mark tableviewDelegate & datasource
///////// datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowNum = 1;
    if (section == 0) {
        rowNum = 2;
    }
    return rowNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"detailCell";
    UITableViewCell *userDetailCell = [userDetailTabel dequeueReusableCellWithIdentifier:cellID];
    
    if (!userDetailCell) {
        userDetailCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 66, 30)];
        [tagLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
        [tagLabel setBackgroundColor:[UIColor clearColor]];
        [tagLabel setTag:9990];
        [userDetailCell.contentView addSubview:tagLabel];
    }
    
    UILabel *label = (UILabel *)[userDetailCell.contentView viewWithTag:9990];
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                [label setText:@"昵称："];
            }
            else
            {
                [label setText:@"修改密码"];
            }
            
            if (!nicknameLabel) {
                nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(63, 5, 180, 30)];
                [nicknameLabel setText:@"NINO"];
                [nicknameLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                [nicknameLabel setBackgroundColor:[UIColor clearColor]];
                [userDetailCell.contentView addSubview:nicknameLabel];
            }
        }
            break;
            
        case 1:
        {
            [label setText:@"酒店订单"];
        }
            break;
            
        case 2:
        {
            [label setText:@"收藏夹"];
        }
            break;
            
        case 3:
        {
            [label setFrame:CGRectMake(5, 5, 73, 30)];
            [label setText:@"常用入住人"];
        }
            break;
            
        case 4:
        {
            [label setText:@"积分：200"];
        }
            break;
            
        default:
            break;
    }
    
    return userDetailCell;
}
//////// delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                UserInfoEditViewController *userInfoVC = [[UserInfoEditViewController alloc] init];
                [self.navigationController pushViewController:userInfoVC animated:YES];
                [userInfoVC release];
            }
            else
            {
                ModifyViewController *modifypsdVC = [[ModifyViewController alloc] init];
                [self.navigationController pushViewController:modifypsdVC animated:YES];
                [modifypsdVC release];
            }
        }
            break;
            
        case 1:
        {
            OrderListViewController *orderlistVC = [[OrderListViewController alloc] init];
            [self.navigationController pushViewController:orderlistVC animated:YES];
            [orderlistVC release];
        }
            break;
            
        case 2:
        {
            FavoriteViewController *favoritaVC = [[FavoriteViewController alloc] init];
            [self.navigationController pushViewController:favoritaVC animated:YES];
            [favoritaVC release];
        }
            break;
            
        case 3://常用入住人
        {
        
        }
            break;
            
        default:
            break;
    }
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
