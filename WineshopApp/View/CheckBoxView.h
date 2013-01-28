//
//  CheckBoxView.h
//  WineshopApp
//
//  Created by sy on 1/28/13.
//
//

#import <UIKit/UIKit.h>

@interface CheckBoxView : UIButton
{
    BOOL isSelected;
    
}

- (id)initWithFrame:(CGRect)frame isChecked:(BOOL)isCheck;
- ( void )setCheckState:( BOOL )checked;
- ( BOOL )isChecked;
@end
