# ios-Charts-
基于Swift Charts封装的Charts 简单易用

因为项目需要用到图表 
使用方便 便于快捷开发 详见Demo

    ChartView * chartView = [[ChartView alloc]initWithFrame:CGRectMake(0, 200, kDeviceWidth, 300) type:ChartViewTypeBar];
    [self.view addSubview:chartView]；
    NSArray * x = @[@"雨量" , @"流量" , @"水量" , @"水位" ,@"降雨量" , @"放水量" ];
    NSArray * y = @[@(20) , @(45) , @(34) , @(60) ,@(20) , @(45) ];
    [chartView setDataWithy:y xtitle:x];
    chartView.isxAxisTitle = YES;
    [chartView addLimitData:45 text:@"标准线"];
    chartView.desc = @"";
    chartView.leftNegativeSuffix = @"m³";
    chartView.balloonViewEnabled = YES;
    
    [chartView chartViewDidSelect:^(ChartViewBase *chartView, ChartDataEntry *entry, NSInteger index) {
        
    }];
