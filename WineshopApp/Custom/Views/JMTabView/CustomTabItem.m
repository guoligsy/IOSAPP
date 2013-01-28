#import "CustomTabItem.h"

#define kTabDemoVerticalItemPaddingSize CGSizeMake(0., 0.)
#define kTabDemoVerticalItemFont [UIFont boldSystemFontOfSize:11.]

@implementation CustomTabItem

@synthesize alternateIcon = alternateIcon_;
@synthesize tabnum;

- (void) dealloc;
{
    self.alternateIcon = nil;
    [super dealloc];
}

- (CGSize) sizeThatFits:(CGSize)size;
{
    if (tabnum==0) {
        tabnum=4;
    }
    CGSize titleSize = [self.title sizeWithFont:kTabDemoVerticalItemFont];
    
    CGFloat titleWidth = titleSize.width;
    
//    CGFloat iconWidth = 318/4;//[self.icon size].width;
    CGFloat iconWidth = 320/tabnum;
    
    CGFloat width = (iconWidth > titleWidth) ? iconWidth : titleWidth;
    
    width += (kTabDemoVerticalItemPaddingSize.width * 2);
    
    CGFloat height = 50.;
    
    return CGSizeMake(width, height);
}

- (void)drawRect:(CGRect)rect;
{
    CGRect bounds = rect;
    CGFloat yOffset = 10-5.;
    
    UIImage * iconImage = (self.highlighted || [self isSelectedTabItem]) ? self.alternateIcon : self.icon;
    
    // calculate icon position
//    CGFloat iconWidth = [iconImage size].width;
//    CGFloat iconMarginWidth = (bounds.size.width - iconWidth) / 2;
    CGFloat iconMarginWidth = (bounds.size.width - 23) / 2;
    
//    [iconImage drawAtPoint:CGPointMake(iconMarginWidth, yOffset)];
    
    [iconImage drawInRect:CGRectMake(iconMarginWidth, yOffset, 23, 23)];
    
    // calculate title position
    CGFloat titleWidth = [self.title sizeWithFont:kTabDemoVerticalItemFont].width;
    CGFloat titleMarginWidth = (bounds.size.width - titleWidth) / 2;
    
    UIColor * textColor = self.highlighted ? [UIColor lightGrayColor] : [UIColor whiteColor];
    [textColor set];
    [self.title drawAtPoint:CGPointMake(titleMarginWidth, yOffset + 25.) withFont:kTabDemoVerticalItemFont];
}

+ (CustomTabItem *)tabItemWithTitle:(NSString *)title icon:(UIImage *)icon alternateIcon:(UIImage *)alternativeIcon;
{
    CustomTabItem * tabItem = [[[CustomTabItem alloc] initWithTitle:title icon:icon] autorelease];
    tabItem.alternateIcon = alternativeIcon;

    return tabItem;
}

@end
