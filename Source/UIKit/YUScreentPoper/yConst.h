//
//  yConst.h
//  YUScreentPoperDemo
//
//  Created by yxy on 14/12/8.
//  Copyright (c) 2014年 XIAYUN.YE. All rights reserved.
//

#import <Foundation/Foundation.h>
#define IS_IOS_7 ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)?YES:NO
#define ScreenHeight ((IS_IOS_7)?([UIScreen mainScreen].bounds.size.height):([UIScreen mainScreen].bounds.size.height - 20))
#define SCREEN_WIDTH (int)[UIScreen mainScreen].bounds.size.width
@interface yConst : NSObject

@end

