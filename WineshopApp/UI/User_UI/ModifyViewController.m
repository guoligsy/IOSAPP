//
//  ModifyViewController.m
//  WineshopApp
//
//  Created by gsy on 13-1-24.
//
//

#import "ModifyViewController.h"

@interface ModifyViewController ()

@end

@implementation ModifyViewController

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
    self.navigationItem.title = @"修改密码";
    [self.rightBtn setImage:nil forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"退出" forState:UIControlStateNormal];
    
    CGRect tRect = self.view.bounds;
    tRect.origin.x = 5;
    tRect.origin.y = 5;
    tRect.size.width -= 10;
    tRect.size.height -= 10;
    
    modifyTabel = [[UITableView alloc] initWithFrame:tRect style:UITableViewStyleGrouped];
    modifyTabel.delegate = self;
    modifyTabel.dataSource = self;
    [modifyTabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:modifyTabel];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"modifyCell";
    UITableViewCell *userModifyCell = [modifyTabel dequeueReusableCellWithIdentifier:cellID];
    
    if (!userModifyCell) {
        userModifyCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 50, 30)];
        [tagLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
        [tagLabel setAdjustsFontSizeToFitWidth:YES];
        [tagLabel setBackgroundColor:[UIColor clearColor]];
        [tagLabel setTag:9990];
        [userModifyCell.contentView addSubview:tagLabel];
    }
    
    UILabel *label = (UILabel *)[userModifyCell.contentView viewWithTag:9990];
    switch (indexPath.row) {
        case 0:
        {
            [label setText:@"旧密码 ："];
            if (!oldPassTF) {
                oldPassTF = [[UITextField alloc] initWithFrame:CGRectMake(57,5,223,30)];
                oldPassTF.delegate = self;
                [userModifyCell.contentView addSubview:oldPassTF];
                oldPassTF.placeholder = @"请输入旧密码";
                oldPassTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                [oldPassTF setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
            }
            
        }
            break;
            
        case 1:
        {
            [label setText:@"新密码："];
            
            if (!newPassTF) {
                newPassTF = [[UITextField alloc] initWithFrame:CGRectMake(57,5,223,30)];
                newPassTF.delegate = self;
                [userModifyCell.contentView addSubview:newPassTF];
                newPassTF.placeholder = @"请输入新密码";
                newPassTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                [newPassTF setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
            }
        }
            break;
            
        case 2:
        {
            [label setText:@"确认密码："];
            if (!confirmTF) {
                confirmTF = [[UITextField alloc] initWithFrame:CGRectMake(57,5,223,30)];
                confirmTF.delegate = self;
                [userModifyCell.contentView addSubview:confirmTF];
                confirmTF.placeholder = @"请再次输入新密码";
                confirmTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                [confirmTF setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
            }
        }
            break;
            
        default:
            break;
    }
    
    return userModifyCell;
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
    UIView *footView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, modifyTabel.frame.size.width,60)] autorelease];
    float perHeight = 10;
    
    UIButton *logBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [logBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footView addSubview:logBtn];
    
    [logBtn setFrame:CGRectMake(5, perHeight, footView.frame.size.width - 10,40)];
    [logBtn setBackgroundImage:[UIImage imageNamed:@"YBigBtnImg.jpg"] forState:UIControlStateNormal];
    [logBtn setBackgroundImage:[UIImage imageNamed:@"YBigBtnImg_Sel.jpg"] forState:UIControlStateHighlighted];
    [logBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [logBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    return footView;
}

- (void)btnClick
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
