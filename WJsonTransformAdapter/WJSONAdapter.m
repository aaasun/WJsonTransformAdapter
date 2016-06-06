//
//  WJSONAdapter.m
//  DemoForRunTime
//
//  Created by wangjianwei on 15/2/5.
//  Copyright (c) 2015年 wangjianwei. All rights reserved.
//

#import "WJSONAdapter.h"

@implementation WJSONAdapter

/**
 *  返回解析过的model
 *
 *  @param classname class字符串
 *  @param data      具体需要解析的数据
 *
 *  @return 返回解析过的model
 */
+(id)JSONForModel:(NSString *)classname andData:(NSDictionary *)data
{
    Class classmodel = NSClassFromString(classname);
    id instance = [[classmodel alloc] init];
    if (![instance conformsToProtocol:@protocol(WJSONAdapterProtocal)]) {
        return nil;
    }
    NSDictionary *dicPropertySeri = [[(id<WJSONAdapterProtocal>)instance class] WJSONPropertySerializing];
    
    //接下来开始准备进行解析了
    if (!dicPropertySeri) {
        return nil;
    }
    
    //解析来开始准备进行解析了
    //class的属性的数组
    NSSet *arrProperty = [[self class] getModelProperty:classname];
    
    for (NSString *key in arrProperty) {
        NSLog(@"key:%@",key);
        if ([dicPropertySeri objectForKey:key]) {
            //获取需要解析的字典的key
            NSString *dataKey = [dicPropertySeri objectForKey:key];
            //通过运行时的方式进行model属性赋值
//            object_setIvar(instance, class_getInstanceVariable(classmodel, [NSString stringWithFormat:@"_%@",key].UTF8String), [data objectForKey:dataKey]);
//            SEL JSONTransformForKey = WSelectorWithKeyPattern(key, "JSONTransformForKey");
            SEL JSONTransformForKey = WSelectorWithKeyPattern(key, [jsonTransformerKey UTF8String]);
            
            if ([[instance class] respondsToSelector:JSONTransformForKey]) {
                NSMethodSignature *signature = [[instance class] methodSignatureForSelector:JSONTransformForKey];
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
                invocation.target = [instance class];
                invocation.selector = JSONTransformForKey;
                id resultData = [data objectForKey:dataKey];
                [invocation setArgument:&resultData atIndex:2];
                [invocation retainArguments];
                [invocation invoke];
                __unsafe_unretained id result = nil;
                [invocation getReturnValue:&result];
                [instance setValue:result forKey:key];
            }else
            {
                //通过key-value的方式进行赋值
                [instance setValue:[data objectForKey:dataKey] forKeyPath:key];
            }
        }
    }
    
    return instance;
    
    return nil;
}

/**
 *  根据class的nsstring返回class的所有属性的数组
 *
 *  @param classname class的字符串名称
 *
 *  @return 返回属性数组
 */
+(NSSet *)getModelProperty:(NSString *)classname
{
    unsigned count = 0;
    //获取属性的数组
    objc_property_t *keys = class_copyPropertyList(NSClassFromString(classname), &count);
    __autoreleasing NSMutableSet *setResutl = [[NSMutableSet alloc] init];
    for (unsigned i = 0; i<count; i++) {
        NSString *key =@(property_getName(keys[i]));
        [setResutl addObject:key];
    }
    free(keys);
    return setResutl;
}

@end

@implementation WJSONAdapter (Unavailable)

/**
 *  返回解析过的model
 *
 *  @param classname class字符串
 *  @param dic       模型的属性名和需要解析的字段key的对应
 *  @param data      具体需要解析的数据
 *
 *  @return 返回解析过的model
 */
+(id)JSONForModel:(NSString *)classname andKeyDic:(NSDictionary *)dic andData:(NSDictionary *)data
{
    Class classmodel = NSClassFromString(classname);
    id instance = [[classmodel alloc] init];
    
    //接下来开始准备进行解析了
    if (!dic) {
        return nil;
    }
    
    //解析来开始准备进行解析了
    //class的属性的数组
    NSSet *arrProperty = [[self class] getModelProperty:classname];
    
    for (NSString *key in arrProperty) {
        NSLog(@"key:%@",key);
        if ([dic objectForKey:key]) {
            NSString *dataKey = [dic objectForKey:key];
            //通过运行时的方式进行model属性赋值
//            object_setIvar(instance, class_getInstanceVariable(classmodel, [NSString stringWithFormat:@"_%@",key].UTF8String), [data objectForKey:dataKey]);
            //通过key-value的方式进行赋值
            [instance setValue:[data objectForKey:dataKey] forKeyPath:key];
        }
    }
    
    return instance;
}

@end
