//
//  SGTPageSliderView.m
//  YiDang
//
//  Created by 磊吴 on 15/10/8.
//  Copyright © 2015年 block. All rights reserved.
//

#import "SGTPageSliderView.h"
#import "SGTGlobalDefine.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface SGTPageSliderView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, copy) NSArray *imageUrlArray;

@end

@implementation SGTPageSliderView

- (instancetype)init
{
    
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSInteger count = self.imageUrlArray?self.imageUrlArray.count:0;
    self.scrollView.contentSize = CGSizeMake(ScreenWidth*count, self.frame.size.height);
    for (NSInteger i = 0; i<count; i++) {
        UIView *view = self.scrollView.subviews[i];
        view.frame = CGRectMake(ScreenWidth*i, 0, ScreenWidth, self.scrollView.frame.size.height);
    }
}

#pragma mark - UI

- (void)setupUI {
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    [self layoutMasonry];
    self.backgroundColor = [UIColor whiteColor];
    [self setupImages:@[@"",@"",@""]];
}

- (void)layoutMasonry {
    UIView *superView = self;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView.mas_centerX);
        make.bottom.equalTo(superView.mas_bottom);
    }];
    
}

- (void)bindViewModel {
    
}

- (void)setupImages:(NSArray *)imageUrls {
    NSAssert(imageUrls, @"imageurls should't be nil");
    NSInteger count = imageUrls.count;
    if (count==0) {
        return;
    }
    self.imageUrlArray = imageUrls;
    [self.pageControl setNumberOfPages:imageUrls.count];
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }

    for (NSInteger i = 0; i<count; i++) {
        NSString *url = self.imageUrlArray[i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*i, 0, ScreenWidth, self.scrollView.frame.size.height)];
        imageView.tag = i;
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taped:)];
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;


        NSURL *n = [NSURL URLWithString:url relativeToURL:[NSURL URLWithString:@"http://182.92.85.57/"]];
        [imageView sd_setImageWithURL:n placeholderImage:[UIImage imageNamed:@"Default-568h"]];
        [self.scrollView addSubview:imageView];
    }
}

#pragma mark - Action

- (void)taped:(UIGestureRecognizer *)tapGesture {
    NSInteger index = tapGesture.view.tag;
    if (_delegate && [_delegate respondsToSelector:@selector(sgtPageSlider:tapedAtIndex:)]) {
        [_delegate sgtPageSlider:self tapedAtIndex:index];
    }
}

- (void)pageControlDidSelecte:(UIPageControl *)pageControl {
    NSInteger index = pageControl.currentPage;
    CGPoint offset = CGPointMake(index*ScreenWidth, 0);
    [self.scrollView setContentOffset:offset];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x/ScreenWidth;
    [self.pageControl setCurrentPage:index];
}

#pragma mark - Getter

- (UIScrollView *)scrollView {
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (nil == _pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        [_pageControl addTarget:self action:@selector(pageControlDidSelecte:) forControlEvents:UIControlEventValueChanged];
        _pageControl.currentPageIndicatorTintColor = SystemColor;
    }
    return _pageControl;
}

@end
