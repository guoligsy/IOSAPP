//
//  UserLoginViewController.h
//  Ctopus
//
//  Created by Eric Yang on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserFindPsdViewController : WSViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>{
    UITableView *findPSDTable;
    
    UITextField *phoneNumTF;
    UITextField *codeTF;
    
    UIButton *getCodeBtn;
}

@end
