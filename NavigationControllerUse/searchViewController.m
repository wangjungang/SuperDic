//
//  searchViewController.m
//  SuperDic
//
//  Created by 王俊钢 on 2017/2/24.
//  Copyright © 2017年 ws. All rights reserved.
//

#import "searchViewController.h"
#import "Word.h"
@interface searchViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *searchtable;
@property (nonatomic,strong) UITextField *text;
@end

@implementation searchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"查询";
    //设置导航按钮
    UIBarButtonItem *rightBarBtn=[[UIBarButtonItem alloc] initWithTitle:@"edit" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButton)];
    [self.navigationItem setRightBarButtonItem:rightBarBtn];
    
    [self.view addSubview:self.searchtable];
    [self.view addSubview:self.text];
    
    //初始化数据
    self.dictionaryData=[DictionaryData shareDictionaryData];
    ///NSString *strPath=[[NSBundle mainBundle] pathForResource:@"wsdata" ofType:@"xml"];
    ///获取文件路径
    
    NSString *strPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    strPath=[strPath stringByAppendingPathComponent:@"wsdata.xml"];
    
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
            [self.searchtable reloadData];
        });
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.text.frame = CGRectMake(20, 15, DEVICE_WIDTH-40, 40);
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.dictionaryData.mutableArr=self.dictionaryData.mutableArrAll;
    [self.searchtable reloadData];
}

#pragma mark - getters

-(UITextField *)text
{
    if(!_text)
    {
        _text = [[UITextField alloc] init];
        _text.delegate = self;
        _text.placeholder = @"请输入要查找的内容";
        [_text setReturnKeyType:UIReturnKeyDone];
        [_text addTarget:self action:@selector(editChange:) forControlEvents:UIControlEventEditingChanged];
        [_text addTarget:self action:@selector(doneClick:) forControlEvents:UIControlEventEditingDidEndOnExit];
    }
    return _text;
}


-(UITableView *)searchtable
{
    if(!_searchtable)
    {
        _searchtable = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, DEVICE_WIDTH, DEVICE_HEIGHT-60) style:UITableViewStylePlain];
        _searchtable.dataSource = self;
        _searchtable.delegate = self;
    }
    return _searchtable;
}

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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    // SecondViewController *secondNavigationController=[[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    //  [self.navigationController pushViewController:secondNavigationController animated:YES];
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
            [self.searchtable reloadData];
        });
    });
    
}

-(void)doneClick:(UITextField*)textField
{
    [textField resignFirstResponder];
}
//右导航

-(void)rightBarButton
{
    self.searchtable.editing=!self.searchtable.editing;
}

@end
