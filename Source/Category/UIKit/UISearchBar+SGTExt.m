//
//  UISearchBar+UITool.m
//  SGTFoundation
//
//  Created by 磊吴 on 15/12/21.
//  Copyright © 2015年 block. All rights reserved.
//

#import "UISearchBar+SGTExt.h"

@implementation UISearchBar (SGTExt)

- (void) setCancelTitle:(NSString *)title {
    for (UIView *view in [[self.subviews lastObject] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancelBtn = (UIButton *)view;
            [cancelBtn setTitle:title forState:UIControlStateNormal];
        }
    }
}

@end
