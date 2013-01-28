//
//  UserInfoEditViewController.m
//  WineshopApp
//
//  Created by gsy on 13-1-24.
//
//

#import "UserInfoEditViewController.h"

@interface UserInfoEditViewController ()

@end

@implementation UserInfoEditViewController

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
    
    self.navigationItem.title = @"编辑个人信息";
    [self.rightBtn setImage:nil forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"退出" forState:UIControlStateNormal];
    
    CGRect tRect = self.view.bounds;
    tRect.origin.x = 5;
    tRect.origin.y = 5;
    tRect.size.width -= 10;
    tRect.size.height -= 10;
    
    editTabel = [[UITableView alloc] initWithFrame:tRect style:UITableViewStyleGrouped];
    editTabel.delegate = self;
    editTabel.dataSource = self;
    [editTabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:editTabel];
    
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

- (void)manSel
{
    [womanBtn setSelected:NO];
}

- (void)womanSel
{
    [manBtn setSelected:NO];
}

#pragma mark -
#pragma mark tableviewDelegate & datasource
///////// datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowNum = 6;
    if (section == 0) {
        rowNum = 1;
    }
    return rowNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"editCell";
    UITableViewCell *userEditCell = [editTabel dequeueReusableCellWithIdentifier:cellID];
    
    if (!userEditCell) {
        userEditCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 50, 30)];
        [tagLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
        [tagLabel setAdjustsFontSizeToFitWidth:YES];
        [tagLabel setBackgroundColor:[UIColor clearColor]];
        [tagLabel setTag:9990];
        [userEditCell.contentView addSubview:tagLabel];
    }
    
    UILabel *label = (UILabel *)[userEditCell.contentView viewWithTag:9990];
    switch (indexPath.section) {
        case 0:
        {
            [label setText:@"昵  称："];
            if (!nickTF) {
                nickTF = [[UITextField alloc] initWithFrame:CGRectMake(57,5,223,30)];
                nickTF.delegate = self;
                [userEditCell.contentView addSubview:nickTF];
            }
            
            [nickTF setText:@"Joypull"];
        }
            break;
            
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    [label setText:@"姓  名："];
                    if (!nameTF) {
                        nameTF = [[UITextField alloc] initWithFrame:CGRectMake(57,5,223,30)];
                        nameTF.delegate = self;
                        [userEditCell.contentView addSubview:nameTF];
                    }
                    
                }
                    break;
                    
                case 1:
                {
                    [label setText:@"性  别："];
                    if (!manBtn) {
                        manBtn = [[CheckBoxView alloc] initWithFrame:CGRectMake(62,5,30,30)];
//                        [manBtn setImage:[UIImage imageNamed:@"RadioNormal.jpg"] forState:UIControlStateNormal];
//                        [manBtn setImage:[UIImage imageNamed:@"Radio_Sel.jpg"] forState:UIControlStateHighlighted];
                        [userEditCell.contentView addSubview:manBtn];
                        [manBtn setCheckState:YES];
//                        [manBtn addTarget:self action:@selector(manSel) forControlEvents:UIControlEventTouchUpInside];
                    }
                    
                    if (!manLabel) {
                        manLabel = [[UILabel alloc] initWithFrame:CGRectMake(94,10,20,20)];
                        [manLabel setText:@"男"];
                        [manLabel setBackgroundColor:[UIColor clearColor]];
                        [userEditCell.contentView addSubview:manLabel];
                    }
                    
                    if (!womanBtn) {
                        womanBtn = [[CheckBoxView alloc] initWithFrame:CGRectMake(136,5,30,30)];
//                        [womanBtn setImage:[UIImage imageNamed:@"RadioNormal.jpg"] forState:UIControlStateNormal];
//                        [womanBtn setImage:[UIImage imageNamed:@"Radio_Sel.jpg"] forState:UIControlStateHighlighted];
                        [womanBtn setCheckState:NO];
//                        [womanBtn addTarget:self action:@selector(womanSel) forControlEvents:UIControlEventTouchUpInside];
                        [userEditCell.contentView addSubview:womanBtn];
                        
                    }
                    
                    if (!womanLabel) {
                        womanLabel = [[UILabel alloc] initWithFrame:CGRectMake(168,10,20,20)];
                        [womanLabel setText:@"女"];
                        [womanLabel setBackgroundColor:[UIColor clearColor]];
                        [userEditCell.contentView addSubview:womanLabel];
                    }
                }
                    break;
                    
                case 2:
                {
                    [label setText:@"生  日"];
                    if (!birthTF) {
                        birthTF = [[UITextField alloc] initWithFrame:CGRectMake(57,5,223,30)];
                        birthTF.delegate = self;
                        [userEditCell.contentView addSubview:birthTF];
                    }
                    [birthTF setText:@"1970-01-01"];
                }
                    break;
                    
                case 3:
                {
                    [label setText:@"手  机"];
                    if (!phoneTF) {
                        phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(57,5,223,30)];
                        phoneTF.delegate = self;
                        [userEditCell.contentView addSubview:phoneTF];
                    }
                    [phoneTF setText:@"15000665011"];
                }
                    break;
                    
                case 4:
                {
                    [label setText:@"地  址："];
                    if (!addrTF) {
                        addrTF = [[UITextField alloc] initWithFrame:CGRectMake(57,5,223,30)];
                        addrTF.delegate = self;
                        [userEditCell.contentView addSubview:addrTF];
                    }
                    [addrTF setText:@"上海"];
                }
                    break;
                    
                case 5:
                {
                    [label setText:@"邮  编："];
                    if (!mailCodeTF) {
                        mailCodeTF = [[UITextField alloc] initWithFrame:CGRectMake(57,5,223,30)];
                        mailCodeTF.delegate = self;
                        [userEditCell.contentView addSubview:mailCodeTF];
                    }
                    [mailCodeTF setText:@"200000"];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
    return userEditCell;
}
//////// delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    float rowHeight = 0;
    if (section == 1) {
        rowHeight = 60;
    }
    return rowHeight;//根据状态判断
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section ==1) {
        UIView *footView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, editTabel.frame.size.width,60)] autorelease];
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
    else
    {
        return nil;
    }
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

@end
