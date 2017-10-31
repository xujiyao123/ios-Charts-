//
//  ChartView.h
//  ChartsDemo
//
//  Created by 软件技术中心 on 2017/10/23.
//  Copyright © 2017年 xujiyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartViewModel.h"
#import "ChartViewDemo-Swift.h"

#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define KDeviceHeight [UIScreen mainScreen].bounds.size.height
typedef NS_ENUM(NSInteger, ChartViewType) {
    
    ChartViewTypeBar = 0,
    ChartViewTypePieInSide = 1,
    ChartViewTypePieOutSide = 2,
    ChartViewTypeLine = 3,
    ChartViewTypeVBarHorizontal = 4 ,
    ChartViewTypeVLineHorizontal = 5
};

@interface ChartView : UIView <ChartViewDelegate>
//柱状图  饼状图 数据源 单一折线图数据源
@property (nonatomic,retain) NSMutableArray<ChartViewModel *> *dataSource;
//折线图数据源
@property (nonatomic,retain) NSMutableArray<NSMutableArray *> *linedataSource;

@property (nonatomic ,retain) BarChartView * barChart;
@property (nonatomic,retain) PieChartView *pieChart;
@property (nonatomic,retain) LineChartView *lineChart;
//可遵循原版代理
@property (nonatomic,assign) id <ChartViewDelegate> delegate;

//单位
@property (nonatomic,retain) NSString *leftNegativeSuffix;
//图标描述
@property (nonatomic,retain) NSString  *desc;
//无数据时显示
@property (nonatomic,retain) NSString *noDtaaText;
//显示横轴title
@property (nonatomic,assign) BOOL isxAxisTitle;
//气泡开关
@property (nonatomic,assign) BOOL balloonViewEnabled;



- (instancetype)initWithFrame:(CGRect)frame type:(ChartViewType)type;

- (id)initWithLeft:(NSInteger )left top:(NSInteger)top right:(NSInteger)right bottom:(NSInteger)bottom type:(ChartViewType)type ;

- (NSMutableArray *)setDataWithy:(NSArray *)y xtitle:(NSArray *)xtitle;

- (void)addLimitData:(CGFloat )data text:(NSString *)text;

- (void)drawPieChartHoleEnabled:(BOOL)enabled text:(NSString *)text;

- (void)chartViewDidSelect:(void(^)(ChartViewBase *chartView ,ChartDataEntry * entry , NSInteger index))block;

@end







