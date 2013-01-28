//
//  RecommendViewController.h
//  WineshopApp
//
//  Created by sy on 1/7/13.
//
//

#import <UIKit/UIKit.h>

@interface RecommendViewController : WSViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_recommendList;
    
}

@end
