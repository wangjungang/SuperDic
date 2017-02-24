//
//  shouyeViewController.m
//  SuperDic
//
//  Created by 王俊钢 on 2017/2/24.
//  Copyright © 2017年 ws. All rights reserved.
//

#import "shouyeViewController.h"
#import "SDCycleScrollView.h"
#import "shouyeCell0.h"
#import "homeViewController.h"
#import "searchViewController.h"
#import "addViewController.h"
#import "shouyeCell1.h"

#import "selectViewController.h"
@interface shouyeViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>
@property (nonatomic,strong) UITableView *shouyetable;
@property (nonatomic,strong) SDCycleScrollView *cycleview;
@property (strong,nonatomic) NSArray *netImages;  //网络图片
@property (nonatomic,strong) NSArray *imgarr;
@property (nonatomic,strong) NSArray *textarr;
@property (nonatomic,strong) NSArray *selectarr;
@end

static NSString *shouyeidnetfid = @"shouyeidnetfid";
static NSString *shouyeidentfid1 = @"shouyeidentfid1";
@implementation shouyeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
    [self ScrollNetWorkImages];
    [self.view addSubview:self.shouyetable];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

#pragma mark - getters

-(UITableView *)shouyetable
{
    if(!_shouyetable)
    {
        _shouyetable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
        _shouyetable.dataSource = self;
        _shouyetable.delegate = self;
        _shouyetable.tableHeaderView = self.cycleview;
    }
    return _shouyetable;
}

/**
 *  懒加载网络图片数据
 */

-(NSArray *)netImages{
    
    if (!_netImages) {
        _netImages = @[
                       @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2289343891,1705828513&fm=23&gp=0.jpg",
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487949311795&di=07c51ecb5c7e8dd8819e8098f4a73a5c&imgtype=0&src=http%3A%2F%2Fpic.pc6.com%2Fup%2F2014-9%2F2014916144558.jpg",
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487949357812&di=27fb82f5f766bbf408a994e34497d85a&imgtype=0&src=http%3A%2F%2Fpic.baike.soso.com%2Fp%2F20130518%2F20130518175002-2033060479.jpg"
                       ];
    }
    return _netImages;
}

/**
 *  轮播网络图片
 */

-(void)ScrollNetWorkImages{
    
    /** 测试本地图片数据*/
    CGRect rect = CGRectMake(0,0, DEVICE_WIDTH, 200*HEIGHT_SCALE);
    self.cycleview = [SDCycleScrollView cycleScrollViewWithFrame:rect delegate:self placeholderImage:[UIImage imageNamed:@"PlacehoderImage.png"]];
    
    //设置网络图片数组
    self.cycleview.imageURLStringsGroup = self.netImages;
    
    //设置图片视图显示类型
    self.cycleview.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    
    //设置轮播视图的分页控件的显示
    self.cycleview.showPageControl = YES;
    
    //设置轮播视图分也控件的位置
    self.cycleview.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    
    //当前分页控件小圆标图片
    self.cycleview.pageDotImage = [UIImage imageNamed:@"pageCon.png"];
    
    //其他分页控件小圆标图片
    self.cycleview.currentPageDotImage = [UIImage imageNamed:@"pageConSel.png"];
    
}


-(NSArray *)imgarr
{
    if(!_imgarr)
    {
        _imgarr = @[@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1487951483&di=c19b5f33ace3b58bde08b26bbab52b0f&src=http://file06.16sucai.com/2016/0303/6b7f7a3c5ccbe9900094add1d8b5cbc8.jpg",@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1451253227,2324059802&fm=23&gp=0.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487961948542&di=3d11ff546ad6b5bbe68051ec9a7aecae&imgtype=0&src=http%3A%2F%2Fimg.25pp.com%2Fuploadfile%2Fsoft%2Fimages%2F2015%2F0806%2F20150806051658407.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487961996512&di=5890b4e44a63b41075d773d97edf74f7&imgtype=0&src=http%3A%2F%2Fpic35.photophoto.cn%2F20150406%2F0036036352678732_b.jpg"];
        
    }
    return _imgarr;
}

-(NSArray *)textarr
{
    if(!_textarr)
    {
        _textarr = @[@"NASA发现7颗超近类地行星",@"五种英语表达说“存钱”",@"最全英美语名词表述差异总结",@"Love versus romance 爱情与浪漫"];
        
    }
    return _textarr;
}

-(NSArray *)selectarr
{
    if(!_selectarr)
    {
        _selectarr = @[@"http://www.24en.com/read/news/science-technology/2017-02-24/187240.html",@"http://www.24en.com/study/words/2017-02-21/187228.html",@"http://www.24en.com/fun/bilingual/2017-02-22/187231.html",@"http://www.24en.com/bbc/bbc2/2017-02-21/187225.html"];
        
    }
    return _selectarr;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    else
    {
        return self.imgarr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        shouyeCell0 *cell = [tableView dequeueReusableCellWithIdentifier:shouyeidnetfid];
        if (!cell) {
            cell = [[shouyeCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shouyeidnetfid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.btn0 addTarget:self action:@selector(btn0click) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn1 addTarget:self action:@selector(btn1click) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn2 addTarget:self action:@selector(btn2click) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    else
    {
        shouyeCell1 *cell = [tableView dequeueReusableCellWithIdentifier:shouyeidentfid1];
        if (!cell) {
            cell = [[shouyeCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shouyeidentfid1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        
        [cell.leftimg sd_setImageWithURL:[NSURL URLWithString:self.imgarr[indexPath.row]]];
        cell.textlab.text = self.textarr[indexPath.row];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 50*HEIGHT_SCALE;
    }else
    {
        return 100*HEIGHT_SCALE;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 20;
    }
    else
    {
        return 10;
    }
}

#pragma mark - 实现方法

-(void)btn0click
{
    homeViewController *homevc = [[homeViewController alloc] init];
    [self.navigationController pushViewController:homevc animated:YES];
}

-(void)btn1click
{
    searchViewController *searchvc = [[searchViewController alloc] init];
    [self.navigationController pushViewController:searchvc animated:YES];
}

-(void)btn2click
{
    addViewController *addvc = [[addViewController alloc] init];
    [self.navigationController pushViewController:addvc animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        selectViewController *selectvc = [[selectViewController alloc] init];
        selectvc.urlstr = self.selectarr[indexPath.row];
        [self.navigationController pushViewController:selectvc animated:YES];
    }
}
@end
