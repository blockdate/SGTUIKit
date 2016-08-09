//
//  NSMutableAttributedString+ColorString.h
//  JongJong
//
//  Created by 磊吴 on 15/6/3.
//  Copyright (c) 2015年 磊吴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (ColorString)

+ (NSMutableAttributedString *)mutableStringWithStrings:(NSArray *)strArray colors:(NSArray *)colorArray;

+ (NSMutableAttributedString *)mutableStringWithStrings:(NSArray *)strArray colors:(NSArray *)colorArray fonts:(NSArray *)fonts;

@end
