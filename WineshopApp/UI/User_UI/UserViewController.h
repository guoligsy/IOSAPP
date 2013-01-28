//
//  UserViewController.h
//  OneByOneV3
//
//  Created by michael on 8/21/12.
//
//

#import <UIKit/UIKit.h>

@interface UserViewController : WSViewController <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *groupView;
    UITextField *nameTF;
    UITextField *passTF;
    
    UITapGestureRecognizer *regTap;
    UITapGestureRecognizer *findPsdTap;
    
    BOOL isShowBackBtn;
    BOOL isShowRoot;
}

- (id)initWithLeftItem:(BOOL)isShowLeftItem;
- (id)initWithReturnRoot:(BOOL)isShowRoot1;

@end
