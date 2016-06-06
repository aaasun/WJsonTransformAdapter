//
//  WReflection.m
//  DemoForRunTime
//
//  Created by wangjianwei on 15/2/7.
//  Copyright (c) 2015年 wangjianwei. All rights reserved.
//

#import "WReflection.h"


/**
 *  拼接Selector model的属性名称+统一的后缀
 *  key model的属性名称
 *  suffix 统一的拼接的函数的后缀
 */
SEL WSelectorWithKeyPattern(NSString *key , const char *suffix)
{
    NSUInteger keyLenth = [key maximumLengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSUInteger suffixLength = strlen(suffix);
    char selector[keyLenth + suffixLength +1];
    BOOL success = [key getBytes:selector maxLength:keyLenth usedLength:&keyLenth encoding:NSUTF8StringEncoding options:0 range:NSMakeRange(0, key.length) remainingRange:NULL];
    if (!success) {
        return NULL;
    }
    memcpy(selector + keyLenth, suffix, suffixLength);
    selector[keyLenth + suffixLength] = '\0';
    return sel_registerName(selector);
}