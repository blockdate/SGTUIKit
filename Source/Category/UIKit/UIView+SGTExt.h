//
//  UIView+SGTExt.h
//  SGTFoundation
//
//  Created by 磊吴 on 16/5/19.
//  Copyright © 2016年 block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SGTExt)

@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
//@property (nonatomic) CGPoint origin;      ///< Shortcut for frame.origin.
//@property (nonatomic) CGSize  size;        ///< Shortcut for frame.size.

@end
