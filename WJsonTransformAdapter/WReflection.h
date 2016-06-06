//
//  WReflection.h
//  DemoForRunTime
//
//  Created by wangjianwei on 15/2/7.
//  Copyright (c) 2015年 wangjianwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


/**
 *  拼接Selector model的属性名称+统一的后缀
 *  key model的属性名称
 *  suffix 统一的拼接的函数的后缀
 */
SEL WSelectorWithKeyPattern(NSString *key , const char *suffix);