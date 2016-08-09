//
//  UIWindow+YUBottomPoper.h
//  YUANBAOAPP
//
//  Created by yxy on 14/11/20.
//  Copyright (c) 2014年 ATAW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUBottomPopSelctView.h"

@interface UIWindow (YUBottomPoper)

-(void)showPopWithButtonTitles:(NSArray *)titles styles:(NSArray *)styles deledge:(id<YUBottomPopSelctViewDeledge>)deledge;

-(void)showPopWithButtonTitles:(NSArray *)titles styles:(NSArray *)styles whenButtonTouchUpInSideCallBack:(_int_type_block)callBack;


-(void)disMissPopSelectView;

@end

