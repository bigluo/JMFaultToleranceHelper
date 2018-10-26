//
//  NSArray+JMDataFaultTolerance.m
//  BottomPrinciple
//
//  Created by 123 on 2018/10/25.
//  Copyright © 2018年 JM. All rights reserved.
//

#import "NSArray+JMDataFaultTolerance.h"
#import "JMDataFaultToleranceHelper.h"

@implementation NSArray (JMDataFaultTolerance)
+ (void)load{
    
    if(JM_DebugMode){
        return;
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class targetClass = NSClassFromString(@"__NSArrayI");
        
        [JMDataFaultToleranceHelper jm_swizzleInstanceMethod:@selector(objectAtIndex:) withMethod:@selector(jm_objectAtIndex:) withClass:targetClass];
        
        [JMDataFaultToleranceHelper jm_swizzleInstanceMethod:@selector(objectAtIndexedSubscript:) withMethod:@selector(jm_objectAtIndexedSubscript:) withClass:targetClass];
        
        [JMDataFaultToleranceHelper jm_swizzleInstanceMethod:@selector(initWithObjects:count:) withMethod:@selector(jm_initWithObjects:count:) withClass:NSClassFromString(@"__NSPlaceholderArray")];
    });
}


-(id)jm_objectWithIndex:(NSUInteger)index{
    return self[index];
}

- (NSString*)jm_stringWithIndex:(NSUInteger)index
{
    id value = [self jm_objectWithIndex:index];
    
    if (JM_DebugMode){
        return (NSString*)value;
    }
    
    if (value == nil || value == [NSNull null] || [[value description] isEqualToString:@"<null>"])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString*)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    
    return nil;
}

- (NSNumber*)jm_numberWithIndex:(NSUInteger)index
{
    id value = [self jm_objectWithIndex:index];
    
    if (JM_DebugMode){
        return (NSNumber*)value;
    }
    
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber*)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString*)value];
    }
    return nil;
}

- (NSArray*)jm_arrayWithIndex:(NSUInteger)index
{
    id value = [self jm_objectWithIndex:index];
    
    if (JM_DebugMode){
        return (NSArray*)value;
    }
    
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]])
    {
        return value;
    }
    return nil;
}


- (NSDictionary*)jm_dictionaryWithIndex:(NSUInteger)index
{
    id value = [self jm_objectWithIndex:index];
    
    if (JM_DebugMode){
        return (NSDictionary*)value;
    }
    
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]])
    {
        return value;
    }
    return nil;
}

- (NSInteger)jm_integerWithIndex:(NSUInteger)index
{
    id value = [self jm_objectWithIndex:index];
    
    if (JM_DebugMode){
        return [value integerValue];
    }
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value integerValue];
    }
    return 0;
}

- (BOOL)jm_boolWithIndex:(NSUInteger)index
{
    id value = [self jm_objectWithIndex:index];
    
    if (JM_DebugMode){
        return [value boolValue];
    }
    
    if (value == nil || value == [NSNull null])
    {
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value boolValue];
    }
    return NO;
}

- (float)jm_floatWithIndex:(NSUInteger)index
{
    id value = [self jm_objectWithIndex:index];
    
    if (JM_DebugMode){
        return [value floatValue];
    }
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value floatValue];
    }
    return 0;
}

- (double)jm_doubleWithIndex:(NSUInteger)index
{
    id value = [self jm_objectWithIndex:index];
    
    if (JM_DebugMode){
        return [value doubleValue];
    }
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value doubleValue];
    }
    return 0;
}


#pragma mark - swizzle Mehod
- (id)jm_objectAtIndex:(NSInteger)index{
    if (index >=0 && index < self.count) {
        return [self jm_objectAtIndex:index];
    }else{
        [JMDataFaultToleranceHelper handleExceptionWithExceptionMsg:@"[__NSArrayI objectAtIndex:] index is greater than the array.count or the index is less than zero"];
        return nil;
    }
}

- (id)jm_objectAtIndexedSubscript:(NSInteger)index{
    if (index >=0 && index < self.count) {
        return [self jm_objectAtIndex:index];
    }else{
        [JMDataFaultToleranceHelper handleExceptionWithExceptionMsg:@"[__NSArrayI objectAtIndexedSubscript:] index is greater than the array.count or the index is less than zero"];
        return nil;
    }
}

- (instancetype)jm_initWithObjects:(int **)objects count:(NSInteger)count{
    for (int i=0; i<count; i++) {
        if (!objects[i]) {
            [JMDataFaultToleranceHelper handleExceptionWithExceptionMsg:[NSString stringWithFormat:@"[__NSPlaceholderArray initWithObjects:count:]: attempt to insert nil to objects[%d]",i]];
            return nil;
        }
    }
    return [self jm_initWithObjects:objects count:count];
}


@end
