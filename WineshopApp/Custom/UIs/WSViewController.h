//
//  WSViewController.h
//  WineshopApp
//
//  Created by sy on 1/7/13.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface WSViewController : UIViewController
{
    NSString *_string;   
    
    MBProgressHUD *hud;
    UIButton *rightBtn;
    UIButton *leftBtn;
}

@property (nonatomic, retain) UIButton *rightBtn;
@property (nonatomic, retain) UIButton *leftBtn;

- (void)showWaiting:(NSString *)text;
- (void)showWaiting:(NSString *)text withView:(UIView *)view;
- (void)hideWaiting;
@end
