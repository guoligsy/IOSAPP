//
//  RootViewController.m
//  WineshopApp
//
//  Created by sy on 1/7/13.
//


#import "UINavigationBar+customImage.h"

@implementation UISearchBar (customImage)

-(void)drawRect:(CGRect)rect{
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
            break;
        }
    }
    UIImage *backgroundImage = [UIImage imageNamed:@"searchBar.png"];
    [backgroundImage drawInRect:CGRectMake(0, 0, 320, 44)];
}

@end
