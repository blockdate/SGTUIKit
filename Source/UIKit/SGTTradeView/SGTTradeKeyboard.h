//
//  SGTTradeKeyboard.h
//  Transfer
//
//  Created by Block on 15/4/24.
//  Copyright (c) 2015年 block. All rights reserved.
//  交易密码键盘

#import <Foundation///Foundation.h>

static NSString *SGTTradeKeyboardDeleteButtonClick = @"SGTTradeKeyboardDeleteButtonClick";
static NSString *SGTTradeKeyboardOkButtonClick = @"SGTTradeKeyboardOkButtonClick";
static NSString *SGTTradeKeyboardNumberButtonClick = @"SGTTradeKeyboardNumberButtonClick";
static NSString *SGTTradeKeyboardNumberKey = @"SGTTradeKeyboardNumberKey";

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"

@class SGTTradeKeyboard;

@protocol SGTTradeKeyboardDelegate <NSObject>

@optional
/** 数字按钮点击 */
- (void)tradeKeyboard:(SGTTradeKeyboard *)keyboard numBtnClick:(NSInteger)num;
/** 删除按钮点击 */
- (void)tradeKeyboardDeleteBtnClick;
/** 确定按钮点击 */
- (void)tradeKeyboardOkBtnClick;
@end

@interface SGTTradeKeyboard : UIView
// 代理
@property (nonatomic, weak) id<SGTTradeKeyboardDelegate> delegate;
@end
