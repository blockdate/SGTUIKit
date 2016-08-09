//
//  SGTTradeView.h
//  Transfer
//
//  Created by Block on 15/4/30.
//  Copyright (c) 2015年 block. All rights reserved.
//  交易密码视图\负责整个项目的交易密码输入

#import <UIKit/UIKit.h>

@class SGTTradeKeyboard,SGTTradeView;

@protocol SGTTradeViewDelegate <NSObject>

@optional
/** 输入完成点击确定按钮 */
//- (void)finish:(NSString *)pwd;
- (void)tradeView:(SGTTradeView *)view finishWithKey:(NSString *)pwd;
- (void)tradeViewCanceled:(SGTTradeView *)view ;
//- (void)tradeView:(SGTTradeView *)view finishWithKey:(NSString *)pwd orderID:(NSString *)oid;
@end

@interface SGTTradeView : UIView

@property (nonatomic, weak) id<SGTTradeViewDelegate> delegate;

/** 完成的回调block */
@property (nonatomic, copy) void (^finish) (NSString *passWord);

/** 快速创建 */
+ (instancetype)tradeView;

//- (instancetype)initWithFrame:(CGRect)frame subTitle:(NSString *)subTitle price:(NSString *)price;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title subTitle:(NSString *)subTitle price:(NSString *)price;


/** 弹出 */
- (void)show;
- (void)showInView:(UIView *)view;
/** 消失 */
- (void)dismiss;

- (instancetype)b_subtitle:(NSString *)title;
- (instancetype)b_pricetitle:(NSString *)title;
- (instancetype)b_alertTitle:(NSString *)title;
- (void)deleteAllInput;
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@property (nonatomic, copy) NSString  *subTitle;
@end
