//
//  YUDIVView.h
//  YUANBAOAPP
//
//  Created by yxy on 14-8-25.
//  Copyright (c) 2014年 ATAW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YUDIVView : UIView
{
    float _marginRight;
    float _marginTop;
    
 
    
}
@property(strong,nonatomic)  NSMutableArray * viewsArray;

@property(assign,nonatomic) float yFianlMaxBottomY;

//-(void)setMargin:(float) margin ;
-(void)setViews:(NSArray *)views marginRight:(float) marginRight marginTop:(float) marginTop paddingLeft:(float) paddingLeft;



@end

