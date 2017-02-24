//
//  shouyeCell0.m
//  SuperDic
//
//  Created by 王俊钢 on 2017/2/24.
//  Copyright © 2017年 ws. All rights reserved.
//

#import "shouyeCell0.h"

@implementation shouyeCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.btn0];
        [self.contentView addSubview:self.btn1];
        [self.contentView addSubview:self.btn2];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.btn0.frame = CGRectMake(0, 10*HEIGHT_SCALE, DEVICE_WIDTH/3, 30*HEIGHT_SCALE);
    self.btn1.frame = CGRectMake(DEVICE_WIDTH/3, 10*HEIGHT_SCALE, DEVICE_WIDTH/3, 30*HEIGHT_SCALE);
    self.btn2.frame = CGRectMake(DEVICE_WIDTH/3*2, 10*HEIGHT_SCALE, DEVICE_WIDTH/3, 30*HEIGHT_SCALE);
}

#pragma mark - getters

-(UIButton *)btn0
{
    if(!_btn0)
    {
        _btn0 = [[UIButton alloc] init];
        [_btn0 setTitle:@"词库" forState:normal];
        //_btn0.backgroundColor = [UIColor redColor];
        [_btn0 setTitleColor:[UIColor wjColorFloat:@"D03B3D"] forState:normal];
    }
    return _btn0;
}

-(UIButton *)btn1
{
    if(!_btn1)
    {
        _btn1 = [[UIButton alloc] init];
        [_btn1 setTitle:@"查询" forState:normal];
        [_btn1 setTitleColor:[UIColor wjColorFloat:@"D03B3D"] forState:normal];
    }
    return _btn1;
}

-(UIButton *)btn2
{
    if(!_btn2)
    {
        _btn2 = [[UIButton alloc] init];
        [_btn2 setTitle:@"添加单词" forState:normal];
        [_btn2 setTitleColor:[UIColor wjColorFloat:@"D03B3D"] forState:normal];
    }
    return _btn2;
}






@end
