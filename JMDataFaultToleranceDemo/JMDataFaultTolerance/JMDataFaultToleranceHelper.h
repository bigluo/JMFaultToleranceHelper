//
//  JMDatFaultToleranceHelper.h
//  BottomPrinciple
//
//  Created by 123 on 2018/10/25.
//  Copyright © 2018年 JM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


#ifdef DEBUG
static BOOL JM_DebugMode = NO;
#define JMLog(fmt, ...) NSLog((@"\n%s [Line %d]\nlog:" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
static BOOL JM_DebugMode = NO;
#define JMLog(...)
#endif

typedef NS_ENUM(NSUInteger,JMDataFaultType){
    JMDataFaultTypeDefault,
};


@interface JMDataFaultToleranceHelper : NSObject
/**
 *  交换类方法
 *
 *  @param originSelector      原始方法名
 *  @param swizzledSelector    要交换的方法名
 *  @param targetClass         交换方法的类
 */
+ (void)jm_swizzleClassMethod:(SEL)originSelector
                  withMethod:(SEL)swizzledSelector
                   withClass:(Class)targetClass;

/**
 *  交换对象方法
 *
 *  @param originSelector      原始方法名
 *  @param swizzledSelector    要交换的方法名
 *  @param targetClass         交换方法的类
 */
+ (void)jm_swizzleInstanceMethod:(SEL)originSelector
                     withMethod:(SEL)swizzledSelector
                      withClass:(Class)targetClass;
/**
 *  发生异常处理
 *
 *  @param msg      异常信息
 */
+ (void)handleExceptionWithExceptionMsg:(NSString *)msg;
@end

NS_ASSUME_NONNULL_END
