//
//  OrderDetailViewController.m
//  WineshopApp
//
//  Created by sy on 1/9/13.
//
//

#import "OrderDetailViewController.h"

@interface OrderDetailViewController ()

@end

@implementation OrderDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithOrderTitle:(NSString *)title status:(OrderStatus)status
{
    if (self = [super init]) {
        _orderStatus = status;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _orderTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _orderTableView.dataSource = self;
    _orderTableView.delegate = self;
    [self.view addSubview:_orderTableView];
    _orderTableView.backgroundColor = [UIColor clearColor];
    arrSection1 = [NSArray arrayWithObjects:@"订单状态：",@"订单编号：",@"订单总额：", nil];
    NSArray *arrL = [NSArray arrayWithObjects:@"酒店名称：",@"酒店地址：",@"酒店电话：",nil];
    NSArray *arrR = [NSArray arrayWithObjects:@"入住房型：",@"预定间数：",@"住店日期：", nil];
    arrSection2 = [NSArray arrayWithObjects:arrL,arrR,nil];
    arrSection3 = [NSArray arrayWithObjects:@"入住人：",@"联系人：",@"联系电话：", nil];
    
}

- (UILabel *)addCellControl:(int)tag frame:(CGRect)frame
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.tag = tag;
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor blackColor]];
    return [label autorelease];
}

- (void)setCellLabelText:(UIView *)view tag:(int)viewTag dataArr:(NSArray *)arr
{
    int index = 0;
    int vTag = viewTag;
    
    for (int i = 0; i < [arr count]; i++) {
        UILabel *label = (UILabel *)[view viewWithTag:vTag];
        label.text = [arr objectAtIndex:index];
        vTag += 2;
        [view addSubview:label];
    }
   
}

#pragma mark -
#pragma mark tableviewDelegate & datasource
///////// datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowNum = 1;
    if (section == 1) {
        rowNum = 2;
    }
    else if(section == 2)
    {
        if (_orderStatus == confirmForPay) {
            rowNum = 4;
        }
        
    }
    return rowNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"OrderDetail";
    UITableViewCell *orderCell = [_orderTableView dequeueReusableCellWithIdentifier:cellID];
    
    int labelTag = 9990;
    if (!orderCell) {
        int cellControlTag = labelTag;
        
        orderCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        
        if ((indexPath.section == 2) && (_orderStatus == confirmForPay)) {
            if (!payWayLabel) {
                payWayLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 180, 30)];
                [payWayLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_CELL_LABEL]];
                [payWayLabel setBackgroundColor:[UIColor clearColor]];
                payWayLabel.tag = 8999;
                [orderCell.contentView addSubview:payWayLabel];
            }
        }
        UILabel *tempLabel = nil;
        float yPoint = 7.0;
        
        int controlNum = 6;
        if ((_orderStatus == confirmForPay) && indexPath.section ==0)
        {
            controlNum = 4;
        }
        
        if (!((indexPath.section == 2) && (_orderStatus == confirmForPay))) {
            for (int i = 0; i < controlNum; i++) {
                if (i%2==0) {
                    tempLabel  = [self addCellControl:cellControlTag frame:CGRectMake(5, yPoint, 98, 22)];
                }
                else
                {
                    tempLabel  = [self addCellControl:cellControlTag frame:CGRectMake(105, yPoint, orderCell.frame.size.width - 110, 22)];
                    yPoint += 25;
                }
                cellControlTag++;
                [orderCell.contentView addSubview:tempLabel];
            }
        }
    }
    
    switch (indexPath.section) {
        case 0:
        {
            if (_orderStatus == confirmForPay)
            {
                NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:[arrSection1 count]];
                for (int i = 1; i < arrSection1.count; i++) {
                    if (i < arrSection1.count) {
                        [arr addObject:[arrSection1 objectAtIndex:i]];
                    }
                    else
                        break;
                }
                
                [self setCellLabelText:orderCell.contentView tag:labelTag dataArr:arr];
                [arr release];
            }
            else
            {
                [self setCellLabelText:orderCell.contentView tag:labelTag dataArr:arrSection1];
            }
        }
            break;
            
        case 1:
        {
            NSArray *subArr = nil;
            subArr = [arrSection2 objectAtIndex:indexPath.row];
            [self setCellLabelText:orderCell.contentView tag:labelTag dataArr:subArr];
        }
            break;
            
        case 2:
        {
            if (_orderStatus == confirmForPay) {
//                UILabel *tempLabel = (UILabel *)[orderCell.contentView viewWithTag:8999];
                
                switch (indexPath.row) {
                    case 0:
                        [payWayLabel setText:@"信用卡直接支付"];
                        break;
                        
                    case 1:
                        [payWayLabel setText:@"财付通网页支付"];
                        break;
                        
                    case 2:
                        [payWayLabel setText:@"线下转账支付"];
                        break;
                        
                    case 3:
                        [payWayLabel setText:@"账号"];
                        break;
                        
                    default:
                        break;
                }
            }
            else{
                [self setCellLabelText:orderCell.contentView tag:labelTag dataArr:arrSection3];
            }
        }
            
        default:
            break;
    }
    
    return orderCell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *titleStr = nil;
    if ((section == 2) && (_orderStatus == confirmForPay)) {
        titleStr = @"选择支付方式";
    }
    return titleStr;
}

//////// delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int rowHeight = 86.0;
    if (_orderStatus == confirmForPay) {
        if (indexPath.section ==0) {
            rowHeight = 60;
        }
        else
            if (indexPath.section == 2) {
                rowHeight =  40;
            }
    }
    return rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    float height = 0;
    if (section == 2) {
        height = 40.0;
    }
    return height;//根据状态判断
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        UIView *footView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, _orderTableView.frame.size.width, 40)] autorelease];
        [footView setBackgroundColor:[UIColor clearColor]];
        
        footBtnOne = [UIButton buttonWithType:UIButtonTypeCustom];
        [footBtnOne setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [footBtnOne addTarget:self action:@selector(footBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:footBtnOne];
        
        if(_orderStatus == WaitForPay)
        {
            [footBtnOne setFrame:CGRectMake(15, 3, 142,35)];
            [footBtnOne setBackgroundImage:[UIImage imageNamed:@"OSBtnImg.jpg"] forState:UIControlStateNormal];
            [footBtnOne setBackgroundImage:[UIImage imageNamed:@"OSBtnImg_Sel.jpg"] forState:UIControlStateHighlighted];
            [footBtnOne setTitle:@"去付款" forState:UIControlStateNormal];
            footBtnOne.tag = WaitForPay;
            
            UIButton *footBtnR = [UIButton buttonWithType:UIButtonTypeCustom];
            [footView addSubview:footBtnR];
            [footBtnR setTitle:@"取消订单" forState:UIControlStateNormal];
            [footBtnR setFrame:CGRectMake(173, 3, 142,35)];
            [footBtnR setBackgroundImage:[UIImage imageNamed:@"BBtnImg.jpg"] forState:UIControlStateNormal];
            [footBtnR setBackgroundImage:[UIImage imageNamed:@"BBtnImg_Sel.jpg"] forState:UIControlStateHighlighted];
            [footBtnR addTarget:self action:@selector(cancleOrder) forControlEvents:UIControlEventTouchUpInside];
        }
        else /*if ((_orderStatus == WaitForConfirm) || (_orderStatus == CanclePay))*/ {
            [footBtnOne setFrame:CGRectMake(15, 3, _orderTableView.frame.size.width - 30,35)];
            [footBtnOne setBackgroundImage:[UIImage imageNamed:@"YBigBtnImg.jpg"] forState:UIControlStateNormal];
            [footBtnOne setBackgroundImage:[UIImage imageNamed:@"YBigBtnImg_Sel.jpg"] forState:UIControlStateHighlighted];
            footBtnOne.tag = _orderStatus;
            if (_orderStatus == WaitForConfirm) {
                [footBtnOne setTitle:@"取消订单" forState:UIControlStateNormal];
            }
            else if(_orderStatus == CanclePay)
            {
                [footBtnOne setTitle:@"退订" forState:UIControlStateNormal];
            }
            else
            {
                [footBtnOne setTitle:@"确认支付" forState:UIControlStateNormal];
            }
        }
        return footView;
    }
    else{
        return nil;
    }
}

- (void)cancleOrder
{

}

- (void)footBtnClick:(id)sender
{
    UIButton *tempBtn = (UIButton *)sender;
    switch (tempBtn.tag) {
        case CanclePay:
            
            break;
            
        case WaitForPay:
            
            break;
            
        case confirmForPay:
            
            break;
            
        case WaitForConfirm:
            
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
