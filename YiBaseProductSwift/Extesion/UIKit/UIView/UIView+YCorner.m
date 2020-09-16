//
//  UIView+YCorner.m
//  YiBaseProductSwift
//
//  Created by zero_rb on 2020/9/14.
//  Copyright © 2020 任斌. All rights reserved.
//

#import "UIView+YCorner.h"
#import <objc/runtime.h>

@interface UIView ()
///boradLayer
@property (nonatomic, strong) CAShapeLayer *boardLayer;
///linePath
@property (nonatomic, strong) UIBezierPath *path;

@property (nonatomic, assign) BOOL isAddCorner;
@end

static const char *myBoardColor = "YBoardColor";
static const char *myBoardWidth = "YBoardWidth";
static const char *myBoardLayer = "YBoardLayer";
static const char *myBoardPath  = "YBoardPath";
static const char *myCornerValue = "YCornerValue";
static const char *myCorners     = "YCorners";
static const char *myIsAddCorner = "YCornerValue";

@implementation UIView (YCorner)


- (void)y_removeCorner {
    self.y_boardWith   = 0;
    self.y_cornerValue = 0;
    self.isAddCorner   = false;
    CAShapeLayer *shaplayer = [[CAShapeLayer alloc] init];
    shaplayer.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.layer.mask = shaplayer;
        [self.boardLayer removeFromSuperlayer];
    });
}

- (void)y_redrawCorner {
    [self y_addYCornerType:self.y_type value:self.y_cornerValue width:self.y_boardWith color:self.y_boardColor];
}

- (void)y_addYCornerType:(YCornerType)type
                   value:(CGFloat)value
                   width:(CGFloat)width
                   color:(UIColor *)color {
    self.y_type = type;
    self.y_cornerValue = value;
    self.y_boardWith   = width;
    self.y_boardColor  = color;
    [self y_addYCornerType:type value:value];
}

- (void)y_addYCornerType:(YCornerType)type value:(CGFloat)value {
    self.isAddCorner = true;
    self.y_type = type;
    self.y_cornerValue = value;
    switch (type) {
        case YCornerTypeAll:
            [self drawAll];
            break;
        case YCornerTypeLeft:
            [self drawLeft];
            break;
        case YCornerTypeRight:
            [self drawRight];
            break;
        case YCornerTypeTop:
            [self drawTop];
            break;
        case YCornerTypeBottom:
            [self drawBottom];
            break;
        case YCornerTypeTopLeft:
            [self drawTopLeft];
            break;
        case YCornerTypeTopRight:
            [self drawTopRight];
            break;
        case YCornerTypeBottomLeft:
            [self drawBottomLeft];
            break;
        case YCornerTypeBottomRight:
            [self drawBottomRight];
            break;
        case YCornerTypeExceptTopLeft:
            [self drawExceptTopLeft];
            break;
        case YCornerTypeExceptTopRight:
            [self drawExceptTopRight];
            break;
        case YCornerTypeExceptBottomLeft:
            [self drawExceptBottomLeft];
            break;
        case YCornerTypeExceptBottomRight:
            [self drawExceptBottomRight];
            break;
        default:
            break;
    }
}

#pragma mark ----replace
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method origin = class_getInstanceMethod(self, @selector(layoutSubviews));
        Method my     = class_getInstanceMethod(self, @selector(my_layoutSubviews));
        method_exchangeImplementations(origin, my);
    });
}


- (void)my_layoutSubviews {
    if (self.isAddCorner) {
        [self y_redrawCorner];
    }
    [self my_layoutSubviews];
}

#pragma mark ----private func

/**
 使用贝塞尔曲线，添加边框和遮罩
 */
- (void)addBoardLineAndCorners {
    CAShapeLayer *shaplayer = [[CAShapeLayer alloc] init];
    shaplayer.path = self.path.CGPath;
    self.layer.mask = shaplayer;
    
    CAShapeLayer *boardLayer = [[CAShapeLayer alloc] init];
    boardLayer.path          = self.path.CGPath;
    boardLayer.lineWidth     = self.y_boardWith;
    boardLayer.strokeColor   = self.y_boardColor.CGColor;
    boardLayer.fillColor     = [UIColor clearColor].CGColor;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.boardLayer removeFromSuperlayer];
        [self.layer insertSublayer:boardLayer atIndex:0];
        self.boardLayer = boardLayer;
    });
}

/**
 四个角
 */
- (void)drawAll {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat width      = self.frame.size.width;
    CGFloat height     = self.frame.size.height;
    CGPoint point0     = CGPointMake(self.y_cornerValue, 0);
    CGPoint point1     = CGPointMake(width - self.y_cornerValue, 0);
    //    CGPoint point2        = CGPointMake(width, value);
    CGPoint point3     = CGPointMake(width, height - self.y_cornerValue);
    //    CGPoint point4        = CGPointMake(width - value, height);
    CGPoint point5     = CGPointMake(self.y_cornerValue, height);
    //    CGPoint point6        = CGPointMake(0, height - value);
    CGPoint point7     = CGPointMake(0, self.y_cornerValue);
    
    CGPoint center1    = CGPointMake(width -self.y_cornerValue, self.y_cornerValue);
    CGPoint center2    = CGPointMake(width -self.y_cornerValue, height - self.y_cornerValue);
    CGPoint center3    = CGPointMake(self.y_cornerValue, height - self.y_cornerValue);
    CGPoint center0    = CGPointMake(self.y_cornerValue, self.y_cornerValue);
    
    [path moveToPoint:point0];
    [path addLineToPoint:point1];
    [path addArcWithCenter:center1 radius:self.y_cornerValue startAngle:1.5*M_PI endAngle:0 clockwise:true];
    [path addLineToPoint:point3];
    [path addArcWithCenter:center2 radius:self.y_cornerValue startAngle:0 endAngle:0.5*M_PI clockwise:true];
    [path addLineToPoint:point5];
    [path addArcWithCenter:center3 radius:self.y_cornerValue startAngle:0.5*M_PI endAngle:M_PI clockwise:true];
    [path addLineToPoint:point7];
    [path addArcWithCenter:center0 radius:self.y_cornerValue startAngle:M_PI endAngle:1.5*M_PI clockwise:true];
    
    self.path = path;
    [self addBoardLineAndCorners];
}

- (void)drawLeft {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat width      = self.frame.size.width;
    CGFloat height     = self.frame.size.height;
    CGPoint point0     = CGPointMake(self.y_cornerValue, 0);
    CGPoint point1     = CGPointMake(width, 0);
    CGPoint point2     = CGPointMake(width, height);
    CGPoint point3     = CGPointMake(self.y_cornerValue, height);
    CGPoint point5     = CGPointMake(0, self.y_cornerValue);
    
    CGPoint center3    = CGPointMake(self.y_cornerValue, height - self.y_cornerValue);
    CGPoint center0    = CGPointMake(self.y_cornerValue, self.y_cornerValue);
    
    [path moveToPoint:point0];
    [path addLineToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addArcWithCenter:center3 radius:self.y_cornerValue startAngle:0.5*M_PI endAngle:M_PI clockwise:true];
    [path addLineToPoint:point5];
    [path addArcWithCenter:center0 radius:self.y_cornerValue startAngle:M_PI endAngle:1.5*M_PI clockwise:true];
    
    self.path = path;
    [self addBoardLineAndCorners];
}

- (void)drawRight {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat width      = self.frame.size.width;
    CGFloat height     = self.frame.size.height;
    CGPoint point0     = CGPointMake(0, 0);
    CGPoint point1     = CGPointMake(width - self.y_cornerValue, 0);
    CGPoint point3     = CGPointMake(width, height - self.y_cornerValue);
    CGPoint point5     = CGPointMake(0, height);
    
    CGPoint center1    = CGPointMake(width -self.y_cornerValue, self.y_cornerValue);
    CGPoint center2    = CGPointMake(width -self.y_cornerValue, height - self.y_cornerValue);
    
    [path moveToPoint:point0];
    [path addLineToPoint:point1];
    [path addArcWithCenter:center1 radius:self.y_cornerValue startAngle:1.5*M_PI endAngle:0 clockwise:true];
    [path addLineToPoint:point3];
    [path addArcWithCenter:center2 radius:self.y_cornerValue startAngle:0 endAngle:0.5*M_PI clockwise:true];
    [path addLineToPoint:point5];
    [path addLineToPoint:point0];
    
    self.path = path;
    [self addBoardLineAndCorners];
}

- (void)drawTop {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat width      = self.frame.size.width;
    CGFloat height     = self.frame.size.height;
    CGPoint point0     = CGPointMake(self.y_cornerValue, 0);
    CGPoint point1     = CGPointMake(width - self.y_cornerValue, 0);
    CGPoint point3     = CGPointMake(width, height);
    CGPoint point5     = CGPointMake(0, height);
    CGPoint point7     = CGPointMake(0, self.y_cornerValue);
    
    CGPoint center1    = CGPointMake(width -self.y_cornerValue, self.y_cornerValue);
    CGPoint center0    = CGPointMake(self.y_cornerValue, self.y_cornerValue);
    
    [path moveToPoint:point0];
    [path addLineToPoint:point1];
    [path addArcWithCenter:center1 radius:self.y_cornerValue startAngle:1.5*M_PI endAngle:0 clockwise:true];
    [path addLineToPoint:point3];
    [path addLineToPoint:point5];
    [path addLineToPoint:point7];
    [path addArcWithCenter:center0 radius:self.y_cornerValue startAngle:M_PI endAngle:1.5*M_PI clockwise:true];
    
    self.path = path;
    [self addBoardLineAndCorners];
}

- (void)drawBottom {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat width      = self.frame.size.width;
    CGFloat height     = self.frame.size.height;
    CGPoint point0     = CGPointMake(0, 0);
    CGPoint point1     = CGPointMake(width, 0);
    CGPoint point3     = CGPointMake(width, height - self.y_cornerValue);
    CGPoint point5     = CGPointMake(self.y_cornerValue, height);
    
    CGPoint center2    = CGPointMake(width -self.y_cornerValue, height - self.y_cornerValue);
    CGPoint center3    = CGPointMake(self.y_cornerValue, height - self.y_cornerValue);
    
    [path moveToPoint:point0];
    [path addLineToPoint:point1];
    [path addLineToPoint:point3];
    [path addArcWithCenter:center2 radius:self.y_cornerValue startAngle:0 endAngle:0.5*M_PI clockwise:true];
    [path addLineToPoint:point5];
    [path addArcWithCenter:center3 radius:self.y_cornerValue startAngle:0.5*M_PI endAngle:M_PI clockwise:true];
    [path addLineToPoint:point0];
    
    self.path = path;
    [self addBoardLineAndCorners];
}

- (void)drawTopLeft {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat width      = self.frame.size.width;
    CGFloat height     = self.frame.size.height;
    CGPoint point0     = CGPointMake(self.y_cornerValue, 0);
    CGPoint point1     = CGPointMake(width, 0);
    CGPoint point3     = CGPointMake(width, height);
    CGPoint point5     = CGPointMake(0, height);
    CGPoint point7     = CGPointMake(0, self.y_cornerValue);
    
    CGPoint center0    = CGPointMake(self.y_cornerValue, self.y_cornerValue);
    
    [path moveToPoint:point0];
    [path addLineToPoint:point1];
    [path addLineToPoint:point3];
    [path addLineToPoint:point5];
    [path addLineToPoint:point7];
    [path addArcWithCenter:center0 radius:self.y_cornerValue startAngle:M_PI endAngle:1.5*M_PI clockwise:true];
    self.path = path;
    [self addBoardLineAndCorners];
}

- (void)drawTopRight {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat width      = self.frame.size.width;
    CGFloat height     = self.frame.size.height;
    CGPoint point0     = CGPointMake(0, 0);
    CGPoint point1     = CGPointMake(width - self.y_cornerValue, 0);
    CGPoint point3     = CGPointMake(width, height);
    CGPoint point5     = CGPointMake(0, height);
    
    CGPoint center1    = CGPointMake(width -self.y_cornerValue, self.y_cornerValue);
    
    [path moveToPoint:point0];
    [path addLineToPoint:point1];
    [path addArcWithCenter:center1 radius:self.y_cornerValue startAngle:1.5*M_PI endAngle:0 clockwise:true];
    [path addLineToPoint:point3];
    [path addLineToPoint:point5];
    [path addLineToPoint:point0];
    
    self.path = path;
    [self addBoardLineAndCorners];
}

- (void)drawBottomLeft {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat width      = self.frame.size.width;
    CGFloat height     = self.frame.size.height;
    CGPoint point0     = CGPointMake(0, 0);
    CGPoint point1     = CGPointMake(width, 0);
    CGPoint point3     = CGPointMake(width, height);
    CGPoint point5     = CGPointMake(self.y_cornerValue, height);
    
    CGPoint center3    = CGPointMake(self.y_cornerValue, height - self.y_cornerValue);
    
    [path moveToPoint:point0];
    [path addLineToPoint:point1];
    [path addLineToPoint:point3];
    [path addLineToPoint:point5];
    [path addArcWithCenter:center3 radius:self.y_cornerValue startAngle:0.5*M_PI endAngle:M_PI clockwise:true];
    [path addLineToPoint:point0];
    
    self.path = path;
    [self addBoardLineAndCorners];
}

- (void)drawBottomRight {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat width      = self.frame.size.width;
    CGFloat height     = self.frame.size.height;
    CGPoint point0     = CGPointMake(0, 0);
    CGPoint point1     = CGPointMake(width, 0);
    CGPoint point3     = CGPointMake(width, height - self.y_cornerValue);
    CGPoint point5     = CGPointMake(0, height);
    
    CGPoint center2    = CGPointMake(width -self.y_cornerValue, height - self.y_cornerValue);
    
    [path moveToPoint:point0];
    [path addLineToPoint:point1];
    
    [path addLineToPoint:point3];
    [path addArcWithCenter:center2 radius:self.y_cornerValue startAngle:0 endAngle:0.5*M_PI clockwise:true];
    [path addLineToPoint:point5];
    [path addLineToPoint:point0];
    
    self.path = path;
    [self addBoardLineAndCorners];
}

- (void)drawExceptTopLeft {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat width      = self.frame.size.width;
    CGFloat height     = self.frame.size.height;
    CGPoint point0     = CGPointMake(0, 0);
    CGPoint point1     = CGPointMake(width - self.y_cornerValue, 0);
    CGPoint point3     = CGPointMake(width, height - self.y_cornerValue);
    CGPoint point5     = CGPointMake(self.y_cornerValue, height);
    
    CGPoint center1    = CGPointMake(width -self.y_cornerValue, self.y_cornerValue);
    CGPoint center2    = CGPointMake(width -self.y_cornerValue, height - self.y_cornerValue);
    CGPoint center3    = CGPointMake(self.y_cornerValue, height - self.y_cornerValue);
    
    [path moveToPoint:point0];
    [path addLineToPoint:point1];
    [path addArcWithCenter:center1 radius:self.y_cornerValue startAngle:1.5*M_PI endAngle:0 clockwise:true];
    [path addLineToPoint:point3];
    [path addArcWithCenter:center2 radius:self.y_cornerValue startAngle:0 endAngle:0.5*M_PI clockwise:true];
    [path addLineToPoint:point5];
    [path addArcWithCenter:center3 radius:self.y_cornerValue startAngle:0.5*M_PI endAngle:M_PI clockwise:true];
    [path addLineToPoint:point0];
    
    self.path = path;
    [self addBoardLineAndCorners];
}

- (void)drawExceptTopRight {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat width      = self.frame.size.width;
    CGFloat height     = self.frame.size.height;
    CGPoint point0     = CGPointMake(self.y_cornerValue, 0);
    CGPoint point1     = CGPointMake(width, 0);
    CGPoint point3     = CGPointMake(width, height - self.y_cornerValue);
    CGPoint point5     = CGPointMake(self.y_cornerValue, height);
    CGPoint point7     = CGPointMake(0, self.y_cornerValue);
    
    CGPoint center2    = CGPointMake(width -self.y_cornerValue, height - self.y_cornerValue);
    CGPoint center3    = CGPointMake(self.y_cornerValue, height - self.y_cornerValue);
    CGPoint center0    = CGPointMake(self.y_cornerValue, self.y_cornerValue);
    
    [path moveToPoint:point0];
    [path addLineToPoint:point1];
    [path addLineToPoint:point3];
    [path addArcWithCenter:center2 radius:self.y_cornerValue startAngle:0 endAngle:0.5*M_PI clockwise:true];
    [path addLineToPoint:point5];
    [path addArcWithCenter:center3 radius:self.y_cornerValue startAngle:0.5*M_PI endAngle:M_PI clockwise:true];
    [path addLineToPoint:point7];
    [path addArcWithCenter:center0 radius:self.y_cornerValue startAngle:M_PI endAngle:1.5*M_PI clockwise:true];
    
    self.path = path;
    [self addBoardLineAndCorners];
}

- (void)drawExceptBottomLeft {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat width      = self.frame.size.width;
    CGFloat height     = self.frame.size.height;
    CGPoint point0     = CGPointMake(self.y_cornerValue, 0);
    CGPoint point1     = CGPointMake(width - self.y_cornerValue, 0);
    CGPoint point3     = CGPointMake(width, height - self.y_cornerValue);
    CGPoint point5     = CGPointMake(0, height);
    CGPoint point7     = CGPointMake(0, self.y_cornerValue);
    
    CGPoint center1    = CGPointMake(width -self.y_cornerValue, self.y_cornerValue);
    CGPoint center2    = CGPointMake(width -self.y_cornerValue, height - self.y_cornerValue);
    CGPoint center0    = CGPointMake(self.y_cornerValue, self.y_cornerValue);
    
    [path moveToPoint:point0];
    [path addLineToPoint:point1];
    [path addArcWithCenter:center1 radius:self.y_cornerValue startAngle:1.5*M_PI endAngle:0 clockwise:true];
    [path addLineToPoint:point3];
    [path addArcWithCenter:center2 radius:self.y_cornerValue startAngle:0 endAngle:0.5*M_PI clockwise:true];
    [path addLineToPoint:point5];
    [path addLineToPoint:point7];
    [path addArcWithCenter:center0 radius:self.y_cornerValue startAngle:M_PI endAngle:1.5*M_PI clockwise:true];
    
    self.path = path;
    [self addBoardLineAndCorners];
}

- (void)drawExceptBottomRight {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat width      = self.frame.size.width;
    CGFloat height     = self.frame.size.height;
    CGPoint point0     = CGPointMake(self.y_cornerValue, 0);
    CGPoint point1     = CGPointMake(width - self.y_cornerValue, 0);
    CGPoint point3     = CGPointMake(width, height);
    CGPoint point5     = CGPointMake(self.y_cornerValue, height);
    CGPoint point7     = CGPointMake(0, self.y_cornerValue);
    
    CGPoint center1    = CGPointMake(width -self.y_cornerValue, self.y_cornerValue);
    CGPoint center3    = CGPointMake(self.y_cornerValue, height - self.y_cornerValue);
    CGPoint center0    = CGPointMake(self.y_cornerValue, self.y_cornerValue);
    
    [path moveToPoint:point0];
    [path addLineToPoint:point1];
    [path addArcWithCenter:center1 radius:self.y_cornerValue startAngle:1.5*M_PI endAngle:0 clockwise:true];
    [path addLineToPoint:point3];
    [path addLineToPoint:point5];
    [path addArcWithCenter:center3 radius:self.y_cornerValue startAngle:0.5*M_PI endAngle:M_PI clockwise:true];
    [path addLineToPoint:point7];
    [path addArcWithCenter:center0 radius:self.y_cornerValue startAngle:M_PI endAngle:1.5*M_PI clockwise:true];
    
    self.path = path;
    [self addBoardLineAndCorners];
}

#pragma mark ----getter seter

- (UIColor *)y_boardColor {
    UIColor *color = objc_getAssociatedObject(self, myBoardColor);
    if (!color) {
        color = [UIColor clearColor];
    }
    return color;
}

- (void)setY_boardColor:(UIColor *)y_boardColor {
    objc_setAssociatedObject(self, myBoardColor, y_boardColor, OBJC_ASSOCIATION_RETAIN);
}

- (CGFloat)y_boardWith {
    NSString *width  = objc_getAssociatedObject(self, myBoardWidth);
    return width.floatValue;
}

- (void)setY_boardWith:(CGFloat)y_boardWith {
    NSString *temp = [NSString stringWithFormat:@"%.2f", y_boardWith];
    objc_setAssociatedObject(self, myBoardWidth, temp, OBJC_ASSOCIATION_COPY);
}

- (CAShapeLayer *)boardLayer {
    CAShapeLayer *layer = objc_getAssociatedObject(self, myBoardLayer);
    return layer;
}

- (void)setBoardLayer:(CAShapeLayer *)boardLayer {
    objc_setAssociatedObject(self, myBoardLayer, boardLayer, OBJC_ASSOCIATION_RETAIN);
}

- (UIBezierPath *)path {
    UIBezierPath *path = objc_getAssociatedObject(self, myBoardPath);
    if (!path) {
        path = [UIBezierPath bezierPath];
    }
    return path;
}

- (void)setPath:(UIBezierPath *)path {
    objc_setAssociatedObject(self, myBoardPath, path, OBJC_ASSOCIATION_RETAIN);
}

- (CGFloat)y_cornerValue {
    NSString *value  = objc_getAssociatedObject(self, myCornerValue);
    return value.floatValue;
}

- (void)setY_cornerValue:(CGFloat)y_cornerValue {
    NSString *temp = [NSString stringWithFormat:@"%.2f", y_cornerValue];
    objc_setAssociatedObject(self, myCornerValue, temp, OBJC_ASSOCIATION_COPY);
}

- (YCornerType)y_type {
    NSString *type  = objc_getAssociatedObject(self, myCorners);
    return type.integerValue;
}

- (void)setY_type:(YCornerType)y_type {
    NSString *temp = [NSString stringWithFormat:@"%ld", (long)y_type];
    objc_setAssociatedObject(self, myCorners, temp, OBJC_ASSOCIATION_COPY);
}

- (BOOL)isAddCorner {
    NSString *type  = objc_getAssociatedObject(self, myIsAddCorner);
    return type.boolValue;
}

- (void)setIsAddCorner:(BOOL)isAddCorner {
    NSString *temp = isAddCorner ? @"1" : @"0";
    objc_setAssociatedObject(self, myIsAddCorner, temp, OBJC_ASSOCIATION_COPY);
}

@end
