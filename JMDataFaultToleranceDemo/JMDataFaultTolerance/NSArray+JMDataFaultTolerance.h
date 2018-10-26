//
//  NSArray+JMDataFaultTolerance.h
//  BottomPrinciple
//
//  Created by 123 on 2018/10/25.
//  Copyright © 2018年 JM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSArray (JMDataFaultTolerance)
/** 获取基础类型 */
- (BOOL)jm_boolWithIndex:(NSUInteger)index;

- (float)jm_floatWithIndex:(NSUInteger)index;

- (double)jm_doubleWithIndex:(NSUInteger)index;

- (NSInteger)jm_integerWithIndex:(NSUInteger)index;

/** 获取对象类型 */
- (NSString*)jm_stringWithIndex:(NSUInteger)index;

- (NSNumber*)jm_numberWithIndex:(NSUInteger)index;

- (NSArray*)jm_arrayWithIndex:(NSUInteger)index;

- (NSDictionary*)jm_dictionaryWithIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
