//
//  MMSierraRolloverButtonCell.m
//  MMTabBarView
//
//  Created by Isaiah Carew on 4/19/17.
//

#import "MMSierraRolloverButtonCell.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MMSierraRolloverButtonCell

- (void)drawImage:(NSImage *)image withFrame:(NSRect)frame inView:(NSView *)controlView {
    [[NSColor redColor] set];
    NSFrameRect(frame);

//    if (_mouseHovered && ![self isHighlighted]) {
//        if (_rolloverImage) {
//            [super drawImage:_rolloverImage withFrame:frame inView:controlView];
//            return;
//        }
//    }
//
//    [super drawImage:image withFrame:frame inView:controlView];

}

- (void)drawBezelWithFrame:(NSRect)frame inView:(NSView *)controlView {
    [[NSColor blueColor] set];
    NSFrameRect(frame);

}

@end

NS_ASSUME_NONNULL_END
