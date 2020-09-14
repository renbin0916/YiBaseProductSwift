//
//  UIView+YCorner.h
//  YiBaseProductSwift
//
//  Created by zero_rb on 2020/9/14.
//  Copyright © 2020 任斌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, YCornerType) {
    YCornerTypeAll = 1,
    YCornerTypeLeft,
    YCornerTypeRight,
    YCornerTypeTop,
    YCornerTypeBottom,
    YCornerTypeTopLeft,
    YCornerTypeTopRight,
    YCornerTypeBottomLeft,
    YCornerTypeBottomRight,
    YCornerTypeExceptTopLeft,
    YCornerTypeExceptTopRight,
    YCornerTypeExceptBottomLeft,
    YCornerTypeExceptBottomRight
};

/**
 add corner for UIView, but never use it for view which inherit UIScrollView
 */
@interface UIView (YCorner)

@property (nonatomic, strong) UIColor *y_boardColor;
@property (nonatomic, assign) CGFloat y_boardWith;
@property (nonatomic, assign) CGFloat y_cornerValue;
@property (nonatomic, assign) YCornerType y_type;

/**
 remove corner
 */
- (void)y_remove;

- (void)y_redraw;

- (void)y_addYCornerType:(YCornerType)type value:(CGFloat)value;

- (void)y_addYCornerType:(YCornerType)type
                   value:(CGFloat)value
                   width:(CGFloat)width
                   color:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
