//
//  CPTextViewPlaceholder.h
//  Cassius Pacheco
//
//  Created by Cassius Pacheco on 30/01/13.
//  Copyright (c) 2013 Cassius Pacheco. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSignal;
@interface CPTextViewPlaceholder : UIView

/**
 *  是否密文显示
 */
@property (nonatomic, assign) BOOL showSecret;
/**
 *  是否能粘贴复制
 */
@property (nonatomic, assign) BOOL canCopyPaste;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIView *inputView;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, assign) UIEdgeInsets textContainerInset;
@property (nonatomic, assign) BOOL editable;
@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *tintColor;
- (RACSignal *) rac_textSignal;


@end
