//
//  SRMSwipCell.h
//  Notification
//
//  Created by lbencs on 11/30/14.
//  Copyright (c) 2014 wentaolu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRMSwipCell;
@protocol SRMSwipCellDelegate <NSObject>
- (void)deleteSelectedCell:(SRMSwipCell *)cell;
@end


@interface SRMSwipCell : UITableViewCell<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet id<SRMSwipCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIImageView *completionTagImageView;
@property (weak, nonatomic) IBOutlet UIView *textView;
@property (weak, nonatomic) IBOutlet UIView *circleBackGroundView;
@property (weak, nonatomic) IBOutlet UIImageView *finishedIconImageView;
@property (weak, nonatomic) IBOutlet UIView *mainContentView;


//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewLeftConstrain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainViewRIghtConstrain;

- (void)configueCell:(id)model;
@end
