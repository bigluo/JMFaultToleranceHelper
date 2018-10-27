
# JMDataFaultToleranceHelper
  A simple fault tolerant scheme Demo.

 ## 简介
解析处理或者处理类似数组或者字典数据时，经常会遇到越界或者插入nil数据等问题。引发这类问题通常会引发程序crash，所以参考网上资料，做了一套类型数据处理时的容错方案。

 ## 主要类
* JMDataFaultToleranceHelper.m  ：工具类
* NSArray+JMDataFaultTolerance.m  ：数组容错分类
* NSMutableArray+JMDataFaultTolerance.m ：可变数组容错分类
* NSDictionary+JMDataFaultTolerance.m   ：字典容错分类
* NSMutableDictionary+JMDataFaultToerance.m ：可变字典容错分类
* NSMutableString+JMDataFaultTolerance.m    ：可变字符串容错分类

## Demo

#### NSArray demo
 ```
- (void)demo0{
    NSArray *array = @[@"1",@"2",@"asdf",@(YES)];
 
    [array objectAtIndex:3];
    NSInteger a = [array jm_integerWithIndex:0];
    NSString *b = [array jm_stringWithIndex:2];
    BOOL c = [array jm_boolWithIndex:3];
    NSArray *d = [array jm_arrayWithIndex:6666];
}
```
#### NSMutableArray Demo
```
- (void)demo1{
    NSMutableArray *arr1 = [NSMutableArray array];
    NSLog(@"NSMutableArray类型：%@",[arr1 class]);
    
    [arr1 insertObject:@"1" atIndex:2];
    [arr1 objectAtIndex:666];
    [arr1 removeObjectAtIndex:3];
   
    NSInteger a = [arr1 jm_integerWithIndex:0];
}
……
```


 ## 注意
在debug环境下这套方案，不会生效，防止错误没有及时发现。
只有在release环境才会在生效，防止程序crash。

And,还有很多待完善的地方。

