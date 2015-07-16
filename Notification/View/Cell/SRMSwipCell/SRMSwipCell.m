//
//  SRMSwipCell.m
//  Notification
//
//  Created by lbencs on 11/30/14.
//  Copyright (c) 2014 wentaolu. All rights reserved.
//

#import "SRMSwipCell.h"
#import <QuartzCore/QuartzCore.h>

#define kMinVelocity  100.0
#define kMaxDistanceWithScrollOutofRightView 60.0
#define kFinishedImageSizeVelocity (20.0/kMaxDistanceWithScrollOutofRightView)
#define kFinishedImageSize 20

#define kFinishedImageShowedInDisntance 60

@interface SRMSwipCell ()
{
    CGFloat  _dragDistance;
    CGFloat  _oldRightConstrainConstant;
    BOOL     _exceedEnougthToDelete;  //是否需要删除
    BOOL     _canMoveToLeft;   //是否可以向左移动
    BOOL     _isPlaying;     //是否正在播放
}
@property (strong, nonatomic) CABasicAnimation *basicAnimation;
@property (weak, nonatomic) IBOutlet UIView *cellBackgroundView;
@end

@implementation SRMSwipCell

- (void)awakeFromNib {
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
    panGesture.delegate = self;
    panGesture.delaysTouchesEnded = NO;
    [self addGestureRecognizer:panGesture];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playVoice:)];
    _playButtonImage.userInteractionEnabled = YES;
    [_playButtonImage addGestureRecognizer:tapGesture];
    
    _playButtonImage.animationImages = [self animationImageArray];
    _playButtonImage.animationDuration = 1.0;
    _playButtonImage.animationRepeatCount = 1000;
}
- (void)initialization{
    _dragDistance = 0;
    _finishedIconImageView.alpha = 0;
    _finishImageHeightConstrain.constant = 10;
    _finishedImageWidthConstrain.constant = 10;
    _mainViewRIghtConstrain.constant = 0;
    _mainViewLeftConstrain.constant = 0;
}

- (void)configueCell:(id)model{
    [self initialization];
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)panGesture{
    CGPoint transPoint = [panGesture translationInView:panGesture.view];
    
    static CGPoint originalCenter;
    if (1) {
        switch (panGesture.state) {
            case UIGestureRecognizerStateBegan:
            {
                originalCenter = self.center;
            }
                break;
            case UIGestureRecognizerStateChanged:
            {
                if (!(transPoint.x < 0 && !_canMoveToLeft)) {
                    _contentViewLeftConstrain.constant += transPoint.x;
                    _mainViewRIghtConstrain.constant -= transPoint.x;
                }

                [panGesture setTranslation:CGPointMake(0, 0) inView:panGesture.view];
                if (_contentViewLeftConstrain.constant > kMaxDistanceWithScrollOutofRightView) {
                    _exceedEnougthToDelete = YES;
                }else{
                    _exceedEnougthToDelete = NO;
                }
                if (_contentViewLeftConstrain.constant > 0) {
                    _canMoveToLeft = YES;
                }else{
                    _canMoveToLeft = NO;
                }

                //变大
                //透明度
                _finishedIconImageView.alpha += transPoint.x/kFinishedImageShowedInDisntance;
                CGFloat scale = fabs(_mainViewRIghtConstrain.constant/60.0 * 3) ;
                if (scale <= 3) {
                    _finishedIconImageView.transform = CGAffineTransformMakeScale(scale, scale);
                }else{
                    _finishedIconImageView.transform = CGAffineTransformMakeScale(3, 3);
                }
            }
                break;
            case UIGestureRecognizerStateCancelled:
            case UIGestureRecognizerStateEnded:
            case UIGestureRecognizerStateFailed:
            {
                _contentViewLeftConstrain.constant = 0;
                _mainViewRIghtConstrain.constant = 0;
                _finishedImageWidthConstrain.constant = 10;
                _finishImageHeightConstrain.constant = 10;
                [UIView animateWithDuration:.4 animations:^{
                    [self layoutIfNeeded];
                    _finishedIconImageView.alpha = 0;
                } completion:^(BOOL finished) {
                    if (_exceedEnougthToDelete) {
                        [self deleteCellFromTableviewAnimation];
                    }
                }];
            }
                break;
            default:
                break;
        }
    }
    [panGesture setTranslation:CGPointZero inView:panGesture.view];
}

- (NSArray *)animationImageArray{
    NSMutableArray *animationArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; i ++) {
        NSString *imageName = [NSString stringWithFormat:@"ReceiverVoiceNodePlaying00%d",i];
        UIImage *image = [UIImage imageNamed:imageName];
        [animationArray addObject:image];
    }
    return animationArray;
}

- (void)deleteCellFromTableviewAnimation{
    _mainViewRIghtConstrain.constant = CGRectGetWidth(self.frame);
    _mainViewLeftConstrain.constant = -CGRectGetWidth(self.frame);
    _contentViewLeftConstrain.constant = 0;
    [UIView animateWithDuration:.4 delay:.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(deleteSelectedCell:)]) {
            [self.delegate deleteSelectedCell:self];
        }
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma gesture delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *panGestureRecognizer = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint velocityPoint = [panGestureRecognizer velocityInView:gestureRecognizer.view];
        if (fabs(velocityPoint.x) > kMinVelocity) {
            return YES;
        }
    }
    return NO;
}
- (void)playVoice:(UITapGestureRecognizer *)tapGesture {
    if (!_isPlaying) {
        [_playButtonImage startAnimating];
    }else{
        [_playButtonImage stopAnimating];
    }
    _isPlaying = !_isPlaying;
    if (self.delegate && [self.delegate respondsToSelector:@selector(swipCell:playVoice:isPlaying:)]) {
        [self.delegate swipCell:self playVoice:(UIImageView *)tapGesture.view isPlaying:_isPlaying];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

@end
