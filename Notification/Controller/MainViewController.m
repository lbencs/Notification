//
//  MainViewController.m
//  Notification
//
//  Created by wentaolu on 14/11/28.
//  Copyright (c) 2014年 wentaolu. All rights reserved.
//

#import "MainViewController.h"
#import "SRMSwipCell.h"
static NSString * const kNotificationCellIdentify = @"NotificationCellIdentify";
@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *noticeTableView;
@property (strong, nonatomic) NSMutableArray *noticeItems;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _noticeItems = [[NSMutableArray alloc] init];
    for (int i = 0; i < 19; i ++) {
        [_noticeItems addObject:@"haha"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return [_noticeItems count];
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SRMSwipCell *cell = [tableView dequeueReusableCellWithIdentifier:kNotificationCellIdentify];
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

- (IBAction)swipeToRightGesture:(UISwipeGestureRecognizer *)sender {
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            NSLog(@"start");
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            NSLog(@"changed");
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            NSLog(@"end");
        }
            break;
        default:
            break;
    }
}

- (IBAction)panGesture:(UIPanGestureRecognizer *)sender {
    
    NSLog(@"--------> %@",sender.view);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([otherGestureRecognizer.view isKindOfClass:[UITableView class]]) {
        return YES;
    }
    return NO;
}
@end
