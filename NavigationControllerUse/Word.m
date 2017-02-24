//
//  Word.m
//  NavigationControllerUse
//
//  Created by administrator on 14-1-18.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import "Word.h"

@implementation Word
+(id)initWithWord:(NSString *)word trans:(NSString *)trans phonetic:(NSString *)phonetic tags:(NSString *)tags
{
    Word *wd =[[Word alloc] init];
    wd.word=word;
    wd.trans=trans;
    wd.phonetic=phonetic;
    wd.tags=tags;
    return wd;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.word forKey:@"word"];
    [aCoder encodeObject:self.trans forKey:@"trans"];
    [aCoder encodeObject:self.tags forKey:@"tags"];
    [aCoder encodeObject:self.phonetic forKey:@"phonetic"];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self.word=[aDecoder decodeObjectForKey:@"word"];
    self.trans=[aDecoder decodeObjectForKey:@"trans"];
    self.tags=[aDecoder decodeObjectForKey:@"tags"];
    self.phonetic=[aDecoder decodeObjectForKey:@"phonetic"];
    return  self;
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@,%@,%@",self.word,self.trans,self.tags,self.phonetic];
}
@end
