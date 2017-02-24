//
//  SecondViewController.m
//  NavigationControllerUse
//
//  Created by administrator on 14-1-17.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import "SecondViewController.h"
#import "Word.h"
#import "DictionaryData.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //设置标题
        self.title=@"第二个视图";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    DictionaryData *dictionaryData=[DictionaryData shareDictionaryData];
    if(dictionaryData.myWord)
    {
        self.addBtn.hidden=YES;
        self.cancelBtn.hidden=YES;
        [(UITextField*)[self.view viewWithTag:1] setText:dictionaryData.myWord.word];
        [(UITextField*)[self.view viewWithTag:2] setText:dictionaryData.myWord.trans];
        [(UITextField*)[self.view viewWithTag:3] setText:dictionaryData.myWord.phonetic];
        [(UITextField*)[self.view viewWithTag:4] setText:dictionaryData.myWord.tags];
        dictionaryData.myWord=nil;
        
    }
}
//跳转按钮方法
-(void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//添加
- (IBAction)addClick:(UIButton *)sender {
    if ([[(UITextField*)[self.view viewWithTag:1] text] isEqualToString:@""]||[[(UITextField*)[self.view viewWithTag:2] text] isEqualToString:@""]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"单词 或 释意 不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
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
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"单词 添加成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [self btnClick];
    
}

- (IBAction)cancleClick:(UIButton *)sender {
    
}

- (IBAction)touchUpInsideAction:(UIControl *)sender {
    [self.view endEditing:YES];
}
@end
