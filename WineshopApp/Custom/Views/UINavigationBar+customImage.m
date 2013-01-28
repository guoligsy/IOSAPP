//
//  RootViewController.m
//  WineshopApp
//
//  Created by sy on 1/7/13.
//
//

#import "UINavigationBar+customImage.h"

@implementation UINavigationBar (customImage)
-(void)drawRect:(CGRect)rect{
    UIImage *backgroundImage = [UIImage imageNamed:@"NavBarItemImg.png"];
    [backgroundImage drawInRect:CGRectMake(0, 0, 320, 44)];
}

@end
