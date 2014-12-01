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
    // Initialization code
//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
//    panGesture.delegate = self;
//    [self addGestureRecognizer:panGesture];
}
//
//- (void)panGestureRecognizer:(UIPanGestureRecognizer *)panGesture{
//    
//}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
////    if ([[self superview] isKindOfClass:[UITableView class]]) {
////        return YES;
////    }
//    return YES;
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
