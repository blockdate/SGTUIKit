//
//  UIView+Extension.h
//  01-黑酷
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//
/** 设置自身x */
#define SGTSetX(value) self.x = value
/** 设置自身y */
#define SGTSetY(value) self.y = value
/** 设置自身centerX */
#define SGTSetCenterX(value) self.centerX = value
/** 设置自身centerY */
#define SGTSetCenterY(value) self.centerY = value
/** 设置自身center */
#define SGTSetCenter(x, y) SGTSetCenterX(x); \
SetCenterY(y)
/** 设置自身宽度 */
#define SGTSetWidth(value) self.width = value
/** 设置自身高度 */
#define SGTSetHeight(value) self.height = value
/** 设置自身尺寸 */
#define SGTSetSize(width, height) self.size = CGSizeMake(width, height)

/** 设置控件x */
#define SGTSetXForView(view, value) view.x = value
/** 设置控件y */
#define SGTSetYForView(view, value) view.y = value
/** 设置控件centerX */
#define SGTSetCenterXForView(view, value) view.centerX = value
/** 设置控件centerY */
#define SGTSetCenterYForView(view, value) view.centerY = value
/** 设置控件center */
#define SGTSetCenterForView(view, x, y) SGTSetCenterXForView(view, x); \
SetCenterYForView(view, y);
/** 设置控件水平居中 */
#define AlignHorizontal(view) [view alignHorizontal]
/** 设置控件垂直居中 */
#define AlignVertical(view) [view alignVertical]
/** 设置控件宽度 */
#define SGTSetWidthForView(view, value) view.width = value
/** 设置控件高度 */
#define SGTSetHeightForView(view, value) view.height = value
/** 设置控件尺寸 */
#define SGTSetSizeForView(view, width, height) view.size = CGSizeMake(width, height)

/** 快速添加子控件的宏定义 */
#define AddView(Class, property) [self addSubview:[Class class] propertyName:property]
#define AddViewForView(view, Class, property) [view addSubview:[Class class] propertyName:property]

// 屏幕bounds
#define SGTScreenBounds [UIScreen mainScreen].bounds
// 屏幕的size
#define SGTScreenSize [UIScreen mainScreen].bounds.size
// 屏幕的宽度
#define SGTScreenWidth [UIScreen mainScreen].bounds.size.width
// 屏幕的高度
#define SGTScreenHeight [UIScreen mainScreen].bounds.size.height

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGSize size;
/** 水平居中 */
- (void)alignHorizontal;
/** 垂直居中 */
- (void)alignVertical;
/** 添加子控件 */
- (void)addSubview:(Class)class propertyName:(NSString *)propertyName;
@end
