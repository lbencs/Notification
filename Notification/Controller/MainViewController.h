//
//  MainViewController.h
//  Notification
//
//  Created by wentaolu on 14/11/28.
//  Copyright (c) 2014年 wentaolu. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSInteger, SRMC) <#new#>;


@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
- (IBAction)swipeToRightGesture:(UISwipeGestureRecognizer *)sender;
- (IBAction)panGesture:(UIPanGestureRecognizer *)sender;

@end