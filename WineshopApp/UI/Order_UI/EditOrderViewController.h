//
//  EditOrderViewController.h
//  WineshopApp
//
//  Created by sy on 1/25/13.
//
//

#import <UIKit/UIKit.h>

@interface EditOrderViewController : WSViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *editOrderTabel;
    
    UITextField *wineNameTF;
    UITextField *dateTF;
//    UITextField *roomTypeTF;
//    UITextField *roomNumTF;
//    UITextField *moreCodTF;
    UILabel *roomTypeLabel;
    UILabel *roomNumLabel;
    UILabel *moreInfoLabel;
    
//    UITextField *amountTF;
    UILabel *amountLabel;
    UIButton *detailShowBtn;
    
    UITextField *checkinTF;
    UITextField *contactTF;
    UITextField *nameContactTF;
    UITextField *phoneContactTF;
    
    UITextField *chequeCheckTF;
    UITextField *recipientsNameTF;
    UITextField *recipientsMailAddrTF;
    UITextField *recipientsMCodeTF;
    UITextField *recipientsPNumTF;
    
    UIButton *checkDemandBtn;
    UIButton *checkNoDemandBtn;
    
    UILabel *checkDemandLabel;
    UILabel *checkNDemandLabel;
}
@end
