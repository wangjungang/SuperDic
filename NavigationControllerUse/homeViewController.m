//
//  homeViewController.m
//  NavigationControllerUse
//
//  Created by 王俊钢 on 2017/2/22.
//  Copyright © 2017年 ws. All rights reserved.
//

#import "homeViewController.h"
#import "Word.h"
#import "addViewController.h"
@interface homeViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *hometableview;
@property (nonatomic,strong) UIImageView *bgimg;

@end

@implementation homeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"词库";
    [self.view addSubview:self.bgimg];
    
    
    
    [self.view addSubview:self.hometableview];
    
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
            [self.hometableview reloadData];
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
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.dictionaryData.mutableArr=self.dictionaryData.mutableArrAll;
    [self.hometableview reloadData];
}

#pragma mark - getters



-(UIImageView *)bgimg
{
    if(!_bgimg)
    {
        _bgimg = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _bgimg.image = [UIImage imageNamed:@"BG"];
    }
    return _bgimg;
}


-(UITableView *)hometableview
{
    if(!_hometableview)
    {
        _hometableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
        _hometableview.dataSource = self;
        _hometableview.delegate = self;
    }
    return _hometableview;
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
    addViewController *addvc = [[addViewController alloc] init];
    [self.navigationController pushViewController: addvc animated:YES];
    // SecondViewController *secondNavigationController=[[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    //  [self.navigationController pushViewController:secondNavigationController animated:YES];
}


@end
