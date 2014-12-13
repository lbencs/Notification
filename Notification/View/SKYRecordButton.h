//
//  SKYRecordButton.h
//  SKYRecordButton
//
//  Created by sky on 14/12/13.
//  Copyright (c) 2014年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKYRecordButton;

@protocol SKYRecordButtonDelegate <NSObject>

@optional

/**
 *  长按录音button 开始
 *
 *  @param recordButton
 */
- (void)longPressBeginInRecordButton:(SKYRecordButton *)recordButton;

/**
 *  长按录音button 结束
 *
 *  @param recordButton
 */
- (void)longPressEndInRecordButton:(SKYRecordButton *)recordButton;

/**
 *  长按录音button 手指滑到按钮外面的上部
 *
 *  @param recordButton
 */
- (void)longPressDragOutsideUpOfRecordButton:(SKYRecordButton *)recordButton;

/**
 *  长按录音button 手指按钮外面的上部移回来
 *
 *  @param recordButton
 */
- (void)longPressDragEnterRecordButton:(SKYRecordButton *)recordButton;

/**
 *  长按录音button 手指在按钮外面的上部松开  对应取消录音
 *
 *  @param recordButton
 */
- (void)longPressEndOutsideUpOfRecordButton:(SKYRecordButton *)recordButton;

@end


@interface SKYRecordButton : UIButton

@property(weak, nonatomic) id<SKYRecordButtonDelegate> delegate;
@end
