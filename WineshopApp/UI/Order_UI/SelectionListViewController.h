//
//  SelectionListViewController.h
//  WineshopApp
//
//  Created by sy on 1/28/13.
//
//

#import <UIKit/UIKit.h>

@interface SelectionListViewController : WSViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *listTableView;
    
    NSArray *roomListArr;
    NSArray *priceListArr;
    NSArray *starListArr;
}

@end
