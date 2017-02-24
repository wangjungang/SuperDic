//
//  selectViewController.m
//  SuperDic
//
//  Created by 王俊钢 on 2017/2/25.
//  Copyright © 2017年 ws. All rights reserved.
//

#import "selectViewController.h"

@interface selectViewController ()
@property (nonatomic,strong) UIWebView *webview;
@end

@implementation selectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = webView;
    NSURL *url = [NSURL URLWithString:self.urlstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
