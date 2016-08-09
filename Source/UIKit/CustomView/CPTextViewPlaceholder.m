//
//  CPTextViewPlaceholder.m
//  Cassius Pacheco
//
//  Created by Cassius Pacheco on 30/01/13.
//  Copyright (c) 2013 Cassius Pacheco. All rights reserved.
//

#import "CPTextViewPlaceholder.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "Masonry.h"

@interface SGTPlaceHolderTextView : UITextView
@property(nonatomic, copy) NSString *placeholder;

@property (nonatomic) UITextAutocorrectionType originalCorrection;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, getter = isUsingPlaceholder) BOOL usingPlaceholder;
@property (nonatomic ,assign) BOOL canCopyPaste;
@end

@interface SGTSecretTextField : UITextField
@property (nonatomic ,assign) BOOL canCopyPaste;
@end

@interface CPTextViewPlaceholder()<UITextViewDelegate>

@property (nonatomic) UITextAutocorrectionType originalCorrection;
@property (nonatomic, strong) UIColor *placeholderColor;
//@property (nonatomic, strong) UIColor *originalTextColor;
//@property (nonatomic, strong) NSString *lastText;
//@property (nonatomic, getter = isUsingPlaceholder) BOOL usingPlaceholder;
//@property (nonatomic, getter = isSettingPlaceholder) BOOL settingPlaceholder;
//@property (nonatomic, strong) UIView *textSelectionView; // 光标
//
//@property (nonatomic, assign) CGFloat strWidth;// 字符串宽度
@property (nonatomic, strong) SGTPlaceHolderTextView *inner_textView;
@property (nonatomic, strong) UITextField *inner_textField;
@property (nonatomic, assign) UIEdgeInsets inner_textField_Insets;


@end

@implementation CPTextViewPlaceholder

- (id)currentInputView{
    
    return self.showSecret ? _inner_textField : _inner_textView;
}
#pragma mark 初始化
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _text = @"";
    _showSecret = false;
    _inner_textView = [SGTPlaceHolderTextView new];
    [self addSubview:_inner_textView];
    [_inner_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
//    self.backgroundColor = [UIColor redColor];
    
    _inner_textField = [[UITextField alloc] init];
    _inner_textField.borderStyle = UITextBorderStyleNone;
    [self addSubview:_inner_textField];
    [_inner_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.centerY.equalTo(self);
    }];
    @weakify(self)
    [_inner_textView.rac_textSignal subscribeNext:^(NSString *text) {
        @strongify(self)
//        if (self != nil) {
//            [self textViewDidChange:text];
//        }
        self.text = text;
    }];
    
    [_inner_textField.rac_textSignal subscribeNext:^(NSString *text) {
        @strongify(self)
        self.text = text;
    }];
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    [_inner_textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.height.centerY.equalTo(self);
        make.width.equalTo(@(w));
    }];
}

#pragma mark 响应
- (BOOL)becomeFirstResponder {
    return [[self currentInputView] becomeFirstResponder];
}

-(BOOL)resignFirstResponder {
    return [[self currentInputView] resignFirstResponder];
}




//- (void)textViewDidChange:(NSString *)text { // text用户实际输入
//    if (text.length > self.text.length) {
//        NSString *extStr = [text substringWithRange:NSMakeRange(self.text.length, text.length-self.text.length)];
//        self.text = [self.text stringByAppendingString:extStr];
//    }else if (text.length < self.text.length){
//        self.text = [self.text substringToIndex:text.length];
//    }
//    NSMutableString *secretStr = [NSMutableString string];
//    for(NSInteger i = 0; i < text.length; i++) {
//        [secretStr appendString:@"*"];
//    }
//    _inner_textView.text =  secretStr; // _inner_textView.rac_textSignal 没有触发
//    
//    
//    //    NSLog(@"show:%@,real:%@",_inner_textView.text,self.text);
//    
//}

#pragma mark 属性设置
- (void)setShowSecret:(BOOL)showSecret {
    _showSecret = showSecret;
    if (showSecret){ // 密文输入
        _inner_textView.hidden = YES;
        _inner_textField.hidden = NO;
        _inner_textField.secureTextEntry = YES;
    }else {   //
        _inner_textField.hidden = YES;
        _inner_textView.hidden = NO;
    }
    
}

- (void)setCanCopyPaste:(BOOL)canCopyPaste {
    _canCopyPaste = canCopyPaste;
    [[self currentInputView] setValue:@(canCopyPaste) forKey:@"canCopyPaste"];
}

- (void)setPlaceholder:(NSString *)placeholder {
//    if (!_showSecret){
//        _inner_textView.placeholder = placeholder;
//    }else {
//        _inner_textField.placeholder = placeholder;
//    }
    [[self currentInputView] setValue:placeholder forKey:@"placeholder"];
}

-(void)setText:(NSString *)text{
    _text = text;
    [[self currentInputView] setValue:text forKey:@"text"];

}

- (UIView *)inputView {
    
    return [[self currentInputView] inputView];
}
- (void)setInputView:(UIView *)inputView {
    [[self currentInputView] setInputView:inputView];
    
}

- (UIFont *)font {
    if (!_showSecret){
        return _inner_textView.font;
    }else {
        return _inner_textField.font;
    }
}

- (void)setFont:(UIFont *)font {
    [[self currentInputView] setValue:font forKey:@"font"];
}



- (NSTextAlignment)textAlignment {
    if (!_showSecret){
        return _inner_textView.textAlignment;
    }else {
        return _inner_textField.textAlignment;
    }
}

-(void)setTextAlignment:(NSTextAlignment)textAlignment{
    [[self currentInputView] setValue:@(textAlignment) forKey:@"textAlignment"];
}

- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset {
    _inner_textView.textContainerInset = textContainerInset;
    [_inner_textField setValue:[NSNumber numberWithInt:textContainerInset.top] forKey:@"_paddingTop"];
    [_inner_textField setValue:[NSNumber numberWithInt:textContainerInset.left] forKey:@"_paddingLeft"];
    [_inner_textField setValue:[NSNumber numberWithInt:textContainerInset.bottom] forKey:@"_paddingBottom"];
    [_inner_textField setValue:[NSNumber numberWithInt:textContainerInset.right] forKey:@"_paddingRight"];
    _inner_textField_Insets = textContainerInset;
}

-(UIEdgeInsets)textContainerInset {
    if (!_showSecret){
        return _inner_textView.textContainerInset;
    }else {
        return _inner_textField_Insets;
    }
}

- (void)setEditable:(BOOL)editable {
    _inner_textView.editable = editable;
    _inner_textField.enabled = editable;
    
}

- (BOOL)editable {
    if (!_showSecret){
        return _inner_textView.editable;
    }else {
        return _inner_textField.enabled;
    }
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType {
    
    [[self currentInputView] setValue:@(keyboardType) forKeyPath:@"keyboardType"];
}

- (UIKeyboardType)keyboardType {
    if (!_showSecret){
        return _inner_textView.keyboardType;
    }else {
        return _inner_textField.keyboardType;
    }
    
}

- (void)setTextColor:(UIColor *)textColor {
    [[self currentInputView] setValue:textColor forKeyPath:@"textColor"];

}

- (UIColor *)textColor {
    if(!_showSecret){
        return  _inner_textView.textColor;
    }else {
        return _inner_textField.textColor;
    }
}

- (void)setTintColor:(UIColor *)tintColor {
    [[self currentInputView] setValue:tintColor forKeyPath:@"tintColor"];

}

- (UIColor *)tintColor {
    if(!_showSecret){
        return _inner_textView.tintColor;
    }else {
        return _inner_textField.tintColor;
    }
}


- (RACSignal *)rac_textSignal {
    return RACObserve(self, text);
}






//- (void)drawRect:(CGRect)rect {
//    if (_usingPlaceholder && self.placeholder != nil) {
////        _inner_textView.alpha = 0;
//        
//        UIFont *font = self.font != nil ? self.font : [UIFont systemFontOfSize:13];
//        [self.placeholder drawInRect:CGRectMake(5, 7, rect.size.width, rect.size.height) withAttributes:@{NSForegroundColorAttributeName:_placeholderColor,NSFontAttributeName:font}];
//    }else {
////        _inner_textView.alpha = 1;
//    }
//}


//
//#pragma mark -
//#pragma mark Life Cycle method
//
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super initWithCoder:aDecoder]) {
//        [self initialize];
//        //        self.originalTextColor = super.textColor;
//        
////        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBeginEditing) name:UITextViewTextDidBeginEditingNotification object:nil];
////        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEndEditing) name:UITextViewTextDidEndEditingNotification object:nil];
////        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
//    }
//    
//    return self;
//}
//
//- (instancetype)initWithFrame:(CGRect)frame {
//    if (self = [super initWithFrame:frame]) {
//        [self initialize];
////        self.originalTextColor = super.textColor;
//        
////        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBeginEditing) name:UITextViewTextDidBeginEditingNotification object:nil];
////        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEndEditing) name:UITextViewTextDidEndEditingNotification object:nil];
////        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
//    }
//    return self;
//}
//
//
//- (void)initialize {
//    self.placeholderColor = [UIColor lightGrayColor];
//    self.originalCorrection = self.autocorrectionType;
//    
////    self.textSelectionView = [[UIView alloc] init];
////    self.textSelectionView.backgroundColor = [UIColor blackColor];
////    self.textSelectionView.hidden = YES;
////    [self addSubview:_textSelectionView];
////    [self bringSubviewToFront:_textSelectionView];
//    
//    RAC(self,usingPlaceholder) = [[RACSignal merge:@[self.rac_textSignal, RACObserve(self, text)]] map:^id(NSString *value) {
//        if(value ==nil || value.length == 0 ) {
//            return @(YES);
//        }else {
//            return @(NO);
//        }
//    }];
//    @weakify(self)
//    
//    [[RACSignal merge:@[self.rac_textSignal,RACObserve(self, usingPlaceholder),RACObserve(self, placeholder)]] subscribeNext:^(id x) {
//        @strongify(self)
//        [self setNeedsDisplay];
//    }];
//
//}
//
////- (void)layoutSubviews {
////    [super layoutSubviews];
////    CGRect rect = self.textSelectionView.frame;
////    rect.origin.x = 5 + self.strWidth;
////    rect.origin.y = 5;
////    rect.size.width = 2;
////    rect.size.height = self.frame.size.height - 10;
////    self.textSelectionView.frame = rect;
////}
//
//- (void)dealloc
//{
////    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidBeginEditingNotification object:self];
////    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidEndEditingNotification object:self];
////    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
//}
////
////- (void)layoutSubviews
////{
////    [super layoutSubviews];
////    
////    //Fixes iOS 5.x cursor when becomeFirstResponder
////    if ([UIDevice currentDevice].systemVersion.floatValue < 6.000000) {
////        if (self.isUsingPlaceholder && self.isFirstResponder) {
////            self.text = @"";
////        }
////    }
////}
////
////- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
////{
////    if (self.isUsingPlaceholder && action != @selector(paste:)) {
////        return NO;
////    }
////    
////    return [super canPerformAction:action withSender:sender];
////}
////
////#pragma mark -
////#pragma mark Notifications
////- (void)didEndEditing
////{
////    if (self.text.length == 0) {
////        [self setupPlaceholder];
////    }
////    [self setNeedsDisplay];
////}
////
////- (void)textDidChange:(NSNotification *)notification
////{
////    
////    if (self.text.length == 0) {
////        [self setupPlaceholder];
////        return;
////    }
////    
////    if (self.isUsingPlaceholder) {
////        self.usingPlaceholder = NO;
////    }
////    [self setNeedsDisplay];
////}
////
////#pragma mark - Getters and Setters
////
////- (void)setFont:(UIFont *)font {
////    [super setFont:font];
////    [self setNeedsDisplay];
////}
////
////- (void)setAutocorrectionType:(UITextAutocorrectionType)autocorrectionType
////{
////    [super setAutocorrectionType:autocorrectionType];
////    self.originalCorrection = autocorrectionType;
////}
//
////- (void)setPlaceholder:(NSString *)placeholder
////{
////    _placeholder = placeholder;
////    
//////    if (self.isUsingPlaceholder || self.text.length == 0) {
//////        [self setupPlaceholder];
//////    }
////}
//
//#pragma mark -
//#pragma mark Utilities methods
//
////- (void)setupPlaceholder
////{
////    super.autocorrectionType = UITextAutocorrectionTypeNo;
////    self.usingPlaceholder = YES;
////    [self setNeedsDisplay];
////}
//
////- (BOOL)becomeFirstResponder {
//////    if (_textSelectionView.superview == nil){
//////        [self addSubview:_textSelectionView];
//////        [self bringSubviewToFront:_textSelectionView];
//////    }
//////    
//////    [_textSelectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
//////        make.left.equalTo(self).offset(self.textContainerInset.left + self.strWidth);
//////    }];
//////    [self layoutIfNeeded];
////
////    return [super becomeFirstResponder];
////}
//
////- (BOOL)resignFirstResponder {
////    self.textSelectionView.hidden = YES;
////    return [super resignFirstResponder];
////}
////
////- (BOOL)becomeFirstResponder {
////    self.textSelectionView.hidden = NO;
////    return [super becomeFirstResponder];
////}
//
//- (void)drawRect:(CGRect)rect {
////    _textSelectionView.hidden = YES;
//    if (!_showSecret){
////        [super drawRect:rect];
//        //    NSLog(@"draw placeholder:%@,%@",_placeholder,@(_usingPlaceholder));
//        if (_usingPlaceholder && self.placeholder != nil) {
//            UIFont *font = self.font != nil ? self.font : [UIFont systemFontOfSize:13];
//            [self.placeholder drawInRect:CGRectMake(5, 7, rect.size.width, rect.size.height) withAttributes:@{NSForegroundColorAttributeName:_placeholderColor,NSFontAttributeName:font}];
//        }
//    }else {
////        if (_usingPlaceholder && self.placeholder != nil) {
////            UIFont *font = self.font != nil ? self.font : [UIFont systemFontOfSize:13];
////            [self.placeholder drawInRect:CGRectMake(5, 7, rect.size.width, rect.size.height) withAttributes:@{NSForegroundColorAttributeName:_placeholderColor,NSFontAttributeName:font}];
////        }else {
////            _textSelectionView.hidden = NO;
////            for (UIView* a in self.subviews) {
////                if ([a isKindOfClass:NSClassFromString(@"_UITextContainerView")]){
////                    a.hidden = YES;
////                }
////            }
////            CGSize strSize = [self.text sizeWithFont:self.font andMaxSize:rect.size];
////            NSMutableString *secret = [[NSMutableString alloc] init];
////            self.strWidth = strSize.width;
////            NSInteger length = self.text.length;
////            for (int i = 0; i < length; i++) {
////                [secret appendString:@"*"];
////            }
////            [secret drawInRect:CGRectMake(5, 7, strSize.width, strSize.height) withAttributes:@{NSForegroundColorAttributeName:self.textColor,NSFontAttributeName:self.font}];
////            NSLog(@"size.width:%f",rect.size.width);
////            NSLog(NSStringFromCGRect(self.textSelectionView.frame));
////            [self layoutSubviews];
////            
////        
////        }
//    }
//
//}


@end



@implementation SGTPlaceHolderTextView

#pragma mark -
#pragma mark Life Cycle method

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
        //        self.originalTextColor = super.textColor;
        
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBeginEditing) name:UITextViewTextDidBeginEditingNotification object:nil];
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEndEditing) name:UITextViewTextDidEndEditingNotification object:nil];
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
        //        self.originalTextColor = super.textColor;
        
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBeginEditing) name:UITextViewTextDidBeginEditingNotification object:nil];
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEndEditing) name:UITextViewTextDidEndEditingNotification object:nil];
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}


- (void)initialize {
    self.placeholderColor = [UIColor lightGrayColor];
//    self.originalCorrection = self.autocorrectionType;
    
    //    self.textSelectionView = [[UIView alloc] init];
    //    self.textSelectionView.backgroundColor = [UIColor blackColor];
    //    self.textSelectionView.hidden = YES;
    //    [self addSubview:_textSelectionView];
    //    [self bringSubviewToFront:_textSelectionView];
    
    RAC(self,usingPlaceholder) = [[RACSignal merge:@[self.rac_textSignal, RACObserve(self, text)]] map:^id(NSString *value) {
        if(value ==nil || value.length == 0 ) {
            return @(YES);
        }else {
            return @(NO);
        }
    }];
    @weakify(self)
    
    [[RACSignal merge:@[self.rac_textSignal,RACObserve(self, usingPlaceholder),RACObserve(self, placeholder)]] subscribeNext:^(id x) {
        @strongify(self)
        [self setNeedsDisplay];
    }];
    
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (!_canCopyPaste){
        if (action == @selector(copy:) || action == @selector(paste:)) {
            return NO;
        }
        return YES;
    }else {
        return YES;
    }
}


- (void)drawRect:(CGRect)rect {
//    _textSelectionView.hidden = YES;
//    if (!_showSecret){
//        [super drawRect:rect];
        //    NSLog(@"draw placeholder:%@,%@",_placeholder,@(_usingPlaceholder));
        if (_usingPlaceholder && self.placeholder != nil) {
            UIFont *font = self.font != nil ? self.font : [UIFont systemFontOfSize:13];
            [self.placeholder drawInRect:CGRectMake(5, 7, rect.size.width, rect.size.height) withAttributes:@{NSForegroundColorAttributeName:_placeholderColor,NSFontAttributeName:font}];
        }
}


@end

@implementation SGTSecretTextField

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (!_canCopyPaste){
        if (action == @selector(copy:) || action == @selector(paste:)) {
            return NO;
        }
        return YES;
    }else {
        return YES;
    }
}

@end