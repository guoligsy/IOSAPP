//
//  UserRegisterViewController.h
//  Ctopus
//
//  Created by Eric Yang on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserRegisterViewController : WSViewController<UITextFieldDelegate,UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    UITableView *regTableView;
    UITextField *phoneTF;
    UITextField *psdTF;
    UITextField *confirmPsdTF;
    UITextField *verifyTF;
    
    UIButton *getCodeBtn;
}

@end
