//
//  SRMSwipCell.m
//  Notification
//
//  Created by lbencs on 11/30/14.
//  Copyright (c) 2014 wentaolu. All rights reserved.
//

#import "SRMSwipCell.h"

@implementation SRMSwipCell

- (void)awakeFromNib {
    
//    self.translatesAutoresizingMaskIntoConstraints = NO;
    // Initialization code
    [self.gestureRecognizers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIGestureRecognizer class]]) {
            [self removeGestureRecognizer:obj];
        }
    }];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
    panGesture.delegate = self;
    [self addGestureRecognizer:panGesture];
}
- (void)panGestureRecognizer:(UIPanGestureRecognizer *)panGesture{
    
    // 偏移量
    CGPoint location = [panGesture locationInView:panGesture.view];
    CGPoint transPoint = [panGesture translationInView:panGesture.view];
//    NSLog(@"%@ %@",NSStringFromCGPoint(location),NSStringFromCGPoint(transPoint));
    for (NSLayoutConstraint *constraint in self.mainContentView.constraints) {
//        NSLog(@"%@  %@",constraint,constraint)
        if (constraint.secondItem == self.finishedIconImageView) {
            constraint.constant += transPoint.x;
            NSLog(@"%@",constraint);
        }
        if (constraint.firstAttribute == NSLayoutAttributeLeft) {
            NSLog(@"%@",constraint);
        }
    }
    for (NSLayoutConstraint *constraint in self.contentView.constraints) {
        
        if (constraint.secondItem == self.mainContentView && constraint.firstAttribute == NSLayoutAttributeTrailing) {
            constraint.constant += - transPoint.x;
        }
    }
    
    [self.contentView.constraints enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
    }];
//    NSLog(@"%f", transPoint.x);
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
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
