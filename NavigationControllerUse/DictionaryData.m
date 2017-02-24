//
//  DictionaryData.m
//  NavigationControllerUse
//
//  Created by administrator on 14-1-17.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import "DictionaryData.h"
DictionaryData* dictionaryData;
@implementation DictionaryData
+(id)allocWithZone:(struct _NSZone *)zone
{
    if (!dictionaryData) {
        dictionaryData=[super allocWithZone:zone];
    }
    return dictionaryData;
}
+(id)shareDictionaryData
{
    dictionaryData =[[DictionaryData alloc] init];
    return dictionaryData;
}

@end
