//
//  NSMutableString+JMDataFaultTolerance.m
//  BottomPrinciple
//
//  Created by 123 on 2018/10/25.
//  Copyright © 2018年 JM. All rights reserved.
//

#import "NSMutableString+JMDataFaultTolerance.h"
#import "
.h"
@implementation NSMutableString (JMDataFaultTolerance)

+ (void)load{
    //__NSCFString
    if (JM_DebugMode) {
        return;
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class targetClass = NSClassFromString(@"__NSCFString");
        [JMDataFaultToleranceHelper jm_swizzleInstanceMethod:@selector(appendString:) withMethod:@selector(jm_appendString:) withClass:targetClass];
        
        [JMDataFaultToleranceHelper jm_swizzleInstanceMethod:@selector(insertString:atIndex:) withMethod:@selector(jm_insertString:atIndex:) withClass:targetClass];
        
        [JMDataFaultToleranceHelper jm_swizzleInstanceMethod:@selector(substringFromIndex:) withMethod:@selector(jm_substringFromIndex:) withClass:targetClass];
        
        [JMDataFaultToleranceHelper jm_swizzleInstanceMethod:@selector(substringToIndex:) withMethod:@selector(jm_substringToIndex:) withClass:targetClass];
    });

    
}

- (void)jm_appendString:(NSString *)aString{
    if ([aString isKindOfClass:[NSString class]]){
        [self jm_appendString:aString];
    }else{
        [JMDataFaultToleranceHelper handleExceptionWithExceptionMsg:@"NSMutableString jm_appendString  parameter aString invalid"];
    }
}

- (void)jm_insertString:(NSString *)aString atIndex:(NSInteger)index{
    if ([aString isKindOfClass:[NSString class]]){
        [self jm_appendString:aString];
    }else{
        [JMDataFaultToleranceHelper handleExceptionWithExceptionMsg:@"NSMutableString jm_appendString  parameter aString invalid"];
    }
}


- (NSString *)jm_substringFromIndex:(NSUInteger)from{
    if(from < 0 || from > self.length){
         [JMDataFaultToleranceHelper handleExceptionWithExceptionMsg:@"NSMutableString jm_substringFromIndex  parameter Index invalid"];
        return nil;
    }
    return [self jm_substringFromIndex:from];
}

- (NSString *)jm_substringToIndex:(NSUInteger)to{
    if(to < 0 || to > self.length){
        [JMDataFaultToleranceHelper handleExceptionWithExceptionMsg:@"NSMutableString jm_substringFromIndex  parameter Index invalid"];
        return nil;
    }
    return [self jm_substringToIndex:to];
    
}
//
//- (void) hookInsertString:(NSString *)aString atIndex:(NSUInteger)loc{
//    if (aString && loc <= self.length) {
//        [self hookInsertString:aString atIndex:loc];
//    }else{
//        [JMDataFaultToleranceHelper handleExceptionWithExceptionMsg:@"NSMutableString appendString  parameter nil" extra:nil];
//}
//
//- (void) hookDeleteCharactersInRange:(NSRange)range{
//    if (range.location + range.length <= self.length){
//        [self hookDeleteCharactersInRange:range];
//    }else{
//        handleCrashException(JJExceptionGuardNSStringContainer,[NSString stringWithFormat:@"NSMutableString deleteCharactersInRange value:%@ range:%@",self,NSStringFromRange(range)]);
//    }
//}
//
//- (NSString *)hookSubstringFromIndex:(NSUInteger)from{
//    if (from <= self.length) {
//        return [self hookSubstringFromIndex:from];
//    }
//    handleCrashException(JJExceptionGuardNSStringContainer,[NSString stringWithFormat:@"NSMutableString substringFromIndex value:%@ from:%tu",self,from]);
//    return nil;
//}
//
//- (NSString *)hookSubstringToIndex:(NSUInteger)to{
//    if (to <= self.length) {
//        return [self hookSubstringToIndex:to];
//    }
//    handleCrashException(JJExceptionGuardNSStringContainer,[NSString stringWithFormat:@"NSMutableString substringToIndex value:%@ to:%tu",self,to]);
//    return self;
//}
//
//- (NSString *)hookSubstringWithRange:(NSRange)range{
//    if (range.location + range.length <= self.length) {
//        return [self hookSubstringWithRange:range];
//    }
//    handleCrashException(JJExceptionGuardNSStringContainer,[NSString stringWithFormat:@"NSMutableString substringWithRange value:%@ range:%@",self,NSStringFromRange(range)]);
//    return nil;
//}

@end
