//
//  ChooseCityViewController.h
//  WineshopApp
//
//  Created by sy on 1/28/13.
//
//

#import <UIKit/UIKit.h>

@interface ChooseCityViewController : WSViewController<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate>
{
    UITableView *cityListTable;
    
    UISearchDisplayController *_searchController;
    UISearchBar *_searchBar;
    
    NSMutableArray *filterCityList;
    NSArray *cityList;
}

@end
