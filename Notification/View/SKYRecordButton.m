//
//  SKYRecordButton.m
//  SKYRecordButton
//
//  Created by sky on 14/12/13.
//  Copyright (c) 2014年 sky. All rights reserved.
//

#import "SKYRecordButton.h"

@interface SKYRecordButton()<UIGestureRecognizerDelegate>

@property(assign, nonatomic) BOOL isUpOutsideUp;        //手势滑到按钮外部的以上

@end



@implementation SKYRecordButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self configueRecordButton];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self configueRecordButton];
    }
    
    return self;
}

- (void)configueRecordButton{
    

    self.isUpOutsideUp = NO;
    
    //long press
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressOnButton:)];
    longPressGesture.delegate = self;
    longPressGesture.minimumPressDuration = 0.3;
    [self addGestureRecognizer:longPressGesture];
    
}


- (void)longPressOnButton:(UIGestureRecognizer *)longPressGesture{
    switch (longPressGesture.state) {
        case UIGestureRecognizerStateBegan:
        {

//            NSLog(@"start");
            
            //long press start
            if (self.delegate && [self.delegate respondsToSelector:@selector(longPressBeginInRecordButton:)]) {
                [self.delegate longPressBeginInRecordButton:self];
            }
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            
            CGPoint location = [longPressGesture locationInView:self];
            
            if (location.y < -5) {
                if (self.isUpOutsideUp) {
                    //已经在外部的上面
                } else {
                    
                     NSLog(@"滑到按钮上面了");
                    
                    self.isUpOutsideUp = YES;
                    if (self.delegate && [self.delegate respondsToSelector:@selector(longPressDragOutsideUpOfRecordButton:)]) {
                        [self.delegate longPressDragOutsideUpOfRecordButton:self];
                    }
                }
            } else {
                if (self.isUpOutsideUp) {
                     NSLog(@"回到按钮内部");
                    self.isUpOutsideUp = NO;
                    if (self.delegate && [self.delegate respondsToSelector:@selector(longPressDragEnterRecordButton:)]) {
                        [self.delegate longPressDragEnterRecordButton:self];
                    }
                } else {
                    //已经在按钮内部或下面
                }
            }
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        {
            //long press end
            
            if (self.isUpOutsideUp) {
                 NSLog(@"在外上不 结束");
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(longPressEndOutsideUpOfRecordButton:)]) {
                    [self.delegate longPressEndOutsideUpOfRecordButton:self];
                }
                self.isUpOutsideUp = NO;
                
            } else {
                
                 NSLog(@"内部结束");
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(longPressEndInRecordButton:)]) {
                    [self.delegate longPressEndInRecordButton:self];
                }
            }

        }
            break;
            
        default:
            break;
    }
}

@end
