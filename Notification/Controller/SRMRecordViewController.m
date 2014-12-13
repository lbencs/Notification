//
//  SRMRecordViewController.m
//  Notification
//
//  Created by wentaolu on 14/11/28.
//  Copyright (c) 2014年 wentaolu. All rights reserved.
//

#import "SRMRecordViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SCSiriWaveformView.h"
#import "SKYRecordButton.h"

@interface SRMRecordViewController ()<SKYRecordButtonDelegate>
@property (weak, nonatomic) IBOutlet SCSiriWaveformView *recordWaveView;
@property (weak, nonatomic) IBOutlet SKYRecordButton *recordButton;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;


@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) AVAudioRecorder *recorder;

@end

@implementation SRMRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
    
    NSDictionary *settings = @{AVSampleRateKey:          [NSNumber numberWithFloat: 44100.0],
                               AVFormatIDKey:            [NSNumber numberWithInt: kAudioFormatAppleLossless],
                               AVNumberOfChannelsKey:    [NSNumber numberWithInt: 2],
                               AVEncoderAudioQualityKey: [NSNumber numberWithInt: AVAudioQualityMin]};
    
    NSError *error;
    self.recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    
    if(error) {
        DLog(@"Ups, could not create recorder %@", error);
        return;
    }
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    
    if (error) {
        DLog(@"Error setting category: %@", [error description]);
    }
    
    [self.recorder prepareToRecord];
    [self.recorder setMeteringEnabled:YES];
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    self.displayLink.paused = YES;
    
    [self.recordWaveView setWaveColor:[UIColor whiteColor]];
    [self.recordWaveView setPrimaryWaveLineWidth:3.0f];
    [self.recordWaveView setSecondaryWaveLineWidth:1.0];


    self.recordButton.delegate = self;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //进来时不显示录音波动线
    self.recordWaveView.hidden = YES;
}


#pragma mark -SKYRecordButtonDelegate

//开始录音
- (void)longPressBeginInRecordButton:(SKYRecordButton *)recordButton
{
    [self startRecording];
}


//录音结束
- (void)longPressEndInRecordButton:(SKYRecordButton *)recordButton
{
    self.tipLabel.text = @"手指上滑，取消录音";
    [self stopRecording];
}

//进入待取消录音状态
- (void)longPressDragOutsideUpOfRecordButton:(SKYRecordButton *)recordButton
{
    self.tipLabel.text = @"松开手指，取消录音";
}

//继续录音
- (void)longPressDragEnterRecordButton:(SKYRecordButton *)recordButton
{
    self.tipLabel.text = @"手指上滑，取消录音";
}

//取消录音
- (void)longPressEndOutsideUpOfRecordButton:(SKYRecordButton *)recordButton
{
    self.tipLabel.text = @"手指上滑，取消录音";
    [self cancelRecording];
}

- (void) startRecording
{
//    if (![self canRecord]) {
//        [[[UIAlertView alloc] initWithTitle:nil
//                                    message:@"请在“设置-隐私-麦克风”选项中允许xx访问你的麦克风"
//                                   delegate:nil
//                          cancelButtonTitle:@"好"
//                          otherButtonTitles:nil] show];
//        return;
//    }
    
    self.recordWaveView.hidden = NO;
    [self.recorder record];
    [self startDisplayLink];
}

- (void) stopRecording
{
    [self.recorder stop];
    [self stopDisplayLink];
    [self.recordWaveView restoreToOriginState];
}

- (void)cancelRecording
{
    [self.recorder stop];
    [self stopDisplayLink];
    [self.recordWaveView restoreToOriginState];
}

- (void)startDisplayLink
{
    self.displayLink.paused = NO;
}

- (void)stopDisplayLink
{
    self.displayLink.paused = YES;
}

- (void)handleDisplayLink:(CADisplayLink *)displayLink
{
    [self updateMeters];
}


- (void)updateMeters
{
    [self.recorder updateMeters];
    
    CGFloat normalizedValue = pow (10, [self.recorder averagePowerForChannel:0] / 20);
    
    [self.recordWaveView updateWithLevel:normalizedValue];
}


- (BOOL)canRecord
{
    __block BOOL bCanRecord = YES;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    bCanRecord = YES;
                } else {
                    bCanRecord = NO;
                }
            }];
        }
    }
    
    return bCanRecord;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
