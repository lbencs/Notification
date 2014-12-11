//
//  UtilsMacro.h
//  Notification
//
//  Created by lbencs on 11/29/14.
//  Copyright (c) 2014 wentaolu. All rights reserved.
//

#ifndef Notification_UtilsMacro_h
#define Notification_UtilsMacro_h

#import "UIView+srmAddtion.h"
#import "POP.h"


//颜色相关
#define UIColorFromRGB(r,g,b) [UIColor \
colorWithRed:r/255.0 \
green:g/255.0 \
blue:b/255.0 alpha:1]

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//debug
#ifdef DEBUG
# define DLog(format, ...) NSLog((@"[函数名:%s]" "[行号:%d] ~(^ .^)~ " format), __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define NSLog(...);
#endif

/*
 专门用来保存单例代码
 最后一行不要加 \
 */

// @interface
#define singleton_interface(className) \
+ (className *)shared##className;


// @implementation
#define singleton_implementation(className) \
static className *_instance; \
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (className *)shared##className \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}

#endif
