//
//  FeedBackViewController.h
//  WineshopApp
//
//  Created by sy on 1/21/13.
//
//

#import <UIKit/UIKit.h>

@interface FeedBackViewController : WSViewController<UITextFieldDelegate,UITextViewDelegate>
{
    UITextView *feedBackTV;
    UILabel *tipLabel;
    UITextField *emailTF;
    UIButton *sendBtn;
}

@end
