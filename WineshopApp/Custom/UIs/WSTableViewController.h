//
//  WSTableViewController.h
//  WineshopApp
//
//  Created by sy on 1/7/13.
//
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface WSTableViewController : UITableViewController<EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView *refreshHeaderView;
    BOOL _isLoading;
}

@property (nonatomic) BOOL shouldDragRefresh;
@property (retain, nonatomic) UITableView *tableView;

//刷新数据
- (void)refreshData;
- (void)refreshComplete;

//请求更多数据
- (void)requestMoreData;

- (UITableViewCell *)dequeueLoadingCell;

@end
