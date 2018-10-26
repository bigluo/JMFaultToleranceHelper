//
//  NSDictionary+JMDataFaultTolerance.h
//  BottomPrinciple
//
//  Created by 123 on 2018/10/25.
//  Copyright © 2018年 JM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (JMDataFaultTolerance)
/** 获取基础类型 */
- (BOOL)jm_boolForKey:(id)key;

- (float)jm_floatForKey:(id)key;

- (double)jm_doubleForKey:(id)key;

- (long long)jm_longLongForKey:(id)key;

- (NSInteger)jm_integerForKey:(id)key;

/** 获取对象类型 */
- (NSString*)jm_stringForKey:(id)key;

- (NSNumber*)jm_numberForKey:(id)key;

- (NSArray*)jm_arrayForKey:(id)key;

- (NSDictionary*)jm_dictionaryForKey:(id)key;





@end

NS_ASSUME_NONNULL_END
