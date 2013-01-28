//
//  OrderListViewController.m
//  WineshopApp
//
//  Created by sy on 1/17/13.
//
//

#import "OrderListViewController.h"
#import "OederCell.h"
#import "OrderDetailViewController.h"

@interface OrderListViewController ()

@end

@implementation OrderListViewController

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
    self.navigationItem.title = @"酒店订单";
    [self.rightBtn setImage:nil forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"退出" forState:UIControlStateNormal];
    
    CGRect tRect = self.view.bounds;
    tRect.origin.x = 5;
    tRect.origin.y = 5;
    tRect.size.width -= 10;
    tRect.size.height -= 10;
    orderListTable = [[UITableView alloc] initWithFrame:tRect style:UITableViewStyleGrouped];
    orderListTable.delegate = self;
    orderListTable.dataSource = self;
    [orderListTable setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:orderListTable];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)payAction
{
    OrderDetailViewController *orderDetailVC= [[OrderDetailViewController alloc] initWithOrderTitle:@"确认订单" status:confirmForPay];
    [self.navigationController pushViewController:orderDetailVC animated:YES];
    [orderDetailVC release];
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
    static NSString *cellID = @"OederCell";
    OederCell *orderListCell = [orderListTable dequeueReusableCellWithIdentifier:cellID];
    
    if (!orderListCell) {
        orderListCell = [[[OederCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
    }
    switch (indexPath.row) {
        case 0:
        {
            orderListCell.dateLabel.text = @"2012-12-05";
            orderListCell.wineNameLabel.text = @"上海浦东像个里拉大酒店";
            orderListCell.roomTypeLabel.text = @"平日房";
            orderListCell.priceLabel.text = @"￥1067";
            orderListCell.startDLabel.text = @"2012-12-05";
            orderListCell.endDLabel.text = @"2012-12-07";
            orderListCell.orderStatusLabel.text = @"待确认";
            [orderListCell.payBtn setHidden:YES];
        }
            break;
            
        case 1:
        {
            orderListCell.dateLabel.text = @"2012-11-11";
            orderListCell.wineNameLabel.text = @"上海国际贵都大饭店";
            orderListCell.roomTypeLabel.text = @"平日房";
            orderListCell.priceLabel.text = @"￥374";
            orderListCell.startDLabel.text = @"2012-11-11";
            orderListCell.endDLabel.text = @"2012-11-14";
            [orderListCell.payBtn setHidden:YES];
            [orderListCell.orderStatusLabel setText:@"已结束"];
//            [orderListCell.payBtn addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
            
        case 2:
        {
            orderListCell.dateLabel.text = @"2012-11-11";
            orderListCell.wineNameLabel.text = @"上海国际贵都大饭店";
            orderListCell.roomTypeLabel.text = @"平日房";
            orderListCell.priceLabel.text = @"￥374";
            orderListCell.startDLabel.text = @"2012-11-11";
            orderListCell.endDLabel.text = @"2012-11-14";
            [orderListCell.orderStatusLabel setText:@"已付款"];
            [orderListCell.payBtn setHidden:YES];
        }
            break;
            
        case 3:
        {
            orderListCell.dateLabel.text = @"2012-10-13";
            orderListCell.wineNameLabel.text = @"上海东方商旅酒店";
            orderListCell.roomTypeLabel.text = @"平日房";
            orderListCell.priceLabel.text = @"￥1166";
            orderListCell.startDLabel.text = @"2012-10-13";
            orderListCell.endDLabel.text = @"2012-10-15";
            [orderListCell.orderStatusLabel setText:@"已结束"];
            [orderListCell.payBtn setHidden:YES];
        }
            break;
            
        default:
            break;
    }
    
    
    return orderListCell;
}
//////// delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 98;
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
