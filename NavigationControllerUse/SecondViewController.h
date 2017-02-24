//
//  SecondViewController.h
//  NavigationControllerUse
//
//  Created by administrator on 14-1-17.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *addBtn;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;

- (IBAction)addClick:(UIButton *)sender;

- (IBAction)cancleClick:(UIButton *)sender;
- (IBAction)touchUpInsideAction:(UIControl *)sender;

@end
