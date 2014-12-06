//
//  SRMSwipCell.m
//  Notification
//
//  Created by lbencs on 11/30/14.
//  Copyright (c) 2014 wentaolu. All rights reserved.
//

#import "SRMSwipCell.h"
#import <QuartzCore/QuartzCore.h>

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
    _mainViewRIghtConstrain.constant = 0;
}

- (void)configueCell:(id)model{
    [self initialization];
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)panGesture{
    CGPoint transPoint = [panGesture translationInView:panGesture.view];
    static CGPoint originalCenter;
    if (1) {
        switch (panGesture.state) {
            case UIGestureRecognizerStateBegan:
            {
                originalCenter = self.center;
            }
                break;
            case UIGestureRecognizerStateChanged:
            {
                _mainViewRIghtConstrain.constant += -transPoint.x;
                _contentViewLeftConstrain.constant += transPoint.x;
                
                //image
                static CGFloat kStart = 1.5;
                _finishedIconImageView.alpha += 1.0/10;
                _finishedIconImageView.transform = CGAffineTransformMakeScale(kStart, kStart);
            }
                break;
            case UIGestureRecognizerStateCancelled:
            case UIGestureRecognizerStateEnded:
            case UIGestureRecognizerStateFailed:
            {
                _mainViewRIghtConstrain.constant = 20;
                _contentViewLeftConstrain.constant = 0;
                [UIView animateWithDuration:0.3 animations:^{
                    _finishedIconImageView.alpha = 0;
                    _finishedIconImageView.transform = CGAffineTransformMakeScale(1, 1);
                    [self layoutIfNeeded];
                    [self deleteCellFromTableviewAnimation];
                }];
            }
                break;
                
            default:
                break;
        }
    }
    [panGesture setTranslation:CGPointZero inView:panGesture.view];
}

- (void)deleteCellFromTableviewAnimation{
    _mainViewRIghtConstrain.constant = CGRectGetWidth(self.frame);
    [UIView animateWithDuration:1.0 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(deleteSelectedCell:)]) {
            [self.delegate deleteSelectedCell:self];
        }
    }];
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
