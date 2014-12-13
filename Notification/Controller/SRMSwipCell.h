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
//- (void)swipCell:(SRMSwipCell *)cell deleteCell
- (void)swipCell:(SRMSwipCell *)cell playVoice:(UIImageView *)playButtonImageView isPlaying:(BOOL)isPlaying;
@end


@interface SRMSwipCell : UITableViewCell<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet id<SRMSwipCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIImageView *completionTagImageView;
@property (weak, nonatomic) IBOutlet UIView *textView;
@property (weak, nonatomic) IBOutlet UIView *circleBackGroundView;
@property (weak, nonatomic) IBOutlet UIImageView *finishedIconImageView;
@property (weak, nonatomic) IBOutlet UIView *mainContentView;
@property (weak, nonatomic) IBOutlet UIImageView *playButtonImage;


//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewLeftConstrain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainViewRIghtConstrain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgoundRightConstrain;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainViewLeftConstrain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *finishImageHeightConstrain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *finishedImageWidthConstrain;


- (void)configueCell:(id)model;
@end
