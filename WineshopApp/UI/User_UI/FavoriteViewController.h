//
//  FavoriteViewController.h
//  WineshopApp
//
//  Created by gsy on 13-1-24.
//
//

#import <UIKit/UIKit.h>

@interface FavoriteViewController : WSViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *collectTable;
}

@end
