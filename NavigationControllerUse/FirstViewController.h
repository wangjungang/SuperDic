//
//  FirstViewController.h
//  NavigationControllerUse
//
//  Created by administrator on 14-1-17.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DictionaryData.h"
@interface FirstViewController : UIViewController
@property (nonatomic,retain)DictionaryData *dictionaryData;
@property (nonatomic,strong)UITableView *tableView;

@end
