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
#define kMaxDistanceWithScrollOutofRightView 100.0
#define kFinishedImageSizeVelocity (20.0/kMaxDistanceWithScrollOutofRightView)


@interface SRMSwipCell ()<POPAnimationDelegate,POPAnimatorDelegate>
{
    CGFloat _dragDistance;
    CGFloat _oldRightConstrainConstant;
}
@property (strong, nonatomic) CABasicAnimation *basicAnimation;
@end


@implementation SRMSwipCell

- (void)awakeFromNib {
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
    panGesture.delegate = self;
    panGesture.delaysTouchesEnded = NO;
    [self addGestureRecognizer:panGesture];
//    _basicAnimation = [CABasicAnimation animation];
//    [_finishedIconImageView.layer addAnimation:_basicAnimation forKey:@"bounds"];
    _oldRightConstrainConstant = _mainViewRIghtConstrain.constant;
}
- (void)initialization{
    _dragDistance = 0;
    _finishedIconImageView.alpha = 0;
    _finishImageHeightConstrain.constant = 10;
    _finishedImageWidthConstrain.constant = 10;
    _mainViewRIghtConstrain.constant = 0;
    _mainViewLeftConstrain.constant = 0;
}

- (void)configueCell:(id)model{
    [self initialization];
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)panGesture{
    CGPoint transPoint = [panGesture translationInView:panGesture.view];
    CGPoint velocityPoint = [panGesture velocityInView:panGesture.view];
    
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
                _contentViewLeftConstrain.constant += transPoint.x;
                _mainViewRIghtConstrain.constant -= transPoint.x;
                [panGesture setTranslation:CGPointMake(0, 0) inView:panGesture.view];
                
                //image
                static CGFloat kStart = 1.5;
                
                _finishedImageWidthConstrain.constant += transPoint.x*kFinishedImageSizeVelocity;
                _finishImageHeightConstrain.constant += transPoint.x*kFinishedImageSizeVelocity;
                //缩小
//                bounds.size.width += transPoint.x/kMaxDistanceWithScrollOutofRightView;
//                bounds.size.height += transPoint.y/kMaxDistanceWithScrollOutofRightView;
//                bounds.size.width += transPoint.x;
//                bounds.size.height += transPoint.x;
//                _basicAnimation.toValue = [NSValue valueWithCGRect:bounds];
//                
//                CABasicAnimation *colorAnimation = [CABasicAnimation animation];
//                colorAnimation.delegate = self;
//                colorAnimation.toValue = [NSValue valueWithCGRect:bounds];
//                [_finishedIconImageView.layer addAnimation:colorAnimation forKey:@"bounds"];
                
                
                
                _finishedIconImageView.alpha += transPoint.x/kMaxDistanceWithScrollOutofRightView;
                _finishedIconImageView.transform = CGAffineTransformMakeScale(kStart, kStart);
            }
                break;
            case UIGestureRecognizerStateCancelled:
            case UIGestureRecognizerStateEnded:
            case UIGestureRecognizerStateFailed:
            {
//                [self deleteCellFromTableviewAnimation];
  
                _contentViewLeftConstrain.constant = 0;
                _mainViewRIghtConstrain.constant = 20;
                [UIView animateWithDuration:.4 animations:^{
                    [self layoutIfNeeded];
                } completion:^(BOOL finished) {
                    if (1) {
                    }
                    [self deleteCellFromTableviewAnimation];
                }];
                //                CABasicAnimation *animation = [CABasicAnimation animation];
                //                animation.duration = 1.0;
                //                animation.repeatCount = 10000;
                //                animation.toValue = [NSValue valueWithCGSize:CGSizeMake(100, 44)];
                //                [self.layer addAnimation:animation forKey:@"bounds"];
                //                POPDecayAnimation *decayAnimation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
                //                decayAnimation.delegate = self;
                //                decayAnimation.velocity = [NSValue valueWithCGPoint:velocityPoint];
                //                [_mainContentView.layer pop_addAnimation:decayAnimation forKey:@"layerPositionAnimation"];
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
    _mainViewLeftConstrain.constant = -CGRectGetWidth(self.frame);
    _contentViewLeftConstrain.constant = 0;
    
    [UIView animateWithDuration:.4 delay:.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
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

- (void)pop_animationDidApply:(POPDecayAnimation *)anim{
    //    BOOL isDragViewOutsideOfSuperView = !CGRectContainsRect(self.frame, _mainContentView.frame);
    //
    //    BOOL isDragViewOutsideOfSuperRightView = !((_mainContentView.frame.origin.x - self.frame.origin.x) < kMaxDistanceWithScrollOutofRightView);
    //
    //    NSLog(@"%@ -------- %@",NSStringFromCGRect(self.frame),NSStringFromCGRect(_mainContentView.frame));
    //
    //    if (isDragViewOutsideOfSuperRightView) {
    //        POPDecayAnimation *positionAnimation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    //        CGPoint currentVelocity = [anim.velocity CGPointValue];
    //        //        CGPoint velocity = CGPointMake(currentVelocity.x, -currentVelocity.y);
    //        //        decayAnimation.velocity = [NSValue valueWithCGPoint:velocity];
    //        NSLog(@"%@",NSStringFromCGPoint(self.center));
    //        positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0, self.center.y)];
    //        [_main jContentView.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
    //    }
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
