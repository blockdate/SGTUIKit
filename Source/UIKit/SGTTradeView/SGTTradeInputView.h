//
//  SGTTradeInputView.h
//  Transfer
//
//  Created by Block on 15/4/30.
//  Copyright (c) 2015年 block. All rights reserved.
//  交易输入视图

#import <Foundation/Foundation.h>

static NSString *SGTTradeInputViewCancleButtonClick = @"SGTTradeInputViewCancleButtonClick";
static NSString *SGTTradeInputViewOkButtonClick = @"SGTTradeInputViewOkButtonClick";
static NSString *SGTTradeInputViewPwdKey = @"SGTTradeInputViewPwdKey";

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"

@class SGTTradeInputView;

@protocol SGTTradeInputViewDelegate <NSObject>

@optional
/** 确定按钮点击 */
- (void)tradeInputView:(SGTTradeInputView *)tradeInputView okBtnClick:(UIButton *)okBtn;
/** 取消按钮点击 */
- (void)tradeInputView:(SGTTradeInputView *)tradeInputView cancleBtnClick:(UIButton *)cancleBtn;

@end

@interface SGTTradeInputView : UIView
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *priceTitle;
@property (nonatomic ,copy) NSString *title;
@property (nonatomic, weak) id<SGTTradeInputViewDelegate> delegate;
- (void)deleteAllNums;
@end
