//
//  OrderDetailViewController.h
//  WineshopApp
//
//  Created by sy on 1/9/13.
//
//

#import <UIKit/UIKit.h>

@interface OrderDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
//    control
    UITableView *_orderTableView;
    
//    var
    NSString *_navTitle;
    OrderStatus _orderStatus;
    NSArray *arrSection1;
    NSArray *arrSection2;
    NSArray *arrSection3;
    
    UIButton *footBtnOne;
    UIButton *footBtnTwo;
    
    UILabel *payWayLabel;
}
- (id)initWithOrderTitle:(NSString *)title status:(OrderStatus)status;

@end
