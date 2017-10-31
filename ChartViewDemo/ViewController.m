//
//  ViewController.m
//  ChartViewDemo
//
//  Created by 软件技术中心 on 2017/10/31.
//  Copyright © 2017年 xujiyao. All rights reserved.
//
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define KDeviceHeight [UIScreen mainScreen].bounds.size.height
#import "ViewController.h"
#import "TableMaker.h"
@interface ViewController ()
@property (nonatomic ,retain) UITableView * tableView;

@property (nonatomic ,strong) TableMaker * maker;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ChartViewDemo";
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight) style:UITableViewStyleGrouped];
    self.maker = [[TableMaker alloc]initWithTableView:self.tableView superView:self];
    self.tableView.delegate = self.maker;
    self.tableView.dataSource = self.maker;
    [self.view addSubview:_tableView];
    
        
    
    
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
