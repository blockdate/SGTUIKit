//
//  NSObject+DHF.h
//  FreeApp
//
//  Created by leisure on 14-6-10.
//  Copyright (c) 2014年 leisure. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DHF)
-(NSDictionary *)propertyList:(BOOL)isWrite;
- (NSDictionary *)toDictionary;
-(NSDictionary *)propertyList:(BOOL)isWrite depth:(NSInteger)depth;
@end





