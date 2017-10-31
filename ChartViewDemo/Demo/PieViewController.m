//
//  PieViewController.m
//  ChartViewDemo
//
//  Created by 软件技术中心 on 2017/10/31.
//  Copyright © 2017年 xujiyao. All rights reserved.
//

#import "PieViewController.h"
#import "ChartView.h"
@interface PieViewController ()

@end

@implementation PieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    ChartView * chartView = [[ChartView alloc]initWithFrame:CGRectMake(0, 64, kDeviceWidth, 300) type:ChartViewTypePieOutSide];
    [self.view addSubview:chartView];
    NSArray * x = @[@"雨量" , @"流量" , @"水量" , @"水位" ,@"降雨量" , @"放水量" ];
    NSArray * y = @[@(20) , @(45) , @(34) , @(60) ,@(20) , @(45) ];
    
    [chartView setDataWithy:y xtitle:x];
    chartView.isxAxisTitle = YES;
    [chartView addLimitData:45 text:@"标准线"];
    chartView.desc = @"";
    chartView.leftNegativeSuffix = @"m³";

    [chartView chartViewDidSelect:^(ChartViewBase *chartView, ChartDataEntry *entry, NSInteger index) {
        
    }];
    
    
    
    ChartView * chartView2 = [[ChartView alloc]initWithFrame:CGRectMake(0, 364, kDeviceWidth, 300) type:ChartViewTypePieInSide];
    [self.view addSubview:chartView2];
    
    [chartView2 setDataWithy:y xtitle:x];
    chartView2.isxAxisTitle = YES;
    [chartView2 addLimitData:45 text:@"标准线"];
    chartView2.desc = @"";
    chartView2.leftNegativeSuffix = @"m³";
    [chartView2 drawPieChartHoleEnabled:YES text:@"pie"];
    
    [chartView2 chartViewDidSelect:^(ChartViewBase *chartView, ChartDataEntry *entry, NSInteger index) {
        
    }];
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
