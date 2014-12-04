//
//  MainViewController.h
//  Notification
//
//  Created by wentaolu on 14/11/28.
//  Copyright (c) 2014年 wentaolu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SRMSwipCell.h"

@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,SRMSwipCellDelegate>

@end