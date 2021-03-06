//  Created by Jason Morrissey

#import "CustomSelectionView.h"
#import "UIView+InnerShadow.h"
#import "UIColor+Hex.h"

#define kTriangleHeight 1.

@implementation CustomSelectionView

- (void)drawRect:(CGRect)rect
{
    [[UIColor colorWithHex:0x252525] set];
    CGRect squareRect = CGRectOffset(rect, 0, kTriangleHeight);
    squareRect.size.height -= kTriangleHeight*2;
    UIBezierPath * squarePath = [UIBezierPath bezierPathWithRoundedRect:squareRect cornerRadius:2.];
    [squarePath fill];
    
//    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
//    [trianglePath moveToPoint:CGPointMake(rect.size.width / 2 - kTriangleHeight, kTriangleHeight)];
//    [trianglePath addLineToPoint:CGPointMake(rect.size.width / 2, 0.)];
//    [trianglePath addLineToPoint:CGPointMake(rect.size.width / 2 + kTriangleHeight, kTriangleHeight)];
//    [trianglePath closePath];
//    [trianglePath fill];
}

+ (CustomSelectionView *) createSelectionView;
{
    CustomSelectionView * selectionView = [[[CustomSelectionView alloc] initWithFrame:CGRectZero] autorelease];
//    selectionView.backgroundColor = [UIColor redColor];
    return selectionView;
}

@end
