//
//  JMDatFaultToleranceHelper.m
//  BottomPrinciple
//
//  Created by 123 on 2018/10/25.
//  Copyright © 2018年 JM. All rights reserved.
//

#import "JMDataFaultToleranceHelper.h"
#import <objc/runtime.h>

@implementation JMDataFaultToleranceHelper
+ (void)jm_swizzleInstanceMethod:(SEL)originSelector
                     withMethod:(SEL)swizzledSelector
                      withClass:(Class)targetClass{
    Method originalMethod = class_getInstanceMethod(targetClass, originSelector);
    Method swizzledMethod = class_getInstanceMethod(targetClass, swizzledSelector);
    
    BOOL exist = !class_addMethod(targetClass, originSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    
    if (exist) {
        //__NSPlaceHolderDictionary
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }else{
        //__dictionary0 __dictionaryI
        //Replaces the implementation of a method for a given class.
        class_replaceMethod(targetClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
}

+ (void)jm_swizzleClassMethod:(SEL)originSelector
                  withMethod:(SEL)swizzledSelector
                   withClass:(Class)targetClass{
    Method originalMethod = class_getClassMethod(targetClass, originSelector);
    Method swizzledMethod = class_getClassMethod(targetClass, swizzledSelector);
    
    BOOL exist = !class_addMethod(targetClass, originSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (exist) {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }else{
        //Replaces the implementation of a method for a given class.
        class_replaceMethod(targetClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
}


/**
 *  发生异常处理
 *
 *  @param msg      异常信息
 */
+ (void)handleExceptionWithExceptionMsg:(NSString *)msg{
    //想处理的操作
    JMLog(@"Error:%@",msg);
}
@end
