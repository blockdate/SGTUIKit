//
//  CYLTabBarController.h
//  CYLCustomTabBarDemo
//
//  Created by 磊吴 on 15/11/20.
//  Copyright © 2015年 block. All rights reserved.
//

@import Foundation;

static NSString *const CYLTabBarItemTitle= @"tabBarItemTitle";
static NSString *const CYLTabBarItemImage= @"tabBarItemImage";
static NSString *const CYLTabBarItemSelectedImage= @"tabBarItemSelectedImage";

extern NSUInteger CYLTabbarItemsCount;

#import <UIKit/UIKit.h>

@interface CYLTabBarController : UITabBarController

/**
 * An array of the root view controllers displayed by the tab bar interface.
 */
@property (nonatomic, readwrite, copy) IBOutletCollection(UIViewController) NSArray *viewControllers;
/**
 * The Attributes of items which is displayed on the tab bar.
 */
@property (nonatomic, readwrite, copy) IBOutletCollection(NSDictionary) NSArray *tabBarItemsAttributes;

@end

@interface UIViewController (CYLTabBarController)

/**
 * The nearest ancestor in the view controller hierarchy that is a tab bar controller. (read-only)
 */
@property(nonatomic, readonly) CYLTabBarController *cyl_tabBarController;

@end
