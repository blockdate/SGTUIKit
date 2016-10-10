//
//  RACNSubject.h
//  Pods
//
//  Created by 磊吴 on 16/5/23.
//
//

#import <ReactiveObjC/ReactiveObjC.h>

/**
 @author block, 16-05-23 16:05:24
 
 @brief 这是一个永远不会发送complete的信号
 */
@interface RACNSubject : RACSignal <RACSubscriber>

+ (instancetype)subject;

@end
