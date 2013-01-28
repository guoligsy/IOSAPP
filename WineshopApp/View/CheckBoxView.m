//
//  CheckBoxView.m
//  WineshopApp
//
//  Created by sy on 1/28/13.
//
//

#import "CheckBoxView.h"

@implementation CheckBoxView

- (id)initWithFrame:(CGRect)frame isChecked:(BOOL)isCheck
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initial:isCheck];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)initial:(BOOL)isSel
{
    if (isSel) {
        [self setImage:[UIImage imageNamed:@"Radio_Sel.jpg"] forState:UIControlStateNormal];
    }
    else{
        [self setImage:[UIImage imageNamed:@"RadioNormal.jpg"] forState:UIControlStateNormal];
    }
    isSelected = isSel;
    
    [self addTarget:self action:@selector(switchCheckState) forControlEvents:UIControlEventTouchUpInside];
}

- ( BOOL )isChecked
{
    return isSelected ;
}

- ( void )switchCheckState
{
    isSelected = !isSelected;
    [ self setCheckState :!isSelected ];
}

- ( void )setCheckState:( BOOL )checked
{
    if (checked != isSelected ) {
        isSelected = checked;
        if (isSelected) {
            [ self setImage :[ UIImage imageNamed : @"Radio_Sel.jpg" ] forState : UIControlStateNormal ];
        } else {
            [ self setImage :[ UIImage imageNamed : @"RadioNormal.jpg" ] forState : UIControlStateNormal ];
        } 
    }
}

@end
