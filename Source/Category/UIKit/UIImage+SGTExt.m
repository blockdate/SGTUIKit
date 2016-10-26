//
//  UIImage+SGTExt.m
//  SGTUIKit
//
//  Created by 吴磊 on 2016/10/20.
//  Copyright © 2016年 磊吴. All rights reserved.
//

#import "UIImage+SGTExt.h"

@implementation UIImage (SGTExt)

+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
