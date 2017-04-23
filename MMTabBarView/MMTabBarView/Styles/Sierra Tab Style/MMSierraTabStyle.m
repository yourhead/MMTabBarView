//
//  MMSierraTabStyle.m
//  --------------------
//
//  Based on MMYosemiteTabStyle.m by Ajin Man Tuladhar
//  Created by Ajin Isaiah Carew on 04/16/2017
//  Copyright 2017 Isaiah Carew. All rights reserved.
//

#import "MMSierraTabStyle.h"
#import "MMAttachedTabBarButton.h"
#import "MMTabBarView.h"
#import "NSView+MMTabBarViewExtensions.h"
#import "NSBezierPath+MMTabBarViewExtensions.h"
#import "MMOverflowPopUpButton.h"
#import "MMTabBarView.Private.h"
#import "MMSierraRolloverButton.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MMSierraTabStyle

StaticImage(SierraTabClose_Front)
StaticImage(SierraTabClose_Front_Pressed)
StaticImage(SierraTabClose_Front_Rollover)
StaticImageWithFilename(SierraTabCloseDirty_Front, AquaTabCloseDirty_Front)
StaticImageWithFilename(SierraTabCloseDirty_Front_Pressed, AquaTabCloseDirty_Front_Pressed)
StaticImageWithFilename(SierraTabCloseDirty_Front_Rollover, AquaTabCloseDirty_Front_Rollover)
StaticImage(SierraTabNew)
StaticImage(SierraTabNewPressed)

+ (NSString *)name {
    return @"Sierra";
}

- (NSString *)name {
	return [[self class] name];
}

#pragma mark -
#pragma mark Creation/Destruction

- (id) init {
	if ((self = [super init])) {
		_leftMarginForTabBarView = 0.f;
        _hasBaseline = YES;
        
        _selectedTabColor = [NSColor colorWithDeviceWhite:0.955 alpha:1.000];
        _unselectedTabColor = [NSColor colorWithDeviceWhite:0.875 alpha:1.000];
        
        _needsResizeTabsToFitTotalWidth = YES;
	}
    
	return self;
}

#pragma mark -
#pragma mark Tab View Specific

- (NSSize)intrinsicContentSizeOfTabBarView:(MMTabBarView *)tabBarView
{
    return NSMakeSize(-1/* NSViewNoInstrinsicMetric */, 24);
}

- (CGFloat)leftMarginForTabBarView:(MMTabBarView *)tabBarView {
    return 0.0f;
}

- (CGFloat)rightMarginForTabBarView:(MMTabBarView *)tabBarView {
    return 0.0f;
}

- (CGFloat)topMarginForTabBarView:(MMTabBarView *)tabBarView {
    return 0.0f;
}

- (CGFloat)heightOfTabBarButtonsForTabBarView:(MMTabBarView *)tabBarView {
    return 24.0f;
}

- (NSSize)overflowButtonSizeForTabBarView:(MMTabBarView *)tabBarView {
    return NSMakeSize(14, [self heightOfTabBarButtonsForTabBarView:tabBarView]);
}

- (NSRect)addTabButtonRectForTabBarView:(MMTabBarView *)tabBarView {
    NSSize tabBarSize = tabBarView.bounds.size;
    NSSize buttonSize = [self addTabButtonSizeForTabBarView:tabBarView];
    CGFloat x = tabBarSize.width - buttonSize.width;
    return NSMakeRect( x, 0, buttonSize.width, buttonSize.height);
    //return NSMakeRect( tabBarSize.width - buttonSize.width , 0, buttonSize.width, buttonSize.height);
}

- (NSSize)addTabButtonSizeForTabBarView:(MMTabBarView *)tabBarView {
    return NSMakeSize(24, [self heightOfTabBarButtonsForTabBarView:tabBarView]);
}

- (CGFloat)addTabButtonPaddingForTabBarView:(MMTabBarView *)tabBarView {
    return 0;
}

- (BOOL)supportsOrientation:(MMTabBarOrientation)orientation forTabBarView:(MMTabBarView *)tabBarView {
    return NO;
}

#pragma mark -
#pragma mark Drag Support

- (NSRect)draggingRectForTabButton:(MMAttachedTabBarButton *)aButton ofTabBarView:(MMTabBarView *)tabBarView {
	NSRect dragRect = [aButton stackingFrame];
	dragRect.size.width++;
	return dragRect;
    
}

#pragma mark -
#pragma mark Add Tab Button

- (MMRolloverButton *)rolloverButtonWithFrame:(NSRect)frame ofTabBarView:(MMTabBarView *)tabBarView {
    // return our rollover subclass that draws Sierra gradients
    return [[MMSierraRolloverButton alloc] initWithFrame:frame];
}

- (void)updateAddButton:(MMRolloverButton *)aButton ofTabBarView:(MMTabBarView *)tabBarView {

    [aButton setImage:_staticSierraTabNewImage()];
    [aButton setAlternateImage:_staticSierraTabNewPressedImage()];
    [aButton setRolloverImage:_staticSierraTabNewImage()];

    aButton.bordered = YES;
}

#pragma mark -
#pragma mark Providing Images

- (NSImage *)closeButtonImageOfType:(MMCloseButtonImageType)type forTabCell:(MMTabBarButtonCell *)cell
{
    switch (type) {
        case MMCloseButtonImageTypeStandard:
            return _staticSierraTabClose_FrontImage();
        case MMCloseButtonImageTypeRollover:
            return _staticSierraTabClose_Front_RolloverImage();
        case MMCloseButtonImageTypePressed:
            return _staticSierraTabClose_Front_PressedImage();
            
        case MMCloseButtonImageTypeDirty:
            return _staticSierraTabCloseDirty_FrontImage();
        case MMCloseButtonImageTypeDirtyRollover:
            return _staticSierraTabCloseDirty_Front_RolloverImage();
        case MMCloseButtonImageTypeDirtyPressed:
            return _staticSierraTabCloseDirty_Front_PressedImage();
            
        default:
            break;
    }
    
}



#pragma mark -
#pragma mark Close Button Drawing

- (void)drawTabBarCell:(MMTabBarButtonCell *)cell withFrame:(NSRect)frame inView:(NSView *)controlView {

}

- (void)drawBezelOfTabCell:(MMTabBarButtonCell *)cell withFrame:(NSRect)frame inView:(NSView *)controlView {

}

- (void)drawInteriorOfTabCell:(MMTabBarButtonCell *)cell withFrame:(NSRect)frame inView:(NSView *)controlView {

}



#pragma mark -
#pragma mark Drawing

- (void)drawBezelOfTabBarView:(MMTabBarView *)tabBarView inRect:(NSRect)rect {
    NSRect topRect = [self topBorderRectWithFrame:rect];
    NSRect bottomRect = [self bottomBorderRectWithFrame:rect];

    if ([tabBarView isWindowActive]) {
        [[MMSierraTabStyle idleFillGradient] drawInRect:rect angle:90];
        [[MMSierraTabStyle unselectedTopBorderGradient] drawInRect:topRect angle:90];
        [[MMSierraTabStyle bottomBorderGradient] drawInRect:bottomRect angle:90];
    } else {
        [[MMSierraTabStyle inactiveIdleFillColor] set];
        NSFrameRect(rect);
        [[MMSierraTabStyle inactiveBorderColor] set];
        NSFrameRect(topRect);
        [[MMSierraTabStyle inactiveBottomBorderColor] set];
        NSFrameRect(bottomRect);
    }
}


-(void)drawBezelOfTabCell:(MMTabBarButtonCell *)cell withFrame:(NSRect)frame inView:(NSView *)controlView {
    // when a tab is sliding it needs to draw on top of all other tabs
    // its style is the selected style, but with left and right edges
    MMAttachedTabBarButton *button = (MMAttachedTabBarButton *)controlView;
    if (button.isInDraggedSlide) {

        [[MMSierraTabStyle selectedFillGradient] drawInRect:frame angle:90];

        [[MMSierraTabStyle selectedTopBorderGradient] drawInRect:[self topBorderRectWithFrame:frame] angle:90];
        [[MMSierraTabStyle bottomBorderGradient] drawInRect:[self bottomBorderRectWithFrame:frame] angle:90];

        [[MMSierraTabStyle edgeBorderGradient] drawInRect:[self leftRectWithFrame:frame] angle:90];
        [[MMSierraTabStyle edgeBorderGradient] drawInRect:[self rightRectWithFrame:frame] angle:90];
    }
}

-(void)drawBezelOfOverflowButton:(MMOverflowPopUpButton *)overflowButton ofTabBarView:(MMTabBarView *)tabBarView inRect:(NSRect)rect {

//    MMAttachedTabBarButton *lastAttachedButton = [tabBarView lastAttachedButton];
//    if ([lastAttachedButton isSliding])
//        return;
//    
//    NSWindow *window = [tabBarView window];
//    NSToolbar *toolbar = [window toolbar];
//    
//    NSRect frame = [overflowButton frame];
//    
//    if (toolbar && [toolbar isVisible]) {
//        
//        NSRect aRect = NSMakeRect(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
//        aRect.size.width += 5.0;
////        aRect.origin.y += 1;
////        aRect.size.height -= 2;
//        
//        [self _drawCardBezelInRect:aRect withCapMask:MMBezierShapeRightCap|MMBezierShapeFlippedVertically usingStatesOfAttachedButton:lastAttachedButton ofTabBarView:tabBarView];
//        
//    } else {
//        NSRect aRect = NSMakeRect(frame.origin.x, frame.origin.y+0.5, frame.size.width-0.5f, frame.size.height-1.0);
//        aRect.size.width += 5.0;
//        
//        [self _drawBoxBezelInRect:aRect withCapMask:MMBezierShapeRightCap|MMBezierShapeFlippedVertically usingStatesOfAttachedButton:lastAttachedButton ofTabBarView:tabBarView];
//        
//        if ([tabBarView showAddTabButton]) {
//            
//            NSColor *lineColor = [NSColor colorWithCalibratedWhite:0.576 alpha:1.0];
//            [lineColor set];
//            [NSBezierPath strokeLineFromPoint:NSMakePoint(NSMaxX(aRect)+.5, NSMinY(aRect)) toPoint:NSMakePoint(NSMaxX(aRect)+0.5, NSMaxY(aRect))];
//
//            [[[NSColor whiteColor] colorWithAlphaComponent:0.5] set];
//            [NSBezierPath strokeLineFromPoint:NSMakePoint(NSMaxX(aRect)+1.5f, NSMinY(aRect)+1.0) toPoint:NSMakePoint(NSMaxX(aRect)+1.5f, NSMaxY(aRect)-1.0)];
//        }        
//    }
}

- (void)drawLeftBezelOfButton:(MMAttachedTabBarButton *)button atIndex:(NSUInteger)index inButtons:(NSArray *)buttons indexOfSelectedButton:(NSUInteger)selIndex tabBarView:(MMTabBarView *)tabBarView {
    // leftmost tab is flush against the view
    if (index < 1) return;

    // the selected tab has no edges
    if (index == selIndex) return;

    // tabs right of the selected tab have no left edge
    // except for the tab immediately to the right of the selection
    if (index - 1 > selIndex) return;

    NSRect rect = [self leftRectWithFrame:button.frame];
    if ([tabBarView isWindowActive]) {
        [[MMSierraTabStyle edgeBorderGradient] drawInRect:rect angle:90];
    } else {
        [[MMSierraTabStyle inactiveBorderColor] set];
        NSFrameRect(rect);
    }
}

- (void)drawRightBezelOfButton:(MMAttachedTabBarButton *)button atIndex:(NSUInteger)index inButtons:(NSArray *)buttons indexOfSelectedButton:(NSUInteger)selIndex tabBarView:(MMTabBarView *)tabBarView {
    // rightmost tab is flush against the add-tab button
    if (index == buttons.count - 1) return;

    // the selected tab has no edges
    if (index == selIndex) return;

    // tabs left of the selected tab have no right edge
    // except for the tab immediately to the left of the selection
    if (index + 1 < selIndex) return;

    NSRect rect = [self rightRectWithFrame:button.frame];
    if ([tabBarView isWindowActive]) {
        [[MMSierraTabStyle edgeBorderGradient] drawInRect:rect angle:90];
    } else {
        [[MMSierraTabStyle inactiveBorderColor] set];
        NSFrameRect(rect);
    }
}

- (void)drawTopBezelOfButton:(MMAttachedTabBarButton *)button atIndex:(NSUInteger)index inButtons:(NSArray *)buttons indexOfSelectedButton:(NSUInteger)selIndex tabBarView:(MMTabBarView *)tabBarView {
    NSRect rect = [self topBorderRectWithFrame:button.frame];
    if ([tabBarView isWindowActive]) {
        NSGradient *gradient = nil;
        if (index == selIndex) {
            gradient = [MMSierraTabStyle selectedTopBorderGradient];
        } else {
            gradient = [MMSierraTabStyle unselectedTopBorderGradient];
        }
        [gradient drawInRect:rect angle:90];
    } else {
        [[MMSierraTabStyle inactiveBorderColor] set];
        NSFrameRect(rect);
    }
}

- (void)drawBottomBezelOfButton:(MMAttachedTabBarButton *)button atIndex:(NSUInteger)index inButtons:(NSArray *)buttons indexOfSelectedButton:(NSUInteger)selIndex tabBarView:(MMTabBarView *)tabBarView {
    NSRect rect = [self bottomBorderRectWithFrame:button.frame];
    if ([tabBarView isWindowActive]) {
        [[MMSierraTabStyle bottomBorderGradient] drawInRect:rect angle:90];
    } else {
        [[MMSierraTabStyle inactiveBottomBorderColor] set];
        NSFrameRect(rect);
    }
}

- (void)drawFillOfButton:(MMAttachedTabBarButton *)button atIndex:(NSUInteger)index inButtons:(NSArray *)buttons indexOfSelectedButton:(NSUInteger)selIndex tabBarView:(MMTabBarView *)tabBarView {
    NSRect rect = [self fillRectWithFrame:button.frame];
    if ([tabBarView isWindowActive]) {
        NSGradient *gradient = nil;
        if (index == selIndex) {
            gradient = [MMSierraTabStyle selectedFillGradient];
        } else if (button.mouseHovered) {
            gradient = [MMSierraTabStyle hoverFillGradient];
        } else {
            gradient = [MMSierraTabStyle idleFillGradient];
        }
        [gradient drawInRect:rect angle:90];
    } else {
        NSColor *color = nil;
        if (index == selIndex) {
            color = [MMSierraTabStyle inactiveSelectedFillColor];
        } else if (button.mouseHovered) {
            color = [MMSierraTabStyle inactiveHoverFillColor];
        } else {
            color = [MMSierraTabStyle inactiveIdleFillColor];
        }
        [color set];
        NSFrameRect(rect);
    }
}

- (void)drawBezelOfButton:(MMAttachedTabBarButton *)button atIndex:(NSUInteger)index inButtons:(NSArray *)buttons indexOfSelectedButton:(NSUInteger)selIndex tabBarView:(MMTabBarView *)tabBarView inRect:(NSRect)rect {
    [self drawFillOfButton:button atIndex:index inButtons:buttons indexOfSelectedButton:selIndex tabBarView:tabBarView];
    [self drawLeftBezelOfButton:button atIndex:index inButtons:buttons indexOfSelectedButton:selIndex tabBarView:tabBarView];
    [self drawRightBezelOfButton:button atIndex:index inButtons:buttons indexOfSelectedButton:selIndex tabBarView:tabBarView];
    [self drawTopBezelOfButton:button atIndex:index inButtons:buttons indexOfSelectedButton:selIndex tabBarView:tabBarView];
    [self drawBottomBezelOfButton:button atIndex:index inButtons:buttons indexOfSelectedButton:selIndex tabBarView:tabBarView];
}


#pragma mark - component frames

- (NSRect)bottomBorderRectWithFrame:(NSRect)frame {
    return NSMakeRect(frame.origin.x, frame.origin.y + frame.size.height - 1.0f, frame.size.width, 1.0f);
}

- (NSRect)topBorderRectWithFrame:(NSRect)frame {
    return NSMakeRect(frame.origin.x, frame.origin.y, frame.size.width, 1.0f);
}

- (NSRect)leftRectWithFrame:(NSRect)frame {
    return NSMakeRect(frame.origin.x, frame.origin.y, 1.0f, frame.size.height - 1.0f);
}

- (NSRect)rightRectWithFrame:(NSRect)frame {
    return NSMakeRect(frame.origin.x + frame.size.width - 1, frame.origin.y + 1, 1.0f, frame.size.height - 2.0f);
}

- (NSRect)fillRectWithFrame:(NSRect)frame {
    return NSMakeRect(frame.origin.x, frame.origin.y + 1, frame.size.width, frame.size.height - 2.0f);
}


#pragma mark - fill gradients

+ (NSGradient *)selectedFillGradient {
    static NSGradient *gradient = nil;
    if (!gradient) {
        gradient = [[NSGradient alloc] initWithColors:
                    @[
                      [NSColor colorWithCalibratedWhite:0.808 alpha:1.0],
                      [NSColor colorWithCalibratedWhite:0.792 alpha:1.0]
                      ]];
    }
    return gradient;
}

+ (NSGradient *)idleFillGradient {
    static NSGradient *gradient = nil;
    if (!gradient) {
        gradient = [[NSGradient alloc] initWithColors:
                    @[
                      [NSColor colorWithCalibratedWhite:0.698 alpha:1.0],
                      [NSColor colorWithCalibratedWhite:0.682 alpha:1.0]
                      ]];
    }
    return gradient;
}

+ (NSGradient *)hoverFillGradient {
    static NSGradient *gradient = nil;
    if (!gradient) {
        gradient = [[NSGradient alloc] initWithColors:
                    @[
                      [NSColor colorWithCalibratedWhite:0.663 alpha:1.0],
                      [NSColor colorWithCalibratedWhite:0.647 alpha:1.0]
                      ]];
    }
    return gradient;
}

+ (NSGradient *)mouseDownFillGradient {
    static NSGradient *gradient = nil;
    if (!gradient) {
        gradient = [[NSGradient alloc] initWithColors:
                    @[
                      [NSColor colorWithCalibratedWhite:0.608 alpha:1.0],
                      [NSColor colorWithCalibratedWhite:0.557 alpha:1.0]
                      ]];
    }
    return gradient;
}

#pragma mark - top border gradients

+ (NSGradient *)selectedTopBorderGradient {
    static NSGradient *gradient = nil;
    if (!gradient) {
        gradient = [[NSGradient alloc] initWithColors:
                    @[
                      [NSColor colorWithCalibratedWhite:0.690 alpha:1.0],
                      [NSColor colorWithCalibratedWhite:0.686 alpha:1.0]
                      ]];
    }
    return gradient;
}

+ (NSGradient *)unselectedTopBorderGradient {
    static NSGradient *gradient = nil;
    if (!gradient) {
        gradient = [[NSGradient alloc] initWithColors:
                    @[
                      [NSColor colorWithCalibratedWhite:0.592 alpha:1.0],
                      [NSColor colorWithCalibratedWhite:0.588 alpha:1.0]
                      ]];
    }
    return gradient;
}

#pragma mark - left/right-border gradients

+ (NSGradient *)edgeBorderGradient {
    static NSGradient *gradient = nil;
    if (!gradient) {
        gradient = [[NSGradient alloc] initWithColors:
                    @[
                      [NSColor colorWithCalibratedWhite:0.588 alpha:1.0],
                      [NSColor colorWithCalibratedWhite:0.573 alpha:1.0]
                      ]];
    }
    return gradient;
}

#pragma mark - left/right-border gradients

+ (NSGradient *)bottomBorderGradient {
    static NSGradient *gradient = nil;
    if (!gradient) {
        gradient = [[NSGradient alloc] initWithColors:
                    @[
                      [NSColor colorWithCalibratedWhite:0.592 alpha:1.0],
                      [NSColor colorWithCalibratedWhite:0.588 alpha:1.0]
                      ]];
    }
    return gradient;
}

#pragma mark - inactive windows

+ (NSColor *)inactiveSelectedFillColor {
    static NSColor *color = nil;
    if (!color) {
        color = [NSColor colorWithCalibratedWhite:0.957 alpha:1.0];
    }
    return color;
}

+ (NSColor *)inactiveIdleFillColor {
    static NSColor *color = nil;
    if (!color) {
        color = [NSColor colorWithCalibratedWhite:0.906 alpha:1.0];
    }
    return color;
}

+ (NSColor *)inactiveHoverFillColor {
    static NSColor *color = nil;
    if (!color) {
        color = [NSColor colorWithCalibratedWhite:0.871 alpha:1.0];
    }
    return color;
}

+ (NSColor *)inactiveBorderColor {
    static NSColor *color = nil;
    if (!color) {
        color = [NSColor colorWithCalibratedWhite:0.827 alpha:1.0];
    }
    return color;
}

+ (NSColor *)inactiveBottomBorderColor {
    static NSColor *color = nil;
    if (!color) {
        color = [NSColor colorWithCalibratedWhite:0.784 alpha:1.0];
    }
    return color;
}




@end

NS_ASSUME_NONNULL_END
