//
//  shouyeCell1.m
//  SuperDic
//
//  Created by 王俊钢 on 2017/2/24.
//  Copyright © 2017年 ws. All rights reserved.
//

#import "shouyeCell1.h"

@implementation shouyeCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftimg];
        [self.contentView addSubview:self.textlab];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftimg.frame = CGRectMake(20*WIDTH_SCALE, 20*HEIGHT_SCALE, 60*WIDTH_SCALE, 60*WIDTH_SCALE);
    self.textlab.frame = CGRectMake(100*WIDTH_SCALE, 20*HEIGHT_SCALE, 300*WIDTH_SCALE, 60*HEIGHT_SCALE);
}

#pragma mark - getters


-(UIImageView *)leftimg
{
    if(!_leftimg)
    {
        _leftimg = [[UIImageView alloc] init];
        
    }
    return _leftimg;
}


-(UILabel *)textlab
{
    if(!_textlab)
    {
        _textlab = [[UILabel alloc] init];
        
    }
    return _textlab;
}



@end
