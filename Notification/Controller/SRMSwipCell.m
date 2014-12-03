//
//  SRMSwipCell.m
//  Notification
//
//  Created by lbencs on 11/30/14.
//  Copyright (c) 2014 wentaolu. All rights reserved.
//

#import "SRMSwipCell.h"

#define kMinVelocity  100.0

@interface SRMSwipCell ()
{
    CGFloat  _dragDistance;
    CGFloat _oldRightConstrainConstant;
}
@end


@implementation SRMSwipCell

- (void)awakeFromNib {
    
    //    self.translatesAutoresizingMaskIntoConstraints = NO;
    // Initialization code
//    [self.gestureRecognizers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        if ([obj isKindOfClass:[UIGestureRecognizer class]]) {
//            [self removeGestureRecognizer:obj];
//        }
//    }];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
    panGesture.delegate = self;
    panGesture.delaysTouchesEnded = NO;
    [self addGestureRecognizer:panGesture];
    
    _oldRightConstrainConstant = _mainViewRIghtConstrain.constant;
}

- (void)initialization{
    _dragDistance = 0;
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)panGesture{
    
    CGPoint transPoint = [panGesture translationInView:panGesture.view];
    CGPoint vialyPoint = [panGesture velocityInView:panGesture.view];
    if (1) {
        switch (panGesture.state) {
            case UIGestureRecognizerStateCancelled:
            case UIGestureRecognizerStateEnded:
            case UIGestureRecognizerStateFailed:
            {
                _mainViewRIghtConstrain.constant = 20;
                _finishedIconConstrain.constant = 0;
                [UIView animateWithDuration:0.3 animations:^{
                    [self layoutIfNeeded];
                }];
            }
                break;
            case UIGestureRecognizerStateBegan:
            {
                
            }
                break;
            case UIGestureRecognizerStateChanged:
            {
                _mainViewRIghtConstrain.constant += -transPoint.x;
                _finishedIconConstrain.constant += transPoint.x;
            }
                break;
                
            default:
                break;
        }
    }
    [panGesture setTranslation:CGPointZero inView:panGesture.view];
    
    
    //
    //    CABasicAnimation* ba = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //    ba.autoreverses = YES;
    //    ba.fromValue = @(2);
    //    ba.toValue = @(30);
    //    ba.byValue = @(100);
    //    ba.duration = 0.3;
    //    ba.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.4, 1.4, 1)];
    //    [self.finishedIconImageView.layer addAnimation:ba forKey:nil];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma gesture delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *panGestureRecognizer = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint velocityPoint = [panGestureRecognizer velocityInView:gestureRecognizer.view];
        if (fabsf(velocityPoint.x) > kMinVelocity) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

@end
