//
//  Word.h
//  NavigationControllerUse
//
//  Created by administrator on 14-1-18.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Word : NSObject <NSCoding>

@property (nonatomic,copy) NSString *word;
@property (nonatomic,copy) NSString *trans;
@property (nonatomic,copy) NSString *phonetic;
@property (nonatomic,copy) NSString *tags;

+(id)initWithWord:(NSString*)word trans:(NSString*)trans phonetic:(NSString*)phonetic tags:(NSString*)tags;
@end
