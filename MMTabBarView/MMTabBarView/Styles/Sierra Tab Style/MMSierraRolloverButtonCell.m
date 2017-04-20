//
//  MMSierraRolloverButtonCell.m
//  MMTabBarView
//
//  Created by Isaiah Carew on 4/19/17.
//

#import "MMSierraRolloverButtonCell.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MMSierraRolloverButtonCell

- (void)drawBezelWithFrame:(NSRect)frame inView:(NSView *)controlView {

    NSRect topRect = NSMakeRect(frame.origin.x, 0, frame.size.width, 1.0f);
    NSRect leftRect = NSMakeRect(frame.origin.x, 0, 1.0f, frame.size.height - 1.0f);
    NSRect fillRect = NSMakeRect(frame.origin.x + 1, frame.origin.y + 1, frame.size.width - 1.0f, frame.size.height - 2.0f);

    NSGradient *borderGradient = nil;
    NSGradient *fillGradient = nil;
    NSColor *topColor;

    if (controlView.window.isKeyWindow || controlView.window.isMainWindow) {
        if (self.isHighlighted) {
            borderGradient = [MMSierraRolloverButtonCell mouseDownBorderGradient];
            fillGradient = [MMSierraRolloverButtonCell mouseDownFillGradient];
            topColor = [MMSierraRolloverButtonCell mouseDownTopColor];
        } else if (self.mouseHovered) {
            borderGradient = [MMSierraRolloverButtonCell hoverBorderGradient];
            fillGradient = [MMSierraRolloverButtonCell hoverFillGradient];
            topColor = [MMSierraRolloverButtonCell hoverTopColor];
        } else {
            borderGradient = [MMSierraRolloverButtonCell idleBorderGradient];
            fillGradient = [MMSierraRolloverButtonCell idleFillGradient];
            topColor = [MMSierraRolloverButtonCell idleTopColor];
        }
    } else {
        borderGradient = [MMSierraRolloverButtonCell inactiveBorderGradient];
        fillGradient = (self.mouseHovered) ? [MMSierraRolloverButtonCell inactiveHoverFillGradient] : [MMSierraRolloverButtonCell inactiveIdleFillGradient];
        topColor = [MMSierraRolloverButtonCell inactiveTopColor];
    }

    [fillGradient drawInRect:fillRect angle:90.0f];
    [borderGradient drawInRect:leftRect angle:90.0f];

    [topColor set];
    NSFrameRect(topRect);

}

- (void)drawTopWithFrame:(NSRect)frame inView:(NSView *)controlView {
}

#pragma mark - fill gradients

// these are measured values taken from Safari as it has the most consistent tab bar UI
// all gradients roughly gray, but all have a slightly -green cast

+ (NSGradient *)idleFillGradient {
    static NSGradient *gradient = nil;
    if (!gradient) {
        gradient = [[NSGradient alloc] initWithColors:
                    @[
                      [NSColor colorWithCalibratedRed:0.729f green:0.722f blue:0.729f alpha:1.0f],
                      [NSColor colorWithCalibratedRed:0.710f green:0.702f blue:0.710f alpha:1.0f]
                      ]];
    }
    return gradient;
}

+ (NSGradient *)hoverFillGradient {
    static NSGradient *gradient = nil;
    if (!gradient) {
        gradient = [[NSGradient alloc] initWithColors:
                    @[
                      [NSColor colorWithCalibratedRed:0.706f green:0.694f blue:0.706f alpha:1.0f],
                      [NSColor colorWithCalibratedRed:0.671f green:0.667f blue:0.671f alpha:1.0f]
                      ]];
    }
    return gradient;
}

+ (NSGradient *)mouseDownFillGradient {
    static NSGradient *gradient = nil;
    if (!gradient) {
        gradient = [[NSGradient alloc] initWithColors:
                    @[
                      [NSColor colorWithCalibratedRed:0.651f green:0.643f blue:0.651f alpha:1.0f],
                      [NSColor colorWithCalibratedRed:0.600f green:0.596f blue:0.600f alpha:1.0f]
                      ]];
    }
    return gradient;
}

+ (NSGradient *)inactiveIdleFillGradient {
    static NSGradient *gradient = nil;
    if (!gradient) {
        gradient = [[NSGradient alloc] initWithColors:
                    @[
                      [NSColor colorWithCalibratedRed:0.925f green:0.925f blue:0.925f alpha:1.0f],
                      [NSColor colorWithCalibratedRed:0.925f green:0.925f blue:0.925f alpha:1.0f]
                      ]];
    }
    return gradient;
}

+ (NSGradient *)inactiveHoverFillGradient {
    static NSGradient *gradient = nil;
    if (!gradient) {
        gradient = [[NSGradient alloc] initWithColors:
                    @[
                      [NSColor colorWithCalibratedRed:0.886f green:0.886f blue:0.886f alpha:1.0f],
                      [NSColor colorWithCalibratedRed:0.886f green:0.886f blue:0.886f alpha:1.0f]
                      ]];
    }
    return gradient;
}

#pragma mark - top border colors

+ (NSColor *)idleTopColor {
    static NSColor *color = nil;
    if (!color) {
        color = [NSColor colorWithCalibratedRed:0.624 green:0.616 blue:0.624 alpha:1.0];
    }
    return color;
}

+ (NSColor *)hoverTopColor {
    static NSColor *color = nil;
    if (!color) {
        color = [NSColor colorWithCalibratedRed:0.533 green:0.529 blue:0.533 alpha:1.0];
    }
    return color;
}

+ (NSColor *)mouseDownTopColor {
    static NSColor *color = nil;
    if (!color) {
        color = [NSColor colorWithCalibratedRed:0.510 green:0.506 blue:0.510 alpha:1.0];
    }
    return color;
}

+ (NSColor *)inactiveTopColor {
    static NSColor *color = nil;
    if (!color) {
        color = [NSColor colorWithCalibratedRed:0.824 green:0.824 blue:0.824 alpha:1.0];
    }
    return color;
}


#pragma mark - left-border gradients

+ (NSGradient *)idleBorderGradient {
    static NSGradient *gradient = nil;
    if (!gradient) {
        gradient = [[NSGradient alloc] initWithColors:
                    @[
                      [NSColor colorWithCalibratedRed:0.620f green:0.612f blue:0.620f alpha:1.0f],
                      [NSColor colorWithCalibratedRed:0.596f green:0.592f blue:0.596f alpha:1.0f]
                      ]];
    }
    return gradient;
}

+ (NSGradient *)hoverBorderGradient {
    static NSGradient *gradient = nil;
    if (!gradient) {
        gradient = [[NSGradient alloc] initWithColors:
                    @[
                      [NSColor colorWithCalibratedRed:0.565f green:0.593f blue:0.565f alpha:1.0f],
                      [NSColor colorWithCalibratedRed:0.529f green:0.522f blue:0.529f alpha:1.0f]
                      ]];
    }
    return gradient;
}

+ (NSGradient *)mouseDownBorderGradient {
    static NSGradient *gradient = nil;
    if (!gradient) {
        gradient = [[NSGradient alloc] initWithColors:
                    @[
                      [NSColor colorWithCalibratedRed:0.533f green:0.525f blue:0.533f alpha:1.0f],
                      [NSColor colorWithCalibratedRed:0.486f green:0.482f blue:0.486f alpha:1.0f]
                      ]];
    }
    return gradient;
}

+ (NSGradient *)inactiveBorderGradient {
    static NSGradient *gradient = nil;
    if (!gradient) {
        gradient = [[NSGradient alloc] initWithColors:
                    @[
                      [NSColor colorWithCalibratedRed:0.824f green:0.824f blue:0.824f alpha:1.0f],
                      [NSColor colorWithCalibratedRed:0.824f green:0.824f blue:0.824f alpha:1.0f]
                      ]];
    }
    return gradient;
}

@end

NS_ASSUME_NONNULL_END
