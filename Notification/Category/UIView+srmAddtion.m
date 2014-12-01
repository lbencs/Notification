//
//  UIView+srmAddtion.m
//  SRMMessageDisplay
//
//  Created by wentaolu on 11/6/14.
//  Copyright (c) 2014 wentaolu. All rights reserved.
//

#import "UIView+srmAddtion.h"
#import <QuartzCore/QuartzCore.h>
@implementation UIView (srmAddtion)
@dynamic cornerRadius;

- (CGFloat)x{
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)y{
    return self.frame.origin.y;
}
- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)width{
    return CGRectGetWidth(self.frame);
}
- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)height{
    return CGRectGetHeight(self.frame);
}
- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGSize)size{
    return self.frame.size;
}
- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (void)setCornerRadius:(CGFloat)radius{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}
- (void)setBorderWith:(CGFloat)width color:(UIColor *)color{
    self.layer.borderWidth = width;
    UIColor *borderColor = color;
    if (!borderColor) {
        borderColor = [UIColor lightGrayColor];
    }
    self.layer.borderColor = [borderColor CGColor];
}
@end
