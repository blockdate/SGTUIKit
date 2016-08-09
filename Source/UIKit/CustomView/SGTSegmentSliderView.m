//
//  SGTSegmentSliderView.m
//  SGTFoundation
//
//  Created by 磊吴 on 15/12/15.
//  Copyright © 2015年 block. All rights reserved.
//

#import "SGTSegmentSliderView.h"
#import "Masonry.h"

@interface SGTSegmentSliderView()

@property (nonatomic, strong) UIView *indecatorView;
@property (nonatomic, strong) NSMutableArray<UIButton *> *segmentButtonArray;
@property (nonatomic, strong) UIView *bottomLineView;
@end

@implementation SGTSegmentSliderView

- (void) func {
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initalize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initalize];
    }
    return self;
}

- (void)initalize {
    _currentIndex = 0;
    _duration = 0.2;
    _focusColor = [UIColor redColor];
    _normalColor = [UIColor blackColor];
    _indecatorLineHeight = 2;
    _bottomLineHide = false;
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bottomLineView];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self);
        make.height.equalTo(@(0.5));
    }];
}

- (void)setTitles:(NSArray<NSString *> *)titles {
    [self.indecatorView removeFromSuperview];
    
    for (UIView *view in self.segmentButtonArray) {
        [view removeFromSuperview];
    }
    [self.segmentButtonArray removeAllObjects];
    if ([titles count] <= 0) {
        return ;
    }
    UIView *preView = nil;
    for (NSInteger i = 0; i < titles.count; i++) {
        NSString *str = titles[i];
        UIButton *btn = [self titleBtnFromTitle:str];
        btn.tag = i;
        [btn addTarget:self action:@selector(tapedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.segmentButtonArray addObject:btn];
        if (preView == nil) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.top.and.bottom.equalTo(self);
            }];
            preView = btn;
        }else {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.and.bottom.and.width.equalTo(preView);
                make.left.equalTo(preView.mas_right);
            }];
            preView = btn;
        }
        
    }
    [preView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
    }];
    [self addSubview:self.indecatorView];
    [self bringSubviewToFront:self.bottomLineView];
    
    self.currentIndex = 0 ;
}

- (void)tapedButton:(UIButton *)sender {
    NSInteger index = sender.tag;
    self.currentIndex = index;
}

- (void)setBottomLineHide:(BOOL)bottomLineHide {
    _bottomLineHide = bottomLineHide;
    self.bottomLineView.hidden = bottomLineHide;
}

- (void)setIndecatorLineHeight:(CGFloat)indecatorLineHeight {
    _indecatorLineHeight = indecatorLineHeight;
    [self.indecatorView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.indecatorLineHeight));
    }];
}

- (void)setFocusColor:(UIColor *)focusColor {
    _focusColor = focusColor;
    if(self.segmentButtonArray.count > 0) {
        UIButton *b = self.segmentButtonArray[_currentIndex];
        [b setTitleColor:focusColor forState:UIControlStateNormal];
    }
    self.indecatorView.backgroundColor = focusColor;
}

- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    if(self.segmentButtonArray.count > 0) {
        for (NSInteger i = 0 ; i<self.segmentButtonArray.count; i++) {
            if (i == _currentIndex) {
                continue;
            }
            UIButton *btn = self.segmentButtonArray[i];
            [btn setTitleColor:normalColor forState:UIControlStateNormal];
        }
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    if(self.segmentButtonArray.count > currentIndex) {
        UIButton *b = self.segmentButtonArray[_currentIndex];
        [b setTitleColor:_normalColor forState:UIControlStateNormal];
        UIButton *current = self.segmentButtonArray[currentIndex];
        [current setTitleColor:_focusColor forState:UIControlStateNormal];
        [self layoutIfNeeded];
        [self.indecatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(current.mas_centerX);
            make.width.equalTo(current.mas_width).multipliedBy(0.5);
            make.height.equalTo(@(self.indecatorLineHeight));
            make.bottom.equalTo(current.mas_bottom).offset(-0.5);
        }];
        if (_currentIndex == 0 && _currentIndex == currentIndex) {
            [self layoutIfNeeded];
        }else {
            [UIView animateWithDuration:_duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self layoutIfNeeded];
            } completion:nil];
        }
    }
    if (_delegate != nil && [_delegate respondsToSelector:@selector(segmentSliderView:didSelectedIndex:)]) {
        [_delegate segmentSliderView:self didSelectedIndex:currentIndex];
    }
    _currentIndex = currentIndex;
}

- (UIButton *)titleBtnFromTitle:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:_normalColor forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];

    
    return btn;
}

- (UIView *)bottomLineView {
    if (_bottomLineView == nil) {
        _bottomLineView = [UIView new];
        _bottomLineView.backgroundColor = [UIColor colorWithRed:0.8627 green:0.8627 blue:0.8627 alpha:1.0];
    }
    return _bottomLineView;
}

- (NSArray<UIButton *> *)segmentButtonArray {
    if (_segmentButtonArray == nil) {
        _segmentButtonArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _segmentButtonArray;
}

- (UIView *)indecatorView {
    if (_indecatorView == nil) {
        _indecatorView = [UIView new];
        _indecatorView.backgroundColor = _focusColor;
    }
    return _indecatorView;
}

@end
