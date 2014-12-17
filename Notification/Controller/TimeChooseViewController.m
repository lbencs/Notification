//
//  TimeChooseViewController.m
//  Notification
//
//  Created by lbencs on 11/29/14.
//  Copyright (c) 2014 wentaolu. All rights reserved.
//

#import "TimeChooseViewController.h"

static NSString * const kTimeCellIdentify = @"TimeChooseCellIdentify";

@interface TimeChooseViewController ()
@property (strong, nonatomic) NSMutableArray *timeItems;
@property (weak, nonatomic) IBOutlet UITableView *timeTableView;
@end

@implementation TimeChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _timeItems = [[NSMutableArray alloc] init];
    for (int i = 0; i < 12; i ++) {
        [_timeItems addObject:[NSString stringWithFormat:@"%d",i]];
    }
}

- (void)dealloc{
    _timeItems = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_timeItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeCellIdentify];
    cell.textLabel.text = _timeItems[indexPath.row];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
