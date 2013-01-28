//
//  ExitOrderViewController.h
//  WineshopApp
//
//  Created by gsy on 13-1-28.
//
//

#import <UIKit/UIKit.h>

@interface ExitOrderViewController : WSViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIAlertViewDelegate>
{
    UITableView *orderTabel;
    
    UILabel *codeLB;
    UILabel *wineNameLB;
    UILabel *roomTypeLB;
    UILabel *dataLB;
    UILabel *checkInPLB;
    UILabel *moneyTLB;
    UITextView *textView;
}
@end
