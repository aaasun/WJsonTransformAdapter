//
//  WJSONAdapterProtocal.h
//  DemoForRunTime
//
//  Created by front on 15/2/5.
//  Copyright (c) 2015年 wangjianwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WJSONAdapterProtocal <NSObject>

@required

/**
 *  返回解析需要的property-key的对应关系
 *
 *
 *  @return 返回解析过的model
 */
+(NSDictionary *)WJSONPropertySerializing;

@end
