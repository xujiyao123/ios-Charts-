//
//  LineViewController.m
//  ChartViewDemo
//
//  Created by 软件技术中心 on 2017/10/31.
//  Copyright © 2017年 xujiyao. All rights reserved.
//

#import "LineViewController.h"
#import "ChartView.h"
@interface LineViewController ()

@end

@implementation LineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
        ChartView * chartView = [[ChartView alloc]initWithLeft:0 top:64 right:0 bottom:55 type:ChartViewTypeLine];
        [self.view addSubview:chartView];
    
        NSMutableArray * dataSourse = [NSMutableArray array];
    
        NSArray * x = @[@"雨量" , @"流量" , @"水量" , @"what"];
        NSArray * y = @[@(20) , @(45) , @(34) , @(60)];
    
    
        NSMutableArray * line1 = [chartView setDataWithy:y xtitle:x];
    
        NSArray * x2 = @[@"雨量" , @"流量" , @"水量" , @"what"];
        NSArray * y2 = @[@(45) , @(67) , @(34) , @(12)];
    
        NSMutableArray * line2 = [chartView setDataWithy:y2 xtitle:x2];
    
        [dataSourse addObject:line1];
        [dataSourse addObject:line2];
    
        chartView.linedataSource = dataSourse;
    chartView.isxAxisTitle = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
