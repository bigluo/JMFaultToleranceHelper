//
//  NSDictionary+JMDataFaultTolerance.m
//  BottomPrinciple
//
//  Created by 123 on 2018/10/25.
//  Copyright © 2018年 JM. All rights reserved.
//

#import "NSDictionary+JMDataFaultTolerance.h"
#import "JMDataFaultToleranceHelper.h"
@implementation NSDictionary (JMDataFaultTolerance)

+ (void)load{
    
    if (JM_DebugMode){
        return;
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //__NSDictionary0 __NSDictionaryI 
        Class targetClass = [NSDictionary class]; //NSClassFromString(@"__NSDictionaryI");
        
        [JMDataFaultToleranceHelper jm_swizzleClassMethod:@selector(dictionaryWithObject:forKey:) withMethod:@selector(jm_dictionaryWithObject:forKey:) withClass:targetClass];
        
        [JMDataFaultToleranceHelper jm_swizzleClassMethod:@selector(dictionaryWithObjectsAndKeys:) withMethod:@selector(jm_dictionaryWithObjectsAndKeys:) withClass:targetClass];
        
        [JMDataFaultToleranceHelper jm_swizzleClassMethod:@selector(dictionaryWithObjects:forKeys:) withMethod:@selector(jm_dictionaryWithObjects:forKeys:) withClass:targetClass];
        
        [JMDataFaultToleranceHelper jm_swizzleInstanceMethod:@selector(initWithObjects:forKeys:count:) withMethod:@selector(jm_initWithObjects:forKeys:count:) withClass:NSClassFromString(@"__NSPlaceholderDictionary")];
    });
    
}

#pragma mark - ForKey Method
- (NSInteger)jm_integerForKey:(id)key
{
    id value = [self objectForKey:key];
    
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

- (BOOL)jm_boolForKey:(id)key
{
    id value = [self objectForKey:key];
    
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


- (float)jm_floatForKey:(id)key
{
    id value = [self objectForKey:key];
    
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

- (double)jm_doubleForKey:(id)key
{
    id value = [self objectForKey:key];
    
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

- (long long)jm_longLongForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (JM_DebugMode){
        return [value longLongValue];
    }
    
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value longLongValue];
    }
    return 0;
}


- (NSString*)jm_stringForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (JM_DebugMode){
        return (NSString *)value;
    }
    
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([[value description] isEqualToString:@"(null)"]) {
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

- (NSNumber*)jm_numberForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (JM_DebugMode){
        return (NSNumber *)value;
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

- (NSArray*)jm_arrayForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (JM_DebugMode){
        return (NSArray *)value;
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

- (NSDictionary*)jm_dictionaryForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (JM_DebugMode){
        return (NSDictionary *)value;
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


#pragma mark - swizzle Mehod
+ (instancetype)jm_dictionaryWithObject:(id)object forKey:(id <NSCopying>)key{
    if (object) {
        if (key) {
            return [self jm_dictionaryWithObject:object forKey:key];
        }else{
            JMLog(@"[__NSDictionaryI dictionaryWithObject:forKey:] key can't be nil");
            return nil;
        }
    }else{
        JMLog(@"[__NSDictionaryI dictionaryWithObject:forKey:] object can't be nil");
        return nil;
    }
}

+ (instancetype)jm_dictionaryWithObjectsAndKeys:(id)firstObject, ...{
    NSMutableArray *objects =[NSMutableArray new];
    va_list list;
    va_start(list, firstObject);
    [objects addObject:firstObject];
    id arg = nil;
    while ((arg = va_arg(list, id))) {
        [objects addObject:arg];
    }
    va_end(list);
    if (objects.count%2 != 0) {
        JMLog(@"[__NSDictionaryI dictionaryWithObjectsAndKeys:]: second object of each pair must be non-nil");
        return nil;
    }
    id value = nil;
    id key = nil;
    NSMutableArray *values = [NSMutableArray new];
    NSMutableArray *keys = [NSMutableArray new];
    for (NSInteger i =0; i<objects.count; i++) {
        if (i%2==0) {
            value =objects[i];
            [values addObject:value];
        }else{
            key =objects[i];
            [keys addObject:key];
        }
    }
    return [self dictionaryWithObjects:[values copy] forKeys:[keys copy]];
}

+ (instancetype)jm_dictionaryWithObjects:(NSArray<id> *)objects forKeys:(NSArray<id <NSCopying>> *)keys{
    if ((objects && [objects isKindOfClass:[NSArray class]]) && (keys &&[keys isKindOfClass:[NSArray class]]) &&(objects.count ==keys.count)) {
        return [self jm_dictionaryWithObjects:objects forKeys:keys];
    }else{
        JMLog(@"[__NSdictionaryI dictionaryWithObjects:forKeys:] please check you objects and keys");
        return nil;
    }
}

- (instancetype)jm_initWithObjects:(int **)objects forKeys:(int **)keys count:(NSInteger)count{
    for (int i =0; i<count; i++) {
        if (!objects[i] || !keys[i]) {
            JMLog(@"%@", [NSString stringWithFormat:@"[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil to objects[%d]",i]);
            return nil;
        }
    }
    return [self jm_initWithObjects:objects forKeys:keys count:count];
}

@end
