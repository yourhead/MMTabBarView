//
//  MMSierraOverflowPopUpButton.m
//  MMTabBarView
//
//  Created by Isaiah Carew on 4/19/17.
//

#import "MMSierraRolloverButton.h"
#import "MMSierraRolloverButtonCell.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MMSierraRolloverButton

+ (nullable Class)cellClass {
    return [MMSierraRolloverButtonCell class];
}


- (instancetype)initWithFrame:(NSRect)frameRect {

    self = [super initWithFrame:frameRect];
    if (self) {
        self.bordered = YES;
    }

    return self;
}


//[_addTabButton setImage:_staticAquaTabNewImage()];
//[_addTabButton setAlternateImage:_staticAquaTabNewPressedImage()];
//[_addTabButton setRolloverImage:_staticAquaTabNewRolloverImage()];
//
//[_addTabButton setTitle:@""];
//[_addTabButton setImagePosition:NSImageOnly];
//[_addTabButton setRolloverButtonType:MMRolloverActionButton];
//[_addTabButton setBordered:NO];
//[_addTabButton setBezelStyle:NSShadowlessSquareBezelStyle];

@end

NS_ASSUME_NONNULL_END
