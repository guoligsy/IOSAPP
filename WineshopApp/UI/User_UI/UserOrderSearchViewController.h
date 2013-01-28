//
//  UserDetailViewController.h
//  Ctopus
//
//  Created by Eric Yang on 8/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailViewChangeDelegate <NSObject>
-(void)detailViewChangeControl;
@end

@interface UserOrderSearchViewController : WSViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate>{
    UITableView *orderSearchTable;
    
    UITextField *phoneTF;
    UITextField *codeTF;
    
    UIButton *getCodeBtn;
}


@end
