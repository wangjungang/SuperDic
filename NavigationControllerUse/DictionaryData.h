//
//  DictionaryData.h
//  NavigationControllerUse
//
//  Created by administrator on 14-1-17.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Word.h"
@interface DictionaryData: NSObject
@property(nonatomic,retain) NSMutableArray *mutableArrAll;
@property(nonatomic,retain) NSMutableArray *mutableArr;
@property (nonatomic,retain) Word *myWord;
+(id)shareDictionaryData;
@end
