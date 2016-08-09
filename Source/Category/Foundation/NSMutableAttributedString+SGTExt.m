//
//  NSMutableAttributedString+ColorString.m
//  JongJong
//
//  Created by 磊吴 on 15/6/3.
//  Copyright (c) 2015年 磊吴. All rights reserved.
//

#import "NSMutableAttributedString+SGTExt.h"
#import <UIKit/UIKit.h>

@implementation NSMutableAttributedString (ColorString)

+ (NSMutableAttributedString *)mutableStringWithStrings:(NSArray *)strArray colors:(NSArray *)colorArray {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] init];
    for (NSInteger i = 0; i<strArray.count; i++) {
        NSString *valueStr = [strArray objectAtIndex:i];
        UIColor *color = [colorArray objectAtIndex:i];
        NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:valueStr attributes:@{NSForegroundColorAttributeName:color}];
        [str appendAttributedString:attStr];
    }
    return str;
}

+ (NSMutableAttributedString *)mutableStringWithStrings:(NSArray *)strArray colors:(NSArray *)colorArray fonts:(NSArray *)fonts {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] init];
    for (NSInteger i = 0; i<strArray.count; i++) {
        NSString *valueStr = [strArray objectAtIndex:i];
        UIColor *color = [colorArray objectAtIndex:i];
        UIFont *font = [fonts objectAtIndex:i];
        NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:valueStr attributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font}];
        [str appendAttributedString:attStr];
    }
    return str;
}

@end
