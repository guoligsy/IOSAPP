//
//  UserDetailViewController.h
//  WineshopApp
//
//  Created by sy on 1/21/13.
//
//

#import <UIKit/UIKit.h>

@interface UserDetailViewController  : WSViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate>
{
    UITableView *userDetailTabel;
    UILabel *nicknameLabel;
}

@end
