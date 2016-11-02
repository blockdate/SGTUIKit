//
//  UINavigationBar+BackgroundColor.m
//  YiDang-OC
//
//  Created by 磊吴 on 15/11/20.
//  Copyright © 2015年 block. All rights reserved.
//

#import "UINavigationBar+SGTExt.h"
#import <objc/runtime.h>
#import "SGTGlobalDefine.h"
#import "UIImage+SGTExt.h"

@implementation UINavigationBar (BackgroundColor)
//static char overlayKey;

//- (UIView *)overlay
//{
//    return objc_getAssociatedObject(self, &overlayKey);
//}
//
//- (void)setOverlay:(UIView *)overlay
//{
//    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}

- (void)lt_setBackgroundColor:(UIColor *)backgroundColor
{
    [self setBackgroundImage:[UIImage imageFromColor:backgroundColor size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 64)] forBarMetrics:UIBarMetricsDefault];
}

- (void)lt_setbottomLineHide:(BOOL)hide {
    if ([self respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=hide;
                    }
                }
            }
        }
    }
}

@end
