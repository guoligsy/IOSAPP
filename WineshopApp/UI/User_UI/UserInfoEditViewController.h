//
//  UserInfoEditViewController.h
//  WineshopApp
//
//  Created by gsy on 13-1-24.
//
//

#import <UIKit/UIKit.h>
#import "CheckBoxView.h"

@interface UserInfoEditViewController : WSViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *editTabel;
    
    UITextField *nickTF;
    UITextField *nameTF;
    UITextField *birthTF;
    UITextField *phoneTF;
    UITextField *addrTF;
    UITextField *mailCodeTF;
    
    CheckBoxView *manBtn;
    CheckBoxView *womanBtn;
    
    UILabel *womanLabel;
    UILabel *manLabel;
}
@end
