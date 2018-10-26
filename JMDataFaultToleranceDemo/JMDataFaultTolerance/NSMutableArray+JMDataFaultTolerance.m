//
//  NSMutableArray+JMDataFaultTolerance.m
//  BottomPrinciple
//
//  Created by 123 on 2018/10/25.
//  Copyright © 2018年 JM. All rights reserved.
//

#import "NSMutableArray+JMDataFaultTolerance.h"
#import "JMDataFaultToleranceHelper.h"
@implementation NSMutableArray (JMDataFaultTolerance)

+ (void)load{
    
    if (JM_DebugMode) {
        return;
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class targetClass = NSClassFromString(@"__NSArrayM");
        
        [JMDataFaultToleranceHelper jm_swizzleInstanceMethod:@selector(objectAtIndex:) withMethod:@selector(jm_objectAtIndex:) withClass:targetClass];
        
        [JMDataFaultToleranceHelper jm_swizzleInstanceMethod:@selector(objectAtIndexedSubscript:) withMethod:@selector(jm_objectAtIndexedSubscript:) withClass:targetClass];
        
        [JMDataFaultToleranceHelper jm_swizzleInstanceMethod:@selector(addObject:) withMethod:@selector(jm_addObject:) withClass:targetClass];
        
        [JMDataFaultToleranceHelper jm_swizzleInstanceMethod:@selector(insertObject:atIndex:) withMethod:@selector(jm_insertObject:atIndex:) withClass:targetClass];
        
        [JMDataFaultToleranceHelper jm_swizzleInstanceMethod:@selector(removeObjectAtIndex:) withMethod:@selector(jm_removeObjectAtIndex:) withClass:targetClass];
        
        [JMDataFaultToleranceHelper jm_swizzleInstanceMethod:@selector(replaceObjectAtIndex:withObject:) withMethod:@selector(jm_replaceObjectAtIndex:withObject:) withClass:targetClass];
        
    });
}



#pragma mark - swizzle Mehod
- (id)jm_objectAtIndex:(NSInteger)index{
    if (index >=0 && index < self.count) {
        return [self jm_objectAtIndex:index];
    }else{
        [JMDataFaultToleranceHelper handleExceptionWithExceptionMsg:@"[__NSArrayM objectAtIndex:]  index is greater than the mutableArray.count or the index is less than zero"];
        return nil;
    }
}

- (id)jm_objectAtIndexedSubscript:(NSInteger)index{
    if (index >=0 && index < self.count) {
        return [self jm_objectAtIndex:index];
    }else{
        [JMDataFaultToleranceHelper handleExceptionWithExceptionMsg:@"[__NSArrayM objectAtIndexedSubscript:] index is greater than the array.count or the index is less than zero"];
        return nil;
    }
}

- (void)jm_addObject:(id)object{
    if (object) {
        [self jm_addObject:object];
    }else{
         [JMDataFaultToleranceHelper handleExceptionWithExceptionMsg:@"[__NSArrayM addObject:] object will be added can't be nil"];
    }
}

- (void)jm_insertObject:(id)anObject atIndex:(NSUInteger)index{
    if (index <= self.count) {
        if (anObject) {
            [self jm_insertObject:anObject atIndex:index];
        }else{
            [JMDataFaultToleranceHelper handleExceptionWithExceptionMsg:@"[__NSArrayM insertObject:atIndex:] object can't be nil"];
        }
    }else{
        [JMDataFaultToleranceHelper handleExceptionWithExceptionMsg:@"the  index is greater than the mutableArray.count or the index is less than zero"];
    }
}

- (void)jm_removeObjectAtIndex:(NSUInteger)index{
    if (index < self.count) {
        [self jm_removeObjectAtIndex:index];
    }else{
        [JMDataFaultToleranceHelper handleExceptionWithExceptionMsg:@"the  index is greater than the mutableArray.count or the index is less than zero"];
    }
}

- (void)jm_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject{
    if (index < self.count) {
        if (anObject) {
            [self jm_replaceObjectAtIndex:index withObject:anObject];
        }else{
            [JMDataFaultToleranceHelper handleExceptionWithExceptionMsg:@"[__NSArrayM replaceObjectAtIndex:withObject:]: object cannot be nil'"];
        }
    }else{
        [JMDataFaultToleranceHelper handleExceptionWithExceptionMsg:@"the  index is greater than the mutableArray.count or the index is less than zero"];
    }
}

@end
