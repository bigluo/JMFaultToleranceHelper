//
//  NSMutableDictionary+JMDataFaultToerance.m
//  BottomPrinciple
//
//  Created by 123 on 2018/10/25.
//  Copyright © 2018年 JM. All rights reserved.
//

#import "NSMutableDictionary+JMDataFaultToerance.h"
#import "JMDataFaultToleranceHelper.h"
@implementation NSMutableDictionary (JMDataFaultToerance)
+ (void)load{
    
    if (JM_DebugMode) {
        return;
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class targetClass = NSClassFromString(@"__NSDictionaryM");
       
        [JMDataFaultToleranceHelper jm_swizzleInstanceMethod:@selector(setObject:forKey:) withMethod:@selector(jm_setObject:forKey:) withClass:targetClass];
      
        [JMDataFaultToleranceHelper jm_swizzleInstanceMethod:@selector(removeObjectForKey:) withMethod:@selector(jm_removeObjectForKey:) withClass:targetClass];
        
    });
}

- (void)jm_setObject:(id)object forKey:(NSString *)key{
    if (![key isKindOfClass:[NSString class]]) {
        [JMDataFaultToleranceHelper handleExceptionWithExceptionMsg:@"NSMutableDictionary setObject:forKey: param Key is invalid"];
    }
    if (object) {
        [self jm_setObject:object forKey:key];
    }else{
         [JMDataFaultToleranceHelper handleExceptionWithExceptionMsg:@"NSMutableDictionary setObject:forKey: param object is nil"];
    }
    
    
}


- (void)jm_removeObjectForKey:(NSString *)key{
    
}

@end
