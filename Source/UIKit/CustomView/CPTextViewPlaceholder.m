//
//  CPTextViewPlaceholder.m
//  Cassius Pacheco
//
//  Created by Cassius Pacheco on 30/01/13.
//  Copyright (c) 2013 Cassius Pacheco. All rights reserved.
//

#import "CPTextViewPlaceholder.h"
#import <ReactiveObjC/ReactiveObjC.h>
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
@property (nonatomic, strong) SGTPlaceHolderTextView *inner_textView;
@property (nonatomic, strong) UITextField *inner_textField;
@property (nonatomic, assign) UIEdgeInsets inner_textField_Insets;

@end

@implementation CPTextViewPlaceholder

- (id)currentInputView{
    if (_inputLines <= 1) {
        return _inner_textField;
    }
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
    [self initializeView];
    _text = @"";
    _showSecret = false;
    
    self.inputLines = 1;
}

- (void)initializeView {
    _inner_textView = [SGTPlaceHolderTextView new];
    _inner_textView.contentMode = UIViewContentModeCenter;
    [self addSubview:_inner_textView];
    [_inner_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.height.and.centerY.and.right.equalTo(self);
    }];
    
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
    //    RACSignal *signal = [[[[RACSignal
    //         defer:^{
    //             @strongify(self);
    //             return [RACSignal return:self.inner_textField];
    //         }]
    //        concat:[self.inner_textField rac_signalForControlEvents:UIControlEventEditingChanged]]
    //       map:^(UITextField *x) {
    //           return x.text;
    //       }]
    //     takeUntil:self.rac_willDeallocSignal];
    //    [signal subscribeNext:^(NSString *text) {
    //        @strongify(self);
    ////        self.text = text;
    //    }];
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

#pragma mark 属性设置

- (void)setInputLines:(NSInteger)inputLines {
    _inputLines = inputLines;
    [self updateInputTextView];
}

- (void)setShowSecret:(BOOL)showSecret {
    _showSecret = showSecret;
    [self updateInputTextView];
}

- (void)updateInputTextView {
    if (_inputLines <= 1) {
        _inner_textView.hidden = YES;
        _inner_textField.hidden = NO;
        _inner_textField.secureTextEntry = _showSecret;
    }else {
        if (_showSecret){ // 密文输入
            _inner_textView.hidden = YES;
            _inner_textField.hidden = NO;
            _inner_textField.secureTextEntry = YES;
        }else {   //
            _inner_textField.hidden = YES;
            _inner_textView.hidden = NO;
        }
    }
}

- (void)setCanCopyPaste:(BOOL)canCopyPaste {
    _canCopyPaste = canCopyPaste;
    [[self currentInputView] setValue:@(canCopyPaste) forKey:@"canCopyPaste"];
}

- (void)setPlaceholder:(NSString *)placeholder {
    [[self currentInputView] setValue:placeholder forKey:@"placeholder"];
}

-(void)setText:(NSString *)text{
    _text = text;
}

- (void)setTextViewText:(NSString *)text {
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

@end



@implementation SGTPlaceHolderTextView

#pragma mark -
#pragma mark Life Cycle method

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
    self.placeholderColor = [UIColor lightGrayColor];
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
