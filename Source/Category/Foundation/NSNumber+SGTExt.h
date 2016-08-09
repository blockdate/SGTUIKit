//
//  NSNumber+SGTExt.h
//  SGTFoundation
//
//  Created by 磊吴 on 16/5/19.
//  Copyright © 2016年 block. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSNumber (SGTExt)

/**
 Creates and returns an NSNumber object from a string.
 Valid format: @"12", @"12.345", @" -0xFF", @" .23e99 "...
 
 @param string  The string described an number.
 
 @return an NSNumber when parse succeed, or nil if an error occurs.
 */
+ (nullable NSNumber *)numberWithString:(NSString *)string;

@end
NS_ASSUME_NONNULL_END