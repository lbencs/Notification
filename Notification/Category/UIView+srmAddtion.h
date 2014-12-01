//
//  UIView+srmAddtion.h
//  SRMMessageDisplay
//
//  Created by wentaolu on 11/6/14.
//  Copyright (c) 2014 wentaolu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (srmAddtion)
@property (assign, nonatomic) CGFloat cornerRadius;

- (CGFloat)x;
- (void)setX:(CGFloat)x;
- (CGFloat)y;
- (void)setY:(CGFloat)y;
- (CGFloat)width;
- (void)setWidth:(CGFloat)width;
- (CGFloat)height;
- (void)setHeight:(CGFloat)height;
- (CGSize)size;
- (void)setSize:(CGSize)size;

- (void)setCornerRadius:(CGFloat)radius;
- (void)setBorderWith:(CGFloat)width color:(UIColor *)color;
@end
