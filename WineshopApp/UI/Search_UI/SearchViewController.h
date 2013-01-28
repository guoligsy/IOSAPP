//
//  SearchViewController.h
//  WineshopApp
//
//  Created by sy on 1/7/13.
//
//

#import <UIKit/UIKit.h>

@interface SearchViewController : WSViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *searchTabel;
    UILabel *cityLabel;
    UILabel *checkInTimeLabel;
    UILabel *leaveTimeLabel;
    UILabel *priceLabel;
    UILabel *starLabel;
    UILabel *areaLabel;
    
    UITextField *wineInfoTF;
    
    UIImageView *backView;
    UIDatePicker *datePicker;
    
    NSString *priceStr;
    NSString *starStr;
    NSString *cityName;
    NSString *areaName;
    NSString *datestr;
    
    int cellIndex;
}

@property (nonatomic, retain) NSString *priceStr;
@property (nonatomic, retain) NSString *starStr;
@property (nonatomic, retain) NSString *cityName;
@property (nonatomic, retain) NSString *areaName;
@end
