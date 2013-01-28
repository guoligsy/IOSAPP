//
//  OrderListViewController.h
//  WineshopApp
//
//  Created by sy on 1/17/13.
//
//

#import <UIKit/UIKit.h>

@interface OrderListViewController : WSViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *orderListTable;
    
}

@end
