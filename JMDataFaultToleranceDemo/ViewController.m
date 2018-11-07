//
//  ViewController.m
//  JMDataFaultToleranceDemo
//
//  Created by 123 on 2018/10/25.
//  Copyright © 2018年 seven. All rights reserved.
//

#import "ViewController.h"
#import "JMDataFaultTolerance.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self demo0];
    [self demo1];
    [self demo2];
    [self demo3];
    [self demo4];
}

/**NSArray demo*/
- (void)demo0{
    NSArray *array = @[@"1",@"2",@"asdf",@(YES)];
    NSLog(@"array类型：%@",[array class]);
    
    [array objectAtIndex:3];
#pragma clang diagnostic ignored"-Wunused-variable"
    
    NSInteger a = [array jm_integerWithIndex:0];
    NSString *b = [array jm_stringWithIndex:2];
    BOOL c = [array jm_boolWithIndex:3];
    NSArray *d = [array jm_arrayWithIndex:6666];
    
#pragma clang diagnostic pop

    
    
}

/**NSMutableArray demo*/
- (void)demo1{
    NSMutableArray *arr1 = [NSMutableArray array];
    NSLog(@"NSMutableArray类型：%@",[arr1 class]);
    
    [arr1 insertObject:@"1" atIndex:2];
    [arr1 objectAtIndex:666];
    [arr1 removeObjectAtIndex:3];
   
    NSInteger a = [arr1 jm_integerWithIndex:0];
}

/**NSDictionary demo*/
- (void)demo2{
    NSDictionary *dict = @{@"key1":@"2",@"key2":@"4",@"key3":@"哈哈"};
    NSInteger a = [dict jm_integerForKey:@"key1"];
    NSNumber *b = [dict jm_numberForKey:@"key2"];
    NSInteger c = [dict jm_integerForKey:@"key3"];
    NSString *d = [dict jm_stringForKey:@"key3"];
    
//    NSDictionary dictionaryWithObjectsAndKeys:<#(nonnull id), ...#>, nil
}

/**NSMutableDictionary demo*/
- (void)demo3{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    NSLog(@"NSMutableDictionary类型：%@",[dictM class]);
    NSLog(@"%@",[dictM class]);
    [dictM setObject:nil forKey:@"1"];
    

    //    NSString *str = [NSString stringWithFormat:@"123"];
    //    id obj = YES;
    //    [dictM setObject:obj forKey:@"1"];
    
}

/**NSMutableString demo*/
- (void)demo4{
    NSMutableString *aString = [NSMutableString string];
    [aString appendString:@(YES)];
    [aString appendString:@"123"];
    
    NSLog(@"%@",aString);
//    [dictM setObject:nil forKey:@"1"];
    //    NSString *str = [NSString stringWithFormat:@"123"];
    //    id obj = YES;
    //    [dictM setObject:obj forKey:@"1"];
    
}


@end
