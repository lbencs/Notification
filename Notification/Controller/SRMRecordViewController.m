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

@interface SRMRecordViewController ()
@property (weak, nonatomic) IBOutlet SCSiriWaveformView *recordWaveView;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;


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

    
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(recordButtonLongPressed:)];
    // you can control how many seconds before the gesture is recognized
    gesture.minimumPressDuration = 0.5;
    [self.recordButton addGestureRecognizer:gesture];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //进来时不显示录音波动线
    self.recordWaveView.hidden = YES;
}

- (void)recordButtonLongPressed:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        DLog(@"Touch down");
        
        [self startRecording];
        
    }
    if (gesture.state == UIGestureRecognizerStateEnded) {
        
        DLog(@"Long press Ended");
        [self stopRecording];
    }
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
