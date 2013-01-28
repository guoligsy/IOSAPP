//
//  ExitOrderViewController.m
//  WineshopApp
//
//  Created by gsy on 13-1-28.
//
//

#import "ExitOrderViewController.h"
#import "OrderResultViewController.h"

@interface ExitOrderViewController ()

@end

@implementation ExitOrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)loadView
{
    [super loadView];
    [self.rightBtn setHidden:YES];
    
    CGRect tRect = self.view.bounds;
    tRect.origin.x = 5;
    tRect.origin.y = 5;
    tRect.size.width -= 10;
    tRect.size.height -= 10;
    orderTabel = [[UITableView alloc] initWithFrame:tRect style:UITableViewStyleGrouped];
    orderTabel.delegate = self;
    orderTabel.dataSource = self;
    [orderTabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:orderTabel];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != [alertView cancelButtonIndex]) {
        OrderResultViewController *orderResultVC = [[OrderResultViewController alloc] init];
        orderResultVC.navigationItem.title = @"退订";
        [self.navigationController pushViewController:orderResultVC animated:YES];
        [orderResultVC release];
    }
}

- (void)footBtnClick:(id)sender
{
    UIAlertView *alertShow = [[UIAlertView alloc] initWithTitle:@"确认退订？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertShow show];
    [alertShow release];
}

#pragma mark -
#pragma mark tableviewDelegate & datasource
///////// datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"OrderCell";
    UITableViewCell *orderCell = [orderTabel dequeueReusableCellWithIdentifier:cellID];
    
    if (!orderCell) {
        orderCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 5, 66, 30)];
        [tagLabel setBackgroundColor:[UIColor clearColor]];
        [tagLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
        [tagLabel setAdjustsFontSizeToFitWidth:YES];
        [tagLabel setTag:9990];
        [orderCell.contentView addSubview:tagLabel];
    }
    
    UILabel *tLabel = (UILabel *)[orderCell.contentView viewWithTag:9990];
    
    switch (indexPath.row) {
        case 0:
        {
            [tLabel setText:@"订单编号："];
            if (!codeLB) {
                codeLB = [[UILabel alloc] initWithFrame:CGRectMake(72, 5, orderCell.frame.size.width - 75, 30)];
                [orderCell.contentView addSubview:codeLB];
                [codeLB setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
            }
            [codeLB setText:@"1011011225566"];
        }
            break;
            
        case 1:
        {
            [tLabel setText:@"酒店名称："];
            if (!wineNameLB) {
                wineNameLB = [[UILabel alloc] initWithFrame:CGRectMake(3, 5, orderCell.frame.size.width - 7, 30)];
                [orderCell.contentView addSubview:wineNameLB];
                [wineNameLB setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
            }
            [wineNameLB setText:@"上海浦东香格里拉大酒店"];
        }
            break;
            
        case 2:
        {
            [tLabel setText:@"房  型："];
            
            if (!roomTypeLB) {
                roomTypeLB = [[UILabel alloc] initWithFrame:CGRectMake(72, 5, orderCell.frame.size.width - 75, 30)];
                [orderCell.contentView addSubview:roomTypeLB];
                [roomTypeLB setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
            }
            [roomTypeLB setText:@"周末房"];
            
        }
            break;
            
        case 3:
        {
            [tLabel setText:@"入住/离店时间："];
            [tLabel setFrame:CGRectMake(3, 5, 100, 30)];
            if (!dataLB) {
                dataLB = [[UILabel alloc] initWithFrame:CGRectMake(105, 5, orderCell.frame.size.width - 107, 30)];
                [orderCell.contentView addSubview:dataLB];
                [dataLB setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
            }
            [dataLB setText:@"2012-12-01至2012-12-08"];
        }
            break;
            
        case 4:
        {
            [tLabel setText:@"入住人："];
            
            if (!checkInPLB) {
                checkInPLB = [[UILabel alloc] initWithFrame:CGRectMake(72, 5, orderCell.frame.size.width - 75, 30)];
                [orderCell.contentView addSubview:checkInPLB];
                [checkInPLB setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
            }
            [checkInPLB setText:@"张三"];
        }
            break;
            
        case 5:
        {
            [tLabel setText:@"金额："];
            
            if (!moneyTLB) {
                moneyTLB = [[UILabel alloc] initWithFrame:CGRectMake(72, 5, 155, 30)];
                [orderCell.contentView addSubview:moneyTLB];
                [moneyTLB setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                [moneyTLB setTextColor:[UIColor redColor]];
            }
            [moneyTLB setText:@"￥1067"];
        }
            break;
            
        case 6:
        {
            [tLabel setText:@"理由："];
            
            if (!textView) {
                textView = [[UITextView alloc] initWithFrame:CGRectMake(72, 5, orderCell.frame.size.width - 75, 90)];
                textView.delegate = self;
                [textView setText:@"请输入您的退订理由"];
                [orderCell.contentView addSubview:textView];
            }
        }
            break;
            
        default:
            break;
    }
    
    return orderCell;
}
//////// delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int rowHeight = 40;
    if (indexPath.row == 6) {
        rowHeight = 100;
    }
    
    return rowHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, orderTabel.frame.size.width, 40)] autorelease];
    [footView setBackgroundColor:[UIColor clearColor]];
    
    UIButton *footBtnOne = [UIButton buttonWithType:UIButtonTypeCustom];
    [footBtnOne setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footBtnOne addTarget:self action:@selector(footBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:footBtnOne];
    [footBtnOne setFrame:CGRectMake(10 + orderTabel.frame.size.width /2.0-71, 3, 142, 35)];
    [footBtnOne setBackgroundImage:[UIImage imageNamed:@"OSBtnImg.jpg"] forState:UIControlStateNormal];
    [footBtnOne setBackgroundImage:[UIImage imageNamed:@"OSBtnImg_Sel.jpg"] forState:UIControlStateHighlighted];

    [footBtnOne setTitle:@"确认退订" forState:UIControlStateNormal];
    
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

@end
