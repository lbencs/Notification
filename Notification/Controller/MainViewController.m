//
//  MainViewController.m
//  Notification
//
//  Created by wentaolu on 14/11/28.
//  Copyright (c) 2014年 wentaolu. All rights reserved.
//

#import "MainViewController.h"

static NSString * const kNotificationCellIdentify = @"NotificationCellIdentify";
@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *noticeTableView;
@property (weak, nonatomic) IBOutlet UIImageView *playVoice;
@property (strong, nonatomic) NSMutableArray *noticeItems;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _noticeItems = [[NSMutableArray alloc] init];
    for (int i = 0; i < 19; i ++) {
        [_noticeItems addObject:@"haha"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return [_noticeItems count];
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SRMSwipCell *cell = [tableView dequeueReusableCellWithIdentifier:kNotificationCellIdentify];
    [cell configueCell:nil];
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([otherGestureRecognizer.view isKindOfClass:[UITableView class]]) {
        return YES;
    }
    return NO;
}

- (void)deleteSelectedCell:(SRMSwipCell *)cell{
    NSIndexPath *indexPath = [_noticeTableView indexPathForCell:cell];
    if (indexPath)
    {
        DLog(@"%ld   %ld",(long)indexPath.row,(long)indexPath.section);
        [_noticeItems removeObjectAtIndex:indexPath.row];
        [_noticeTableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (void)swipCell:(SRMSwipCell *)cell playVoice:(UIImageView *)playButtonImageView isPlaying:(BOOL)isPlaying{
    DLog(@"play  %d",isPlaying);
}
@end
