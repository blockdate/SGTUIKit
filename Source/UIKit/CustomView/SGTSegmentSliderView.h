//
//  SGTSegmentSliderView.h
//  SGTFoundation
//
//  Created by 磊吴 on 15/12/15.
//  Copyright © 2015年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SGTSegmentSliderView;

@protocol SGTSegmentSliderViewDelegate <NSObject>

- (void)segmentSliderView:(SGTSegmentSliderView *)view didSelectedIndex:(NSInteger)index;

@end

@interface SGTSegmentSliderView : UIView

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, copy) UIColor *focusColor;
@property (nonatomic, copy) UIColor *normalColor;
@property (nonatomic, assign) BOOL bottomLineHide;
@property (nonatomic, assign) CGFloat indecatorLineHeight;

@property (nonatomic, weak) id<SGTSegmentSliderViewDelegate> delegate;

- (void)setTitles:(NSArray<NSString *> *)titles;

@end
