//
//  addViewController.h
//  SuperDic
//
//  Created by 王俊钢 on 2017/2/24.
//  Copyright © 2017年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addViewController : UIViewController
@property (strong, nonatomic)  UIButton *addBtn;
@property (strong, nonatomic)  UIButton *cancelBtn;

- (void)addClick:(UIButton *)sender;

- (void)cancleClick:(UIButton *)sender;
- (void)touchUpInsideAction:(UIControl *)sender;

@end
