//
//  SGTPageSliderView.h
//  YiDang
//
//  Created by 磊吴 on 15/10/8.
//  Copyright © 2015年 block. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SGTPageSliderView;
@protocol SGTPageSliderDelegate <NSObject>

- (void)sgtPageSlider:(SGTPageSliderView *)slider tapedAtIndex:(NSInteger)index;

@end

@interface SGTPageSliderView : UIView

@property (nonatomic, weak) id<SGTPageSliderDelegate>delegate;

- (void)setupImages:(NSArray *)imageUrls;

@end
