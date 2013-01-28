//
//  EditOrderViewController.m
//  WineshopApp
//
//  Created by sy on 1/25/13.
//
//

#import "EditOrderViewController.h"
#import "FeedBackViewController.h"

@interface EditOrderViewController ()

@end

@implementation EditOrderViewController

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
    
    CGRect tRect = self.view.bounds;
    tRect.origin.x = 5;
    tRect.origin.y = 5;
    tRect.size.width -= 10;
    tRect.size.height -= 10;
    editOrderTabel = [[UITableView alloc] initWithFrame:tRect style:UITableViewStyleGrouped];
    editOrderTabel.delegate = self;
    editOrderTabel.dataSource = self;
    [editOrderTabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:editOrderTabel];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)footBtnClick:(id)sender
{

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

#pragma mark -
#pragma mark tableviewDelegate & datasource
///////// datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowNum = 6;
    if (section == 1) {
        rowNum = 2;
    }
    else if(section == 3)
    {
        rowNum = 1;
    }
    return rowNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"OederCell";
    UITableViewCell *orderEditCell = [editOrderTabel dequeueReusableCellWithIdentifier:cellID];
    
    if (!orderEditCell) {
        orderEditCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 5, 66, 30)];
        [tagLabel setBackgroundColor:[UIColor clearColor]];
        [tagLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
        [tagLabel setAdjustsFontSizeToFitWidth:YES];
        [tagLabel setTag:9990];
        [orderEditCell.contentView addSubview:tagLabel];
    }
    
    UILabel *tLabel = (UILabel *)[orderEditCell.contentView viewWithTag:9990];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                [tLabel setHidden:YES];
                if (!wineNameTF) {
                    wineNameTF = [[UITextField alloc] initWithFrame:CGRectMake(3, 5, orderEditCell.frame.size.width - 7, 30)];
                    wineNameTF.delegate = self;
                    [orderEditCell.contentView addSubview:wineNameTF];
                    [wineNameTF setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                    [wineNameTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
                }
                [wineNameTF setText:@"上海浦东香格里拉大酒店"];
            }
                break;
                
            case 1:
            {
                [tLabel setText:@"日  期："];
                if (!dateTF) {
                    dateTF = [[UITextField alloc] initWithFrame:CGRectMake(72, 5, orderEditCell.frame.size.width - 75, 30)];
                    dateTF.delegate = self;
                    [orderEditCell.contentView addSubview:dateTF];
                    [dateTF setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                    [dateTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
                }
                [dateTF setText:@"2012-12-04至2012-12-06"];
            }
                break;
                
            case 2:
            {
                [tLabel setText:@"房  型："];
//                if (!roomTypeTF) {
//                    roomTypeTF = [[UITextField alloc] initWithFrame:CGRectMake(72, 5, orderEditCell.frame.size.width - 75, 30)];
//                    roomTypeTF.delegate = self;
//                    [orderEditCell.contentView addSubview:roomTypeTF];
//                    [roomTypeTF setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
//                    [roomTypeTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
//                }
//                [roomTypeTF setText:@"平日房"];
                
                if (!roomTypeLabel) {
                    roomTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(72, 5, orderEditCell.frame.size.width - 75, 30)];
                    [orderEditCell.contentView addSubview:roomTypeLabel];
                    [roomTypeLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                    
                    orderEditCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                [roomTypeLabel setText:@"平日房"];

            }
                break;
                
            case 3:
            {
                [tLabel setText:@"间  数："];
                
                if (!roomNumLabel) {
                    roomNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(72, 5, orderEditCell.frame.size.width - 75, 30)];
                    [orderEditCell.contentView addSubview:roomNumLabel];
                    [roomNumLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                    orderEditCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                [roomNumLabel setText:@"1间"];
            }
                break;
                
            case 4:
            {
                [tLabel setText:@"更多要求："];
                
                if (!moreInfoLabel) {
                    moreInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(72, 5, orderEditCell.frame.size.width - 75, 30)];
                    [orderEditCell.contentView addSubview:moreInfoLabel];
                    [moreInfoLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                    moreInfoLabel.numberOfLines = 0;
                    moreInfoLabel.lineBreakMode = UILineBreakModeWordWrap;
                    [moreInfoLabel setText:@"无"];
                    orderEditCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }

            }
                break;
                
            case 5:
            {
                [tLabel setText:@"订单总额："];
                [tLabel setTextColor:[UIColor redColor]];
                
                if (!amountLabel) {
                    amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(72, 5, 155, 30)];
                    [orderEditCell.contentView addSubview:amountLabel];
                    [amountLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                    amountLabel.numberOfLines = 0;
                    amountLabel.lineBreakMode = UILineBreakModeWordWrap;
                    [amountLabel setTextColor:[UIColor redColor]];
                }
                [amountLabel setText:@"￥1067"];
                
                if (!detailShowBtn) {
                    detailShowBtn = [[UIButton alloc] initWithFrame:CGRectMake(230, 7, 65, 26)];
                    [detailShowBtn setBackgroundImage:[UIImage imageNamed:@"DetailImg.jpg"] forState:UIControlStateNormal];
                    [detailShowBtn setBackgroundImage:[UIImage imageNamed:@"DetailImg_Sel.jpg"] forState:UIControlStateHighlighted];
                    [detailShowBtn setTitle:@"详细" forState:UIControlStateNormal];
                    [detailShowBtn addTarget:self action:@selector(showDetailAction:) forControlEvents:UIControlEventTouchUpInside];
                    [orderEditCell.contentView addSubview:detailShowBtn];
                }
            }
                break;
                
            default:
                break;
        }
    }
    else if(indexPath.section == 1)
    {
        switch (indexPath.row) {
            case 0:
            {
                [tLabel setText:@"入住人"];
                
                if (!checkinTF) {
                    checkinTF = [[UITextField alloc] initWithFrame:CGRectMake(72, 5, orderEditCell.frame.size.width - 75, 30)];
                    [orderEditCell.contentView addSubview:checkinTF];
                    [checkinTF setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                    checkinTF.delegate = self;
                    [checkinTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
                    [checkinTF setPlaceholder:@"姓名"];
                }
            }
                break;
                
            case 1:
            {
                [tLabel setText:@"联系人"];
                
                if (!nameContactTF) {
                    nameContactTF = [[UITextField alloc] initWithFrame:CGRectMake(72, 5, orderEditCell.frame.size.width - 75, 30)];
                    [orderEditCell.contentView addSubview:nameContactTF];
                    [nameContactTF setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                    nameContactTF.delegate = self;
                    [nameContactTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
                    [nameContactTF setPlaceholder:@"姓名"];
                }
                
                if (!phoneContactTF) {
                    phoneContactTF = [[UITextField alloc] initWithFrame:CGRectMake(72, 5, orderEditCell.frame.size.width - 75, 30)];
                    [orderEditCell.contentView addSubview:phoneContactTF];
                    [phoneContactTF setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                    phoneContactTF.delegate = self;
                    [phoneContactTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
                    [phoneContactTF setPlaceholder:@"手机号码"];
                }

            }
                break;
                
            default:
                break;
        }
    }
    else if(indexPath.section == 2)
    {
        switch (indexPath.row) {
            case 0:
            {
                [tLabel setHidden:YES];
                if (!checkNoDemandBtn) {
                    checkNoDemandBtn = [[UIButton alloc] initWithFrame:CGRectMake(3, 5, 30, 30)];
                    [checkNoDemandBtn setImage:[UIImage imageNamed:@"RadioNormal.jpg"] forState:UIControlStateNormal];
                    [checkNoDemandBtn setImage:[UIImage imageNamed:@"Radio_Sel.jpg"] forState:UIControlStateHighlighted];
                    [orderEditCell.contentView addSubview:checkNoDemandBtn];
                    
                }
                
                if (!checkNDemandLabel) {
                    checkNDemandLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 5, 25, 25)];
                    [checkNDemandLabel setText:@"否"];
                    [checkNDemandLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                    [checkNDemandLabel setBackgroundColor:[UIColor clearColor]];
                    [orderEditCell.contentView addSubview:checkNDemandLabel];
                }
                
                if (!checkDemandBtn) {
                    checkDemandBtn = [[UIButton alloc] initWithFrame:CGRectMake(73, 5, 30, 30)];
                    [checkDemandBtn setImage:[UIImage imageNamed:@"RadioNormal.jpg"] forState:UIControlStateNormal];
                    [checkDemandBtn setImage:[UIImage imageNamed:@"Radio_Sel.jpg"] forState:UIControlStateHighlighted];
                    [orderEditCell.contentView addSubview:checkDemandBtn];
                    
                }
                
                if (!checkDemandLabel) {
                    checkDemandLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 5, 25, 25)];
                    [checkDemandLabel setText:@"是"];
                    [checkDemandLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                    [checkDemandLabel setBackgroundColor:[UIColor clearColor]];
                    [orderEditCell.contentView addSubview:checkDemandLabel];
                }

            }
                break;
                
            case 1:
            {
                [tLabel setText:@"抬头："];
                if (!chequeCheckTF) {
                    chequeCheckTF = [[UITextField alloc] initWithFrame:CGRectMake(72, 5, orderEditCell.frame.size.width - 75, 30)];
                    [orderEditCell.contentView addSubview:chequeCheckTF];
                    [chequeCheckTF setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                    chequeCheckTF.delegate = self;
                    [chequeCheckTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
                    [chequeCheckTF setPlaceholder:@"客户姓名或公司名称为抬头"];

                }
            }
                break;
                
            case 2:
            {
                [tLabel setText:@"收件人姓名："];
                if (!recipientsNameTF) {
                    recipientsNameTF = [[UITextField alloc] initWithFrame:CGRectMake(72, 5, orderEditCell.frame.size.width - 75, 30)];
                    [orderEditCell.contentView addSubview:recipientsNameTF];
                    [recipientsNameTF setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                    recipientsNameTF.delegate = self;
                    [recipientsNameTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
                    [recipientsNameTF setPlaceholder:@"请输入姓名"];
                }
            }
                break;
                
            case 3:
            {
                [tLabel setText:@"收件人手机号码："];
                [tLabel setFrame:CGRectMake(3, 5, 73, 30)];
                if (!recipientsPNumTF) {
                    recipientsPNumTF = [[UITextField alloc] initWithFrame:CGRectMake(78, 5, orderEditCell.frame.size.width - 80, 30)];
                    [orderEditCell.contentView addSubview:recipientsPNumTF];
                    [recipientsPNumTF setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                    recipientsPNumTF.delegate = self;
                    [recipientsPNumTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
                    [recipientsPNumTF setPlaceholder:@"请输入手机号码"];
                }
            }
                break;
                
            case 4:
            {
                [tLabel setText:@"邮件地址："];
                [tLabel setFrame:CGRectMake(3, 5, 73, 30)];
                if (!recipientsMailAddrTF) {
                    recipientsMailAddrTF = [[UITextField alloc] initWithFrame:CGRectMake(78, 5, orderEditCell.frame.size.width - 80, 30)];
                    [orderEditCell.contentView addSubview:recipientsMailAddrTF];
                    [recipientsMailAddrTF setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                    recipientsMailAddrTF.delegate = self;
                    [recipientsMailAddrTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
                    [recipientsMailAddrTF setPlaceholder:@"请输入详细地址"];
                }
            }
                break;
                
            case 5:
            {
                [tLabel setText:@"邮编："];
                [tLabel setFrame:CGRectMake(3, 5, 73, 30)];
                if (!recipientsMCodeTF) {
                    recipientsMCodeTF = [[UITextField alloc] initWithFrame:CGRectMake(78, 5, orderEditCell.frame.size.width - 80, 30)];
                    [orderEditCell.contentView addSubview:recipientsMCodeTF];
                    [recipientsMCodeTF setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                    recipientsMCodeTF.delegate = self;
                    [recipientsMCodeTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
                    [recipientsMCodeTF setPlaceholder:@"请输入邮编"];
                }
            }
                break;
                
            default:
                break;
        }
    }
    else
    {
        [tLabel setFrame:CGRectMake(3, 5, orderEditCell.frame.size.width - 10,60)];
        [tLabel setText:@"一经付款，不可取消或着修改订单。否则酒店将会扣除您全部的房费。"];
        [tLabel setNumberOfLines:0];
        [tLabel setLineBreakMode:UILineBreakModeWordWrap];
    }
    
    return orderEditCell;
}
//////// delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int rowHeight = 40;
    if ((indexPath.section ==0) && (indexPath.row == 4)) {
        if (moreInfoLabel && ![moreInfoLabel.text isEqualToString:@"无"]) {
            CGSize txtSize = [moreInfoLabel.text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL] constrainedToSize:CGSizeMake(moreInfoLabel.frame.size.width, 9999) lineBreakMode:UILineBreakModeWordWrap];
            if (txtSize.height > moreInfoLabel.frame.size.height) {
                CGRect lFrame = moreInfoLabel.frame;
                lFrame.size.height = txtSize.height;
                moreInfoLabel.frame = lFrame;
            }
        }
    }
    else if((indexPath.section == 1) && (indexPath.row == 2))
    {
        rowHeight *= 2;
    }
    else if(indexPath.section == 3)
    {
        rowHeight = 70;
    }
    
    return rowHeight;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 2:
            {
            
            }
                break;
                
            case 3:
            {
            }
                break;
                
            case 4:
            {
                FeedBackViewController *feedBackVC = [[FeedBackViewController alloc] init];
                feedBackVC.navigationItem.title = @"更多要求";
                [self.navigationController pushViewController:feedBackVC animated:YES];
                [feedBackVC release];

            }
                break;
                
            default:
                break;
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *titleStr = nil;
    if ((section == 2) || (section == 3)) {
        if (section == 2) {
            titleStr = @"索要发票";
        }
        else
        titleStr = @"特别提示";
    }
    return titleStr;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, editOrderTabel.frame.size.width, 40)] autorelease];
    [footView setBackgroundColor:[UIColor clearColor]];
    
    UIButton *footBtnOne = [UIButton buttonWithType:UIButtonTypeCustom];
    [footBtnOne setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footBtnOne addTarget:self action:@selector(footBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:footBtnOne];
    
    [footBtnOne setFrame:CGRectMake(15, 3, editOrderTabel.frame.size.width - 30,35)];
    [footBtnOne setBackgroundImage:[UIImage imageNamed:@"YBigBtnImg.jpg"] forState:UIControlStateNormal];
    [footBtnOne setBackgroundImage:[UIImage imageNamed:@"YBigBtnImg_Sel.jpg"] forState:UIControlStateHighlighted];
    [footBtnOne setTitle:@"提交订单" forState:UIControlStateNormal];
    
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    float height = 40.0;
    return height;//根据状态判断
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
