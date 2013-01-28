//
//  TileMenuController.m
//  Ctopus
//
//  Created by yueyang zheng on 12-7-18.
//  Copyright (c) 2012年 yhiker. All rights reserved.
//

#import "TileMenuController.h"
#import "TileMenuView.h"
#import <QuartzCore/QuartzCore.h>
#import "TileMenuButton.h"

// Various keys for internal use.
#define ANIMATION_APPEAR		@"Appear"
#define ANIMATION_DISAPPEAR	@"Disappear"
#define ANIMATION_TILES		@"Tiles"
#define ANIMATION_TILE_LAYER	@"TileLayer"
#define ANIMATION_TILE_INDEX	@"TileIndex"
// Geometry and appearance.
#define PARENTVIEW_EDGE_INSET	3.0 // minimum inset in pixels from edges of parent view
#define TILES_PER_PAGE	7 // not including paging tile (or Close button)
#define DISABLED_TILE_OPACITY	0.65 // from 0.0 (fully transparent/hidden) to 1.0 (fully opaque/visible)
// Timing.
#define ANIMATION_DURATION	0.15 // seconds
#define ACTIVATION_DISMISS_DELAY	0.25 // seconds; delay between activating a tile and auto-dismissing the menu (if appropriate)

@interface TileMenuController ()

@end
CGFloat tileMenu_label_height = 20;
@implementation TileMenuController
@synthesize animationOrder = _animationOrder;
@synthesize tileButtons = _tileButtons;

@synthesize delegate = _delegate;
@synthesize centerPoint = _centerPoint;
@synthesize parentView = _parentView;
@synthesize isVisible = _isVisible;
@synthesize currentPage = _currentPage;

@synthesize dismissAfterTileActivated = _dismissAfterTileActivated;
@synthesize rightHanded = _rightHanded;
@synthesize shadowsEnabled = _shadowsEnabled;
@synthesize tileSide = _tileSide;
@synthesize tileGap = _tileGap;
@synthesize tileTopGap = _tileTopGap;
@synthesize menuWidth = _menuWidth;
@synthesize tileMenu_Line1Width = _tileMenu_Line1Width;
@synthesize tileMenu_Line2Width = _tileMenu_Line2Width;
@synthesize cornerRadius = _cornerRadius;
@synthesize tileGradient = _tileGradient;
@synthesize selectionBorderWidth = _selectionBorderWidth;
@synthesize selectionGradient = _selectionGradient;
@synthesize bezelColor = _bezelColor;
@synthesize pageButtonImage = _pageButtonImage;
@synthesize shouldMoveToStayVisibleAfterRotation = _shouldMoveToStayVisibleAfterRotation;
#pragma mark - Creation and destruction
-(id)initWithDelegate:(id<TileMenuDelegate>)theDelegate
{
    if (theDelegate && [theDelegate conformsToProtocol:@protocol(TileMenuDelegate)]) {
        _delegate = theDelegate;
        self = [self initWithNibName:nil bundle:nil];
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _centerPoint = CGPointZero;
        _isVisible = NO;
		_currentPage = 0;
        _dismissAfterTileActivated = YES;
        _rightHanded = YES;
        _shadowsEnabled = YES;
        _tileSide = 40+15;//add by Even zheng
        _tileGap = 30-15;
        _tileTopGap = 18-10;
		_cornerRadius = 3.0;//add by Even zheng
		
		_tileMenu_Line1Width = (_tileSide*4)+(_tileGap*3);
		_tileMenu_Line2Width = (_tileSide*3)+(_tileGap*2);
		_menuWidth = _tileMenu_Line1Width+(_tileGap*2);//add by Even zheng
		_tileGradient = CreateGradientWithColors([UIColor colorWithRed:0.28+0.5 green:0.67+0.1 blue:0.90-0.4 alpha:1.0], 
												   [UIColor colorWithRed:0.19 green:0.46 blue:0.76 alpha:1.0]);		
		_selectionBorderWidth = 2;
		_selectionGradient = CreateGradientWithColors([UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0], 
														[UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.0]);
		self.bezelColor = [UIColor colorWithWhite:1.0 alpha:0.5+0.3];
        _pageButtonImage = nil;
		_shouldMoveToStayVisibleAfterRotation = YES;
		
		// Clockwise from left.
		_animationOrder = [NSMutableArray arrayWithObjects:
						   [NSNumber numberWithInteger:3], 
						   [NSNumber numberWithInteger:0], 
						   [NSNumber numberWithInteger:1], 
						   [NSNumber numberWithInteger:2], 
						   [NSNumber numberWithInteger:4],
						   [NSNumber numberWithInteger:5],
						   [NSNumber numberWithInteger:6],//add by Even zheng
                           nil];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
	CGGradientRelease(_tileGradient);
	CGGradientRelease(_selectionGradient);
}

-(void)loadView
{
    NSInteger bezelSize = (self.tileSide * 3) + (self.tileGap * 2);
    self.view = [[TileMenuView alloc] initWithFrame:CGRectMake(0, 0, bezelSize, bezelSize)];
    ((TileMenuView*)(self.view)).controller = self;
    
    self.view.opaque = NO;
    self.view.layer.opaque = NO;
    
    self.view.layer.shadowRadius = 2.0;
    self.view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.view.layer.shadowOpacity = 0.5;//add by Even zheng
    self.view.layer.shadowOffset = CGSizeMake(0,5);
    if (!_shadowsEnabled) {
        self.view.layer.shadowRadius = 0;
        self.view.layer.shadowOffset = CGSizeZero;
    }
//    self.view.backgroundColor = [UIColor blueColor];
    //Tiles
    _tileButtons = [NSMutableArray arrayWithCapacity:3];
    UIImage *tileImage = [self tileBackgroundImageHighlighted:NO];
    
    TileMenuButton *tileButton;
    CGRect tileFrame = CGRectZero;
    tileFrame.size = tileImage.size;
    
//    NSInteger j;
    NSInteger numTiles = TILES_PER_PAGE;
    
    for (int i =0; i < numTiles; i++) {
        tileButton = [[TileMenuButton alloc] initWithFrame:CGRectMake(0, 0, _tileSide, _tileSide)];//add by Even zheng
        //config tile name
        tileButton.buttonName.text = [_delegate bottomLabelForTile:i inMenu:self];
        tileButton.userInteractionEnabled = NO;
        tileButton.button.tag = i;
        tileButton.frame = [self frameForCenteredTile];
        
        //config tile button
//        j = [[_animationOrder objectAtIndex:i] integerValue];
        tileButton.layer.zPosition = [_animationOrder indexOfObject:[NSNumber numberWithInt:i]];
        
        [tileButton.button addTarget:self action:@selector(tileActivated:) forControlEvents:UIControlEventTouchUpInside];
        
        [tileButton.button addTarget:self action:@selector(tileSelected:) forControlEvents:UIControlEventTouchDown];
        
        [tileButton.button addTarget:self action:@selector(tileDeselected:) forControlEvents:UIControlEventTouchUpOutside|UIControlEventTouchDragExit];
        [_tileButtons addObject:tileButton];
        [self.view addSubview:tileButton];
        [tileButton release];
    }
    _appeared = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.bezelColor = nil;
	self.pageButtonImage = nil;
	_animationOrder = nil;
	_tileButtons = nil;
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Utilities
CGRect MinimallyOverlapRects(CGRect inner, CGRect outer, CGFloat padding)
{
    CGRect newInner = inner;
    CGFloat doublePadding = padding * 2.0;
    
    if ((inner.size.width + doublePadding) <= outer.size.width && (inner.size.height + doublePadding) <= outer.size.height) {
        
        // Left edge
        if (newInner.origin.x < (outer.origin.x + padding)) {
            newInner.origin.x = (outer.origin.x + padding);
        }
        
        // Top edge
        if (newInner.origin.y < (outer.origin.y + padding)) {
            newInner.origin.y = (outer.origin.y + padding);
        }
        
        // Right edge
        if (CGRectGetMaxX(newInner) > (CGRectGetMaxX(outer) - padding)) {
            newInner.origin.x = CGRectGetMaxX(outer) - (padding + newInner.size.width);
        }
        
        // Bottom edge
        if (CGRectGetMaxY(newInner) > (CGRectGetMaxY(outer) - padding)) {
            newInner.origin.y = CGRectGetMaxY(outer) - (padding + newInner.size.height);
        }
    }
    
    return newInner;
}

CGPoint CenterPoint(CGRect rect)
{
	return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}


CGGradientRef CreateGradientWithColors(UIColor *topColorRGB, UIColor *bottomColorRGB)
{
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	CGFloat locations[2] = {0, 1};
	CGFloat topRed, topGreen, topBlue, topAlpha, bottomRed, bottomGreen, bottomBlue, bottomAlpha;
	[topColorRGB getRed:&topRed green:&topGreen blue:&topBlue alpha:&topAlpha];
	[bottomColorRGB getRed:&bottomRed green:&bottomGreen blue:&bottomBlue alpha:&bottomAlpha];
	CGFloat gradientColors[] =
	{
		topRed, topGreen, topBlue, topAlpha, 
		bottomRed, bottomGreen, bottomBlue, bottomAlpha,
	};
	CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, gradientColors, locations, 2);
	CGColorSpaceRelease(rgb);
	
	return gradient; // follows the "Create rule"; i.e. must be released by caller (even with ARC)
}

-(UIBezierPath*)_bezelPath
{
    CGRect bezelRect = self.view.bounds;
    bezelRect.origin.x = 0;
    bezelRect.origin.y = 0;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:bezelRect cornerRadius:_cornerRadius];
    return path;
}

-(CGRect)frameForTileAtIndex:(NSInteger)tileNumber
{
    //the left top frame
    CGRect frame = CGRectMake(_tileGap, _tileTopGap, _tileSide, _tileSide);
    
    if (tileNumber >= 1 && tileNumber <=3) {
		frame.origin.x = (_tileSide + _tileGap)*tileNumber+_tileGap;
	}
	
	if (tileNumber > 3) {
		frame.origin.x = _tileGap+(_tileMenu_Line1Width - _tileMenu_Line2Width)/2 + (_tileSide + _tileGap)*(tileNumber-4);
		frame.origin.y = _tileSide + _tileTopGap*2+tileMenu_label_height;
	}
	
	return frame;
}

- (CGRect)frameForCenteredTile
{
	CGRect frame = CGRectMake(0, 0, _tileSide, _tileSide);
	CGRect bezelBounds = self.view.bounds;
	frame.origin.x = (bezelBounds.size.width - _tileSide) / 2.0;
	frame.origin.y = (bezelBounds.size.height - _tileSide) / 2.0;
	return frame;
}

-(UIImage*)tileBackgroundImageHighlighted:(BOOL)highlighted
{
    //return [self tileBackgroundImageForTile:-1 highlighted:highlighted];
    return nil;
}

-(UIImage*)tileBackgroundImageForTile:(NSInteger)tileNumber highlighted:(BOOL)highlighted
{
    CGRect tileRect = CGRectMake(0, 0, _tileSide, _tileSide);
    if (UIGraphicsBeginImageContextWithOptions!=NULL) {
        UIGraphicsBeginImageContextWithOptions(tileRect.size, NO, 0.0);
    }else {
        UIGraphicsBeginImageContext(tileRect.size);
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    
    // Clip drawing to within tile's rounded path.
    CGContextSaveGState(context);
    UIBezierPath *roundedPath = [UIBezierPath bezierPathWithRoundedRect:tileRect cornerRadius:_cornerRadius];
    [roundedPath addClip];
    
    //fill rounded path with relevant background
    CGRect pathBoundsRect = [roundedPath bounds];
    CGPoint start = CGPointMake(CGRectGetMidX(pathBoundsRect), CGRectGetMinY(pathBoundsRect));
	CGPoint end = CGPointMake(CGRectGetMidX(pathBoundsRect), CGRectGetMaxY(pathBoundsRect));
    
    BOOL drawnBackground = NO;
    if (_delegate) {
        if([_delegate respondsToSelector:@selector(backgroundImageForTile:inMenu:)]){
            UIImage* bg = [_delegate backgroundImageForTile:tileNumber inMenu:self];
            if (bg) {
                [bg drawInRect:pathBoundsRect];
                drawnBackground = YES;
            }
        }
        
        if (!drawnBackground && [_delegate respondsToSelector:@selector(gradientForTile:inMenu:)]) {
            CGGradientRef gradient = [_delegate gradientForTile:tileNumber inMenu:self];
            if (gradient) {
                CGContextDrawLinearGradient(context, gradient, start, end, 0);
                drawnBackground = YES;
            }
        }
        
        if (!drawnBackground && [_delegate respondsToSelector:@selector(colorForTile:inMenu:)]) {
            UIColor *color = [_delegate colorForTile:tileNumber inMenu:self];
            if (color) {
                [color set];
                UIRectFill(pathBoundsRect);
                drawnBackground = YES;
            }
        }
    }
    
    if (!drawnBackground) {
        CGContextDrawLinearGradient(context, _tileGradient, start, end, 0);
    }
    
    CGContextRestoreGState(context);
    
    // Expand the clipping area slightly so tile background doesn't show as a fringe around the corners.
    CGFloat factor = -0.4;
    CGRect expandedRect = CGRectInset(tileRect, factor, factor);
    UIBezierPath *expandedPath = [UIBezierPath bezierPathWithRoundedRect:expandedRect cornerRadius:_cornerRadius+1.0];
    [expandedPath addClip];
    
    // 'Stroke' path with gradient if highlighted.
    if (highlighted) {
        // Obtain path for a border around roundedPath, of twice the selectionBorderWidth.
        CGPathRef borderPath = CGPathCreateCopyByStrokingPath(roundedPath.CGPath, NULL, _selectionBorderWidth*2, roundedPath.lineCapStyle, roundedPath.lineJoinStyle, roundedPath.miterLimit);
        
        //Clip to path
        CGContextAddPath(context, borderPath);
        CGContextClip(context);
        
        //draw selection gradient
        CGContextDrawLinearGradient(context, _selectionGradient, start, end, 0);
        
        //dispose of temporary border path
        CGPathRelease(borderPath);
    }
    
    UIGraphicsPopContext();
    UIImage *tileImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tileImage;

}

-(void)tileActivated:(id)sender
{
    NSInteger tileNumber = ((UIButton*)sender).tag+(_currentPage*7);
    if (self.delegate && [self.delegate respondsToSelector:@selector(tileMenu:didActivateTile:)]) {
        [self.delegate tileMenu:self didActivateTile:tileNumber];
    }
}

- (void)tileSelected:(id)sender
{
	// Inform delegate.
	NSInteger tileNumber = ((UIButton *)sender).tag + (_currentPage * 7);
	if (self.delegate && [self.delegate respondsToSelector:@selector(tileMenu:didSelectTile:)]) {
		[self.delegate tileMenu:self didSelectTile:tileNumber];
	}
}

- (void)tileDeselected:(id)sender
{
	// Inform delegate.
	NSInteger tileNumber = ((UIButton *)sender).tag + (_currentPage * 7);
	if (self.delegate && [self.delegate respondsToSelector:@selector(tileMenu:didDeselectTile:)]) {
		[self.delegate tileMenu:self didDeselectTile:tileNumber];
	}
}

#pragma mark - Displaying and dismissing the menu

- (CGPoint)displayMenuCenteredOnPoint:(CGPoint)centerPt inView:(UIView *)parentView
{
	return [self displayMenuPage:0 centeredOnPoint:centerPt inView:parentView];
}


// As above, with the menu already displaying the specified 'page' of tiles.
- (CGPoint)displayMenuPage:(NSInteger)pageNum centeredOnPoint:(CGPoint)centerPt inView:(UIView *)parentView
{
	if (!parentView) {
		return CGPointZero;
	}
	_parentView = parentView;
	_currentPage = pageNum;
    _tilesArranged = NO;
	
	// Inform delegate.
	if (_delegate && [_delegate respondsToSelector:@selector(tileMenuWillDisplay:)]) {
		[_delegate tileMenuWillDisplay:self];
	}
	
    // Adjust size of view, in case our settings have changed.
	NSInteger bezelSize = (self.tileSide * 3) + (self.tileGap * 2);
    
	// Adjust centerPt if necessary to fit on-screen.
	NSInteger halfBezel = bezelSize / 2;
	CGRect newFrame = CGRectMake(centerPt.x - halfBezel, centerPt.y - halfBezel, bezelSize, bezelSize);
	newFrame = MinimallyOverlapRects(newFrame, parentView.bounds, PARENTVIEW_EDGE_INSET);
	
	// Move bezel view to actual center point.
	_centerPoint = CGPointMake(CGRectGetMidX(newFrame), CGRectGetMidY(newFrame));
    //	self.view.frame = newFrame;
	self.view.frame = CGRectMake((320-_menuWidth)/2, 130, _menuWidth, (_tileSide*2 + _tileTopGap*3+tileMenu_label_height*2+10));//add by Even zheng
	
	// Position tiles.
//	for (UIButton *tileButton in _tileButtons) {
//		tileButton.frame = [self frameForCenteredTile];
//		tileButton.layer.position = _centerPoint;
//		[tileButton.layer removeAllAnimations];
//	}
	
	// Display menu.
	[_parentView addSubview:self.view];
	
	// Add appearance animations.
	NSArray *animations = [self _animationsForAppearing:YES];
	int i = 0;
	for (CAAnimation *animation in animations) {
		[self.view.layer addAnimation:animation forKey:[NSString stringWithFormat:@"%d", i]];
		i++;
	}
	[self switchToPage:pageNum];
	return _centerPoint;
}

- (void)dismissMenu
{
	if ([self isVisible]) {
		
		// Check with delegate.
		BOOL shouldDismiss = YES;
		if (_delegate && [_delegate respondsToSelector:@selector(tileMenuShouldDismiss:)]) {
			shouldDismiss = [_delegate tileMenuShouldDismiss:self];
		}
		
		if (shouldDismiss) {
			// Add disappearance animations.
			NSArray *animations = [self _animationsForAppearing:NO];
			int i = 0;
			for (CAAnimation *animation in animations) {
				[self.view.layer addAnimation:animation forKey:[NSString stringWithFormat:@"%d", i]];
				i++;
			}
			
			// Inform delegate.
			if (_delegate && [_delegate respondsToSelector:@selector(tileMenuWillDismiss:)]) {
				[_delegate tileMenuWillDismiss:self];
			}
		}
	}
}


- (BOOL)isVisible
{
	return (self.view && self.parentView && self.view.superview && ![self.view isHidden]&&_appeared);
}
#pragma mark - Animations
- (NSArray *)_animationsForAppearing:(BOOL)appearing
{
	NSMutableArray *animations = [NSMutableArray arrayWithCapacity:0];
	
	if (appearing) {
		CABasicAnimation *expandAnimation;
		expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
		[expandAnimation setValue:ANIMATION_APPEAR forKey:@"name"];
		[expandAnimation setRemovedOnCompletion:NO];
		[expandAnimation setDuration:ANIMATION_DURATION];
		[expandAnimation setFillMode:kCAFillModeForwards];
		[expandAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
		[expandAnimation setDelegate:self];
		CGFloat factor = 0.2;
		CATransform3D transform = CATransform3DMakeScale(factor, factor, factor);
		expandAnimation.fromValue = [NSValue valueWithCATransform3D:transform];
		expandAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
		
		[animations addObject:expandAnimation];
		
		CABasicAnimation *fadeAnimation;
		fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
		[fadeAnimation setValue:ANIMATION_APPEAR forKey:@"name"];
		[fadeAnimation setRemovedOnCompletion:NO];
		[fadeAnimation setDuration:ANIMATION_DURATION];
		[fadeAnimation setFillMode:kCAFillModeForwards];
		[fadeAnimation setDelegate:self];
		fadeAnimation.fromValue = [NSNumber numberWithFloat:0.0];
		fadeAnimation.toValue = [NSNumber numberWithFloat:1.0];
		
		[animations addObject:fadeAnimation];
		
	} else {
		CABasicAnimation *shrinkAnimation;
		shrinkAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
		[shrinkAnimation setValue:ANIMATION_DISAPPEAR forKey:@"name"];
		[shrinkAnimation setRemovedOnCompletion:NO];
		[shrinkAnimation setDuration:ANIMATION_DURATION];
		[shrinkAnimation setFillMode:kCAFillModeForwards];
		[shrinkAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
		[shrinkAnimation setDelegate:self];
		shrinkAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
		CGFloat factor = 0.6;
		CATransform3D transform = CATransform3DMakeScale(factor, factor, factor);
		shrinkAnimation.toValue = [NSValue valueWithCATransform3D:transform];
		
		[animations addObject:shrinkAnimation];
		
		CABasicAnimation *fadeAnimation;
		fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
		[fadeAnimation setValue:ANIMATION_DISAPPEAR forKey:@"name"];
		[fadeAnimation setRemovedOnCompletion:NO];
		[fadeAnimation setDuration:ANIMATION_DURATION];
		[fadeAnimation setFillMode:kCAFillModeForwards];
		[fadeAnimation setDelegate:self];
		fadeAnimation.fromValue = [NSNumber numberWithFloat:1.0];
		fadeAnimation.toValue = [NSNumber numberWithFloat:0.0];
		
		[animations addObject:fadeAnimation];
	}
	
	return animations;
}

- (void)animateTilesForCurrentPage
{
	// Determine which animation (to or from centre) to perform.
	CGPoint centrePoint = CenterPoint([self frameForCenteredTile]);
	CGPoint tileCentre;
	CABasicAnimation *tileAnimation;
	UIButton *tile;
	CFTimeInterval baseTime = CACurrentMediaTime();
	CFTimeInterval delay =  ANIMATION_DURATION; // allow for menu appearance animation
	CFTimeInterval duration =  ANIMATION_DURATION; // go to centre quicker than going back out
	CFTimeInterval offset = 0.1; // go to centre quicker than going back out
	
	
	// Use delegate methods to configure tiles, showing/hiding as required, if we're at the centre.
	if (!_tilesArranged) {
		NSInteger numTiles = 0;
		if (_delegate && [_delegate respondsToSelector:@selector(numberOfTilesInMenu:)]) {
			numTiles = MAX(0, [_delegate numberOfTilesInMenu:self]);
		}
		
		// Work out number of tiles that are visible
		NSInteger numVisibleTiles = MIN(TILES_PER_PAGE, numTiles - (_currentPage * TILES_PER_PAGE));
		NSInteger firstTileIndex = _currentPage * TILES_PER_PAGE;
		
		// Configure needed tiles, hiding/showing as appropriate.
		NSInteger i = 0;
		NSInteger currentTileIndex;
		UIImage *tileImage;
		BOOL tileEnabled = YES;
		BOOL shouldHide = NO;
		for (TileMenuButton *tileButton in _tileButtons) {//add by
			currentTileIndex = (firstTileIndex + i);
			shouldHide = (i > (numVisibleTiles - 1));
			if (shouldHide) {
				[tileButton.button setImage:nil forState:UIControlStateNormal];
				[tileButton.button setImage:nil forState:UIControlStateHighlighted];
				[tileButton.button setBackgroundImage:nil forState:UIControlStateNormal];
				[tileButton.button setBackgroundImage:nil forState:UIControlStateHighlighted];
				[tileButton.button setAccessibilityLabel:nil];
				[tileButton.button setAccessibilityHint:nil];
				tileButton.alpha = 1.0;
				
				[UIView transitionWithView:tileButton 
								  duration:ANIMATION_DURATION 
								   options:UIViewAnimationOptionTransitionCrossDissolve 
								animations:^{
									tileButton.alpha = 0.0;
								}
								completion:NULL];
				
			} else {
				tileImage = [_delegate imageForTile:currentTileIndex inMenu:self];
				[tileButton.button setImage:tileImage forState:UIControlStateNormal];
				[tileButton.button setImage:tileImage forState:UIControlStateHighlighted];
//				[tileButton.button setBackgroundImage:[self tileBackgroundImageForTile:currentTileIndex highlighted:NO] 
//                                             forState:UIControlStateNormal];
//				[tileButton.button setBackgroundImage:[self tileBackgroundImageForTile:currentTileIndex highlighted:YES] 
//                                             forState:UIControlStateHighlighted];//add by Even zheng 2012
				[tileButton.button setAccessibilityLabel:[_delegate labelForTile:currentTileIndex inMenu:self]];
				[tileButton.button setAccessibilityHint:[_delegate descriptionForTile:currentTileIndex inMenu:self]];
				if (_delegate && [_delegate respondsToSelector:@selector(isTileEnabled:inMenu:)]) {
					tileEnabled = [_delegate isTileEnabled:currentTileIndex inMenu:self];
				}
				tileButton.alpha = ((tileEnabled) ? 1.0 :DISABLED_TILE_OPACITY);

			}
			
			i++;
		}
	}
	
	NSInteger j;
	NSInteger numAnimatedTiles = _tileButtons.count;
	for (int i = 0; i < numAnimatedTiles; i++) {
		j = [[_animationOrder objectAtIndex:i] integerValue];
		if (j >= [_tileButtons count]) {
			break;
		}
		tile = [_tileButtons objectAtIndex:j];
		tileAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
		tileAnimation.beginTime = baseTime ;//+ delay + ((CGFloat)i * offset);// add by Even zheng
		[tileAnimation setValue:ANIMATION_TILES forKey:@"name"];
		[tileAnimation setRemovedOnCompletion:NO];
		[tileAnimation setDuration:duration];
		[tileAnimation setFillMode:kCAFillModeForwards];
		[tileAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
		tileCentre = CenterPoint([self frameForTileAtIndex:j]);//add by Even zheng
		
//		CALayer *presentationLayer = (CALayer *)[((TileMenuButton*)tile).button.layer presentationLayer];
//		CGPoint currentPosition = presentationLayer.position;
		
			// We're going from the centre out towards the final position.
        if (!_tilesArranged) {
			// We're going from the centre out towards the final position.
			tileAnimation.fromValue = [NSValue valueWithCGPoint:centrePoint];
			tileAnimation.toValue = [NSValue valueWithCGPoint:tileCentre];
		} else {
			// We're going from the initial position in towards the centre.
			tileAnimation.fromValue = [NSValue valueWithCGPoint:tileCentre];
			tileAnimation.toValue = [NSValue valueWithCGPoint:centrePoint];
		}
        
		[tileAnimation setDelegate:self];
		[tileAnimation setValue:tile.layer forKey:ANIMATION_TILE_LAYER];
		[tileAnimation setValue:[NSNumber numberWithInteger:j] forKey:ANIMATION_TILE_INDEX];
		[tile.layer addAnimation:tileAnimation forKey:ANIMATION_TILES];
	}
	
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)finished
{
	BOOL continueAnimation = NO;
	BOOL cleanUp = NO;
	CALayer *layer = [animation valueForKey:ANIMATION_TILE_LAYER];
	NSString *path = nil;
	NSValue *fromValue = nil;
	
	if (!layer) {
		layer = self.view.layer;
	}
	
	if (animation) {
		NSString *name = [animation valueForKey:@"name"];
		if ([name isEqualToString:ANIMATION_DISAPPEAR]) {
			cleanUp = YES;
		} else if ([name isEqualToString:ANIMATION_APPEAR]) {
			
			// Inform delegate.
			if (!_appeared && _delegate && [_delegate respondsToSelector:@selector(tileMenuDidDisplay:)]) {
				[_delegate tileMenuDidDisplay:self];
			}
			
			_appeared = YES;
		}
		
		if ([name isEqualToString:ANIMATION_TILES]) {
			layer = [animation valueForKey:ANIMATION_TILE_LAYER];
//			NSInteger lastAnimatedTileIndex = [[_animationOrder lastObject] integerValue];
		}
		
		// Commit animation's final state and remove it.
		if ([animation isKindOfClass:[CABasicAnimation class]]) {
			path = [(CABasicAnimation *)animation keyPath];
			if (cleanUp) {
				fromValue = [(CABasicAnimation *)animation fromValue];
			} else {
				[layer setValue:[(CABasicAnimation *)animation toValue] forKeyPath:path];
			}
			[layer removeAnimationForKey:path];
		}
	}
	
	if (cleanUp) {
		// Remove from spawning view.
		[self.view removeFromSuperview];
		UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, nil);
		
		// Inform delegate.
		if (_appeared && _delegate && [_delegate respondsToSelector:@selector(tileMenuDidDismiss:)]) {
			[_delegate tileMenuDidDismiss:self];
		}
		
		_appeared = NO;
		
		if (path && fromValue) {
			[layer setValue:fromValue forKeyPath:path];
		}
//        if (_tileButtons && [_tileButtons count] > 0) {
//            for (UIButton *tileButton in _tileButtons) {
//                tileButton.frame = [self frameForCenteredTile];
//            }
//        }
		
	}
	
	if (continueAnimation) {
		[self animateTilesForCurrentPage];
	}
}

- (void)setAllTilesInteractionEnabled:(BOOL)enabled
{
	NSInteger tileIndex = _currentPage * TILES_PER_PAGE;
	BOOL askDelegate = enabled && (_delegate && [_delegate respondsToSelector:@selector(isTileEnabled:inMenu:)]);
	
	for (UIButton *tileButton in _tileButtons) {
		if (askDelegate) {
			tileButton.userInteractionEnabled = [_delegate isTileEnabled:tileIndex inMenu:self];
		} else {
			tileButton.userInteractionEnabled = enabled;
		}
		
		tileIndex++;
	}
}
#pragma mark - Managing pages of tiles


- (void)switchToPage:(NSInteger)pageNum
{
	pageNum = [self nextPageNumber:pageNum - 1];
	_currentPage = pageNum;
	
	// Inform delegate.
	if (_delegate && [_delegate respondsToSelector:@selector(tileMenu:willSwitchToPage:)]) {
		[_delegate tileMenu:self willSwitchToPage:_currentPage];
	}
	
	
	// Begin an appropriate tile-animation.
	[self setAllTilesInteractionEnabled:YES];
//    _animatingTiles
	if (NO) {
		for (TileMenuButton *tileButton in _tileButtons) {
			[tileButton.layer removeAllAnimations];
			CALayer *presentationLayer = (CALayer *)[tileButton.layer presentationLayer];
			tileButton.frame = presentationLayer.frame;
		}
	}
//	_animatingTiles = YES;
	[self animateTilesForCurrentPage];
}

- (NSInteger)nextPageNumber:(NSInteger)currentPageNumber
{
	NSInteger nextPageNumber = currentPageNumber + 1;
	
	// Constrain nextPageNumber to feasible values.
	NSInteger totalTiles = [_delegate numberOfTilesInMenu:self];
	NSInteger lastPage = ceil((CGFloat)totalTiles / (CGFloat)TILES_PER_PAGE) - 1; // zero-based
	if (nextPageNumber < 0) {
		nextPageNumber = 0;
	} else if (nextPageNumber > lastPage) {
		nextPageNumber = 0;
	}
	
	return nextPageNumber;
}
@end
