//
//  SGTTradeView.m
//  Transfer
//
//  Created by Block on 15/4/30.
//  Copyright (c) 2015年 block. All rights reserved.
//

// 自定义Log
#ifdef DEBUG // 调试状态, 打开LOG功能
#define SGTLog(...) NSLog(__VA_ARGS__)
#define SGTFunc SGTLog(@"%s", __func__);
#else // 发布状态, 关闭LOG功能
#define SGTLog(...)
#define SGTFunc
#endif

// 设备判断
/**
 iOS设备宽高比
 4\4s {320, 480}  5s\5c {320, 568}  6 {375, 667}  6+ {414, 736}
 0.66             0.56              0.56          0.56
 */
#define ios7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define ios8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
#define ios6 ([[UIDevice currentDevice].systemVersion doubleValue] >= 6.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 7.0)
#define ios5 ([[UIDevice currentDevice].systemVersion doubleValue] < 6.0)
#define iphone5  ([UIScreen mainScreen].bounds.size.height == 568)
#define iphone6  ([UIScreen mainScreen].bounds.size.height == 667)
#define iphone6Plus  ([UIScreen mainScreen].bounds.size.height == 736)
#define iphone4  ([UIScreen mainScreen].bounds.size.height == 480)
#define ipadMini2  ([UIScreen mainScreen].bounds.size.height == 1024)

#import "SGTTradeView.h"
#import "SGTTradeKeyboard.h"
#import "SGTTradeInputView.h"
#import "UIAlertView+Quick.h"

@interface SGTTradeView () <UIAlertViewDelegate>
/** 键盘 */
@property (nonatomic, weak) SGTTradeKeyboard *keyboard;
/** 输入框 */
@property (nonatomic, weak) SGTTradeInputView *inputView;
/** 蒙板 */
@property (nonatomic, weak) UIButton *cover;
/** 响应者 */
@property (nonatomic, weak) UITextField *responsder;
/** 键盘状态 */
@property (nonatomic, assign, getter=isKeyboardShow) BOOL keyboardShow;
/** 返回密码 */
@property (nonatomic, copy) NSString *passWord;
@property (nonatomic, copy) NSString *priceTitle;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *alertTitle;
@end

@implementation SGTTradeView

#pragma mark - LifeCircle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:SGTScreenBounds];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        /** 蒙板 */
        [self setupCover];
        /** 键盘 */
        [self setupkeyboard];
        /** 输入框 */
        [self setupInputView];
        /** 响应者 */
        [self setupResponsder];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title subTitle:(NSString *)subTitle price:(NSString *)price{
    self = [super initWithFrame:SGTScreenBounds];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.alertTitle = @"是否取消支付?";
        self.subTitle = subTitle;
        self.priceTitle = price;
        self.title = title;
        /** 蒙板 */
        [self setupCover];
        /** 键盘 */
        [self setupkeyboard];
        /** 输入框 */
        [self setupInputView];
        /** 响应者 */
        [self setupResponsder];
    }
    return self;
}

/** 蒙板 */
- (void)setupCover
{
    UIButton *cover = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:cover];
    self.cover = cover;
    [self.cover setBackgroundColor:[UIColor blackColor]];
    self.cover.alpha = 0.4;
    [self.cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
}

/** 输入框 */
- (void)setupInputView
{
    SGTTradeInputView *inputView = [[SGTTradeInputView alloc] init];
    inputView.subTitle = _subTitle;
    inputView.priceTitle = _priceTitle;
    inputView.title = _title;
    [self addSubview:inputView];
    self.inputView = inputView;
    
    /** 注册取消按钮点击的通知 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancle) name:SGTTradeInputViewCancleButtonClick object:nil];
    /** 注册确定按钮点击的通知 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputViewOk:) name:SGTTradeInputViewOkButtonClick object:nil];
}

/** 响应者 */
- (void)setupResponsder
{
    UITextField *responsder = [[UITextField alloc] init];
    [self addSubview:responsder];
    self.responsder = responsder;
}

/** 键盘 */
- (void)setupkeyboard
{
    SGTTradeKeyboard *keyboard = [[SGTTradeKeyboard alloc] init];
    [self addSubview:keyboard];
    self.keyboard = keyboard;
    
    // 注册确定按钮点击通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ok) name:SGTTradeKeyboardOkButtonClick object:nil];
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    /** 蒙板 */
    self.cover.frame = self.bounds;
}

#pragma mark - Private

- (void)coverClick
{
    if (self.isKeyboardShow) {  // 键盘是弹出状态
        [self hidenKeyboard:nil];
    } else {  // 键盘是隐藏状态
        [self showKeyboard];
    }
}

/** 键盘弹出 */
- (void)showKeyboard
{
    self.keyboardShow = YES;
    
    CGFloat marginTop;
    if (iphone4) {
        marginTop = 42;
    } else if (iphone5) {
        marginTop = 100;
    } else if (iphone6) {
        marginTop = 120;
    } else {
        marginTop = 140;
    }
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.keyboard.transform = CGAffineTransformMakeTranslation(0, -self.keyboard.height);
        self.inputView.transform = CGAffineTransformMakeTranslation(0, marginTop - self.inputView.y);
    } completion:^(BOOL finished) {
        
    }];
}

/** 键盘退下 */
- (void)hidenKeyboard:(void (^)(BOOL finished))completion
{
    self.keyboardShow = NO;
//    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.keyboard.transform = CGAffineTransformIdentity;
//        self.inputView.transform = CGAffineTransformIdentity;
//    } completion:^(BOOL finished) {
//        
//    }];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.keyboard.transform = CGAffineTransformIdentity;
        self.inputView.transform = CGAffineTransformIdentity;
    } completion:completion];
}

/** 键盘的确定按钮点击 */
- (void)ok
{
    [self hidenKeyboard:nil];
}

/** 输入框的取消按钮点击 */
- (void)cancle
{
    [self hidenKeyboard:^(BOOL finished) {
        self.inputView.hidden = YES;
        [UIAlertView showWithTitle:self.alertTitle message:nil delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    }];
}

/** 输入框的确定按钮点击 */
- (void)inputViewOk:(NSNotification *)note
{
    // 获取密码
    NSString *pwd = note.userInfo[SGTTradeInputViewPwdKey];
    // 通知代理\传递密码
    if (self.delegate && [self.delegate respondsToSelector:@selector(tradeView:finishWithKey:)]) {
        [self.delegate tradeView:self finishWithKey:pwd];
    }
//    if (self.delegate && [self.delegate respondsToSelector:@selector(tradeView:finishWithKey:orderID:)]) {
//        [self.delegate tradeView:self finishWithKey:pwd orderID:];
//    }
    // 回调block\传递密码
    if (self.finish) {
        self.finish(pwd);
    }
    // 移除自己
//    [self hidenKeyboard:^(BOOL finished) {
//        [self removeFromSuperview];
//    }];
}

- (void)dismiss {
    [self hidenKeyboard:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Public Interface

/** 快速创建 */
+ (instancetype)tradeView
{
    return [[self alloc] init];
}

/** 弹出 */
- (void)show
{
    [self showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)showInView:(UIView *)view
{
    // 浮现
    [view addSubview:self];
    
    /** 键盘起始frame */
    self.keyboard.x = 0;
    self.keyboard.y = SGTScreenHeight;
    self.keyboard.width = SGTScreenWidth;
    self.keyboard.height = SGTScreenWidth * 0.65;
    
    /** 输入框起始frame */
//    self.inputView.height = SGTScreenWidth * 0.5625;
    self.inputView.height = SGTScreenWidth * 0.7025;
    self.inputView.y = (self.height - self.inputView.height) * 0.5;
    self.inputView.width = SGTScreenWidth * 0.94375;
    self.inputView.x = (SGTScreenWidth - self.inputView.width) * 0.5;
    
    /** 弹出键盘 */
    [self showKeyboard];
}

- (instancetype)b_subtitle:(NSString *)title {
    self.subTitle = title;
    return self;
}

- (instancetype)b_pricetitle:(NSString *)title {
    self.priceTitle = title;
    return self;
}

- (instancetype)b_alertTitle:(NSString *)title {
    self.alertTitle = title;
    return self;
}

- (void)deleteAllInput {
    [self.inputView deleteAllNums];
}

- (void)setSubTitle:(NSString *)subTitle {
    _subTitle = subTitle;
    self.inputView.subTitle = subTitle;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    SGTLog(@"dealloc---");
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.inputView.hidden = NO;
    if (buttonIndex == 0) {  // 否按钮点击
        [self showKeyboard];
    } else {  // 是按钮点击
        // 清空num数组
        NSMutableArray *nums = [self.inputView valueForKeyPath:@"nums"];
        [nums removeAllObjects];
        [self removeFromSuperview];
        [self.inputView setNeedsDisplay];
        if (self.delegate && [self.delegate respondsToSelector:@selector(tradeViewCanceled:)]) {
            [self.delegate tradeViewCanceled:self];
        }
    }
}

@end
