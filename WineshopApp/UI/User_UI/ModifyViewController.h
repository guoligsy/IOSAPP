//
//  ModifyViewController.h
//  WineshopApp
//
//  Created by gsy on 13-1-24.
//
//

#import <UIKit/UIKit.h>

@interface ModifyViewController : WSViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *modifyTabel;
    
    UITextField *oldPassTF;
    UITextField *newPassTF;
    UITextField *confirmTF;
}

@end
