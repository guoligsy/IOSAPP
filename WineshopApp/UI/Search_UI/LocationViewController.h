//
//  LocationViewController.h
//  WineshopApp
//
//  Created by sy on 1/28/13.
//
//

#import <UIKit/UIKit.h>

@interface LocationViewController : WSViewController<UITableViewDataSource,UITableViewDelegate>
{
//    UIButton *areaLocationBtn;
//    UIButton *busDistrictBtn;
    
    UITableView *listView;
    
    NSArray *locationArr;
}
@end
