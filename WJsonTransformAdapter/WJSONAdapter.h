//
//  WJSONAdapter.h
//  DemoForRunTime
//
//  Created by wangjianwei on 15/2/5.
//  Copyright (c) 2015年 wangjianwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "WJSONAdapterProtocal.h"
#import "WReflection.h"

#define jsonTransformerKey @"JSONTransformForKey:"

@interface WJSONAdapter : NSObject

@property (nonatomic, strong, readonly) Class modelClass;

/**
 *  根据class的nsstring返回class的所有属性的数组
 *
 *  @param classname class的字符串名称
 *
 *  @return 返回属性数组
 */
+(NSSet *)getModelProperty:(NSString *)classname;

/**
 *  返回解析过的model
 *
 *  @param classname class字符串
 *  @param data      具体需要解析的数据
 *
 *  @return 返回解析过的model
 */
+(id)JSONForModel:(NSString *)classname andData:(NSDictionary *)data;

//+(id)

@end

@interface WJSONAdapter (Unavailable)

/**
 *  返回解析过的model
 *
 *  @param classname class字符串
 *  @param dic       模型的属性名和需要解析的字段key的对应
 *  @param data      具体需要解析的数据
 *
 *  @return 返回解析过的model
 */
+(id)JSONForModel:(NSString *)classname andKeyDic:(NSDictionary *)dic andData:(NSDictionary *)data __attribute__((deprecated("Replaced by +JSONForModel:(NSString *)classname andData:(NSDictionary *)data")));

@end
