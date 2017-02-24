//
//  addViewController.m
//  SuperDic
//
//  Created by 王俊钢 on 2017/2/24.
//  Copyright © 2017年 ws. All rights reserved.
//

#import "addViewController.h"
#import "Word.h"
#import "DictionaryData.h"
@interface addViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *text1;
@property (nonatomic,strong) UITextField *text2;
@property (nonatomic,strong) UITextField *text3;
@property (nonatomic,strong) UITextField *text4;
@property (nonatomic,strong) UILabel *lab1;
@property (nonatomic,strong) UILabel *lab2;
@property (nonatomic,strong) UILabel *lab3;
@property (nonatomic,strong) UILabel *lab4;
@end

@implementation addViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    DictionaryData *dictionaryData=[DictionaryData shareDictionaryData];
    if(dictionaryData.myWord)
    {
        self.addBtn.hidden=YES;
        self.cancelBtn.hidden=YES;
//        [(UITextField*)[self.view viewWithTag:1] setText:dictionaryData.myWord.word];
//        [(UITextField*)[self.view viewWithTag:2] setText:dictionaryData.myWord.trans];
//        [(UITextField*)[self.view viewWithTag:3] setText:dictionaryData.myWord.phonetic];
//        [(UITextField*)[self.view viewWithTag:4] setText:dictionaryData.myWord.tags];
//        dictionaryData.myWord=nil;
        [self.text1 setText:dictionaryData.myWord.word];
        [self.text2 setText:dictionaryData.myWord.trans];
        [self.text3 setText:dictionaryData.myWord.phonetic];
        [self.text4 setText:dictionaryData.myWord.tags];
        dictionaryData.myWord=nil;
        
    }
    [self.view addSubview:self.lab1];
    [self.view addSubview:self.lab2];
    [self.view addSubview:self.lab3];
    [self.view addSubview:self.lab4];
    [self.view addSubview:self.text1];
    [self.view addSubview:self.text2];
    [self.view addSubview:self.text3];
    [self.view addSubview:self.text4];
    [self.view addSubview:self.addBtn];
    [self.view addSubview:self.cancelBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.cancelBtn.frame = CGRectMake(0, DEVICE_HEIGHT-300*HEIGHT_SCALE, DEVICE_WIDTH/2, 30*HEIGHT_SCALE);
    self.addBtn.frame = CGRectMake(DEVICE_WIDTH/2, DEVICE_HEIGHT-300*HEIGHT_SCALE, DEVICE_WIDTH/2, 30*HEIGHT_SCALE);
    
    self.lab1.frame = CGRectMake(50*WIDTH_SCALE, 40*HEIGHT_SCALE, 60*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.text1.frame = CGRectMake(120*WIDTH_SCALE, 40*HEIGHT_SCALE, DEVICE_WIDTH-150*WIDTH_SCALE, 30*HEIGHT_SCALE);
    
    self.lab2.frame = CGRectMake(50*WIDTH_SCALE, 90*HEIGHT_SCALE, 60*WIDTH_SCALE, 100*HEIGHT_SCALE);
    self.text2.frame = CGRectMake(120*WIDTH_SCALE, 90*HEIGHT_SCALE, DEVICE_WIDTH-150*WIDTH_SCALE, 100*HEIGHT_SCALE);
    
    self.lab3.frame = CGRectMake(50*WIDTH_SCALE, 210*HEIGHT_SCALE, 60*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.text3.frame = CGRectMake(120*WIDTH_SCALE, 210*HEIGHT_SCALE, DEVICE_WIDTH-150*WIDTH_SCALE, 30*HEIGHT_SCALE);
    
    self.lab4.frame = CGRectMake(50*WIDTH_SCALE, 250*HEIGHT_SCALE, 60*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.text4.frame = CGRectMake(120*WIDTH_SCALE, 250*HEIGHT_SCALE, DEVICE_WIDTH-150*WIDTH_SCALE, 30*HEIGHT_SCALE);
    
}

#pragma mark - getters

-(UIButton *)cancelBtn
{
    if(!_cancelBtn)
    {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitle:@"取消" forState:normal];
        [_cancelBtn setTitleColor:[UIColor wjColorFloat:@"D03B3D"] forState:normal];
        [_cancelBtn addTarget:self action:@selector(cancleClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

-(UIButton *)addBtn
{
    if(!_addBtn)
    {
        _addBtn = [[UIButton alloc] init];
        [_addBtn setTitle:@"添加" forState:normal];
        [_addBtn setTitleColor:[UIColor wjColorFloat:@"D03B3D"] forState:normal];
        [_addBtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

-(UILabel *)lab1
{
    if(!_lab1)
    {
        _lab1 = [[UILabel alloc] init];
        _lab1.text = @"单词：";
    }
    return _lab1;
}

-(UILabel *)lab2
{
    if(!_lab2)
    {
        _lab2 = [[UILabel alloc] init];
        _lab2.text = @"释义";
    }
    return _lab2;
}

-(UILabel *)lab3
{
    if(!_lab3)
    {
        _lab3 = [[UILabel alloc] init];
        _lab3.text = @"音标";
    }
    return _lab3;
}

-(UILabel *)lab4
{
    if(!_lab4)
    {
        _lab4 = [[UILabel alloc] init];
        _lab4.text = @"类型";
    }
    return _lab4;
}


-(UITextField *)text1
{
    if(!_text1)
    {
        _text1 = [[UITextField alloc] init];
        _text1.tag = 1;
        _text1.delegate = self;
        _text1.layer.masksToBounds = YES;
        _text1.layer.borderWidth = 0.5;
        _text1.layer.cornerRadius = 10;
    }
    return _text1;
}

-(UITextField *)text2
{
    if(!_text2)
    {
        _text2 = [[UITextField alloc] init];
        _text2.tag = 2;
        _text2.delegate = self;
        _text2.backgroundColor = [UIColor wjColorFloat:@"FDA800"];
        _text2.layer.masksToBounds = YES;
        _text2.layer.borderWidth = 0.5;
        _text2.layer.cornerRadius = 10;
    }
    return _text2;
}

-(UITextField *)text3
{
    if(!_text3)
    {
        _text3 = [[UITextField alloc] init];
        _text3.tag = 3;
        _text3.delegate = self;
        _text3.layer.masksToBounds = YES;
        _text3.layer.borderWidth = 0.5;
        _text3.layer.cornerRadius = 10;
    }
    return _text3;
}

-(UITextField *)text4
{
    if(!_text4)
    {
        _text4 = [[UITextField alloc] init];
        _text4.tag = 4;
        _text4.delegate = self;
        _text4.layer.masksToBounds = YES;
        _text4.layer.borderWidth = 0.5;
        _text4.layer.cornerRadius = 10;
    }
    return _text4;
}

//跳转按钮方法
-(void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

//添加
- (void)addClick:(UIButton *)sender {
    if ([[(UITextField*)[self.view viewWithTag:1] text] isEqualToString:@""]||[[(UITextField*)[self.view viewWithTag:2] text] isEqualToString:@""]) {
        
        UIAlertController *control = [UIAlertController alertControllerWithTitle:@"提示" message:@"单词 或 释义 不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [control addAction:action0];
        [control addAction:action1];
        [self presentViewController:control animated:YES completion:^{
            
        }];
        
        return ;
    }
    Word *wd=[Word initWithWord:[(UITextField*)[self.view viewWithTag:1] text] trans:[(UITextField*)[self.view viewWithTag:2] text] phonetic:[(UITextField*)[self.view viewWithTag:3] text] tags:[(UITextField*)[self.view viewWithTag:4] text]];
    DictionaryData *dictionaryData=[DictionaryData shareDictionaryData];
    int num=dictionaryData.mutableArrAll.count;
    bool bl=YES;
    for (int i=0; i<num; i++) {
        Word *tmp=dictionaryData.mutableArrAll[i];
        if ([wd.word compare:tmp.word]!=NSOrderedDescending) {
            [dictionaryData.mutableArrAll insertObject:wd atIndex:i];
            bl=NO;
            break;
        }
    }
    if (bl) {
        [dictionaryData.mutableArrAll insertObject:wd atIndex:dictionaryData.mutableArrAll.count];
    }
  
    UIAlertController *control = [UIAlertController alertControllerWithTitle:@"提示" message:@"添加成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         [self btnClick];
    }];
    [control addAction:action0];
    [control addAction:action1];
    [self presentViewController:control animated:YES completion:^{
        
    }];
    
}

- (void)cancleClick:(UIButton *)sender {
    NSLog(@"取消");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchUpInsideAction:(UIControl *)sender {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
