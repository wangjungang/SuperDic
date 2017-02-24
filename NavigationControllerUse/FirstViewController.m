//
//  FirstViewController.m
//  NavigationControllerUse
//
//  Created by administrator on 14-1-17.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "Word.h"
@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate>
@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //设置标题
        self.title=@"首页";
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated
{
    self.dictionaryData.mutableArr=self.dictionaryData.mutableArrAll;
    [self.tableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //初始化数据
    self.dictionaryData=[DictionaryData shareDictionaryData];
    ///NSString *strPath=[[NSBundle mainBundle] pathForResource:@"wsdata" ofType:@"xml"];
    ///获取文件路径
    NSString *strPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    strPath=[strPath stringByAppendingPathComponent:@"wsdata.xml"];
    
    //创建跳转按钮 事件 并添加到视图
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 30)];
    [btn setTitle:@"跳转视图" forState:UIControlStateNormal];
    btn.backgroundColor=[UIColor grayColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //设置导航按钮
    UIBarButtonItem *leftBarBtn=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(leftBarButton)];
    UIBarButtonItem *rightBarBtn=[[UIBarButtonItem alloc] initWithTitle:@"edit" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButton)];
    [self.navigationItem setLeftBarButtonItem:leftBarBtn];
    [self.navigationItem setRightBarButtonItem:rightBarBtn];
    
    //创建label
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(50, 66, 49, 40)];
    label.text=@"词语:";
    label.backgroundColor=[UIColor grayColor];
    [self.view addSubview:label];
    //创建textField
    UITextField *textField=[[UITextField alloc] initWithFrame:CGRectMake(100, 66, 200, 40)];
    textField.backgroundColor=[UIColor yellowColor];
    [textField setReturnKeyType:UIReturnKeyDone];
    [textField addTarget:self action:@selector(editChange:) forControlEvents:UIControlEventEditingChanged];
    [textField addTarget:self action:@selector(doneClick:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:textField];
    //创建UITableView
     self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, label.frame.origin.y+label.frame.size.height,self.view.frame.size.width , self.view.frame.size.height-label.frame.origin.y) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    
    //加载数据
    dispatch_queue_t queue=dispatch_queue_create("loaddata", nil);
    dispatch_async(queue, ^{
        int n=1;
        NSLog(@"%@",strPath);
        do {
            if(!(self.dictionaryData.mutableArrAll=[NSKeyedUnarchiver unarchiveObjectWithFile:strPath]))
            {
                NSString *strP=[[NSBundle mainBundle] pathForResource:@"wsdata" ofType:@"xml"];
                NSFileManager *fileManager=[NSFileManager defaultManager];
                NSError *error;
                [fileManager copyItemAtPath:strP toPath:strPath error:&error];
                if (error) {
                    NSLog(@"=====%@",error);
                }
            }
            else
            {
                break;
            }
        } while (n--);
        
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.dictionaryData.mutableArr=[NSMutableArray arrayWithArray:self.dictionaryData.mutableArrAll];
            ///NSLog(@"----------------%i",self.dictionaryData.mutableArr.count);
            [self.tableView reloadData];
        });
    });
    
    
}
//编辑改变，检索数据
-(void)editChange:(UITextField*)textField
{
    if ([textField.text isEqualToString:@""]) {
        self.dictionaryData.mutableArr=self.dictionaryData.mutableArrAll;
        return ;
    }
    NSString *tmpStr;
    char ch=[textField.text characterAtIndex:0];
    if ((ch>='a' && ch<='z') || (ch>='A' && ch<='Z')) {
        tmpStr=[NSString stringWithFormat:@"_word BEGINSWITH [c]'%@'",textField.text];
    }
    else
    {
        tmpStr=[NSString stringWithFormat:@"_trans CONTAINS [c]'%@'",textField.text];
    }
    ///NSLog(@"==%@",tmpStr);
    NSPredicate *predicate=[NSPredicate predicateWithFormat:tmpStr];
    
    dispatch_queue_t queue=dispatch_queue_create("filter", nil);
    dispatch_async(queue, ^{
        NSArray *tmpArr=[self.dictionaryData.mutableArrAll filteredArrayUsingPredicate:predicate];
        self.dictionaryData.mutableArr=[NSMutableArray arrayWithArray:tmpArr];
        ///NSLog(@"%i",self.dictionaryData.mutableArr.count);
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
    
}
-(void)doneClick:(UITextField*)textField
{
    [textField resignFirstResponder];
}
#pragma mark -tableView协议实现
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ///NSLog(@"!!!!!%i",self.dictionaryData.mutableArr.count);
    return self.dictionaryData.mutableArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"myCell"];
    }
    cell.textLabel.text=[self.dictionaryData.mutableArr[indexPath.row] word];
    cell.detailTextLabel.text=[self.dictionaryData.mutableArr[indexPath.row] trans];
    ///NSLog(@"11111111");
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
//删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        [self.dictionaryData.mutableArrAll removeObjectAtIndex:indexPath.row];
        self.dictionaryData.mutableArr=self.dictionaryData.mutableArrAll;
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
}
//选中一行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.dictionaryData.myWord=[self.dictionaryData.mutableArr objectAtIndex:indexPath.row];
    SecondViewController *secondNavigationController=[[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    [self.navigationController pushViewController:secondNavigationController animated:YES];
}
//跳转按钮方法
-(void)btnClick
{
    SecondViewController *secondNavigationController=[[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    [self.navigationController pushViewController:secondNavigationController animated:YES];
    
}
#pragma mark -导航按钮
//左导航图按钮 添加单词
-(void)leftBarButton
{
    SecondViewController *secondNavigationController=[[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    [self.navigationController pushViewController:secondNavigationController animated:YES];
}
//右导航
-(void)rightBarButton
{
    self.tableView.editing=!self.tableView.editing;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
