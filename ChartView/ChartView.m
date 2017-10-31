//
//  ChartView.m
//  ChartsDemo
//
//  Created by 软件技术中心 on 2017/10/23.
//  Copyright © 2017年 xujiyao. All rights reserved.
//

#import "ChartView.h"
#import "ChartDefaultValueFomatter.h"


typedef void(^chartViewSelectBlock)(ChartViewBase *chartView , ChartDataEntry * entry, NSInteger index);
@interface ChartView()

@property(nonatomic ,assign) ChartViewType type;

@property (nonatomic,copy) chartViewSelectBlock selectBlock;

@property (nonatomic,retain) NSArray *xVals;

@end
@implementation ChartView

- (instancetype)initWithLeft:(NSInteger )left top:(NSInteger)top right:(NSInteger)right bottom:(NSInteger)bottom type:(ChartViewType)type {
    
    self = [self initWithFrame:CGRectMake(left, top, kDeviceWidth - right - left, KDeviceHeight - bottom - top) type:type];
    if (self) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame type:(ChartViewType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame= frame;

        _dataSource = [NSMutableArray array];
        _linedataSource = [NSMutableArray array];
        self.type = type;
        if (!self.noDtaaText) {
            self.noDtaaText = @"没有数据";
        }
        if (!self.desc) {
            self.desc = @"图例";
        }
        
        if (type == ChartViewTypeBar || type == ChartViewTypeVBarHorizontal) {
              [self getBarChartWithframe:frame];
        }else if (type == ChartViewTypePieInSide || type == ChartViewTypePieOutSide) {
            [self getPieChartWithframe:frame];
        }else if (type == ChartViewTypeLine || type == ChartViewTypeVLineHorizontal) {
            [self getLineChartWithframe:frame];
        }
      
    }
    return self;
}

-(void)getBarChartWithframe:(CGRect) frame{
    if (self.type == ChartViewTypeVBarHorizontal) {
          self.barChart = [[HorizontalBarChartView alloc]init];
    }else {
            self.barChart = [[BarChartView alloc]init];
    }
   
    self.barChart.backgroundColor = [UIColor clearColor];
//   [self.barChart setExtraOffsetsWithLeft:0 top:200 right:0 bottom:300];//图距离边缘的间隙

    self.barChart.delegate = self.delegate == NULL ? self : self.delegate;
    self.barChart.descriptionText = self.desc;
    self.barChart.noDataText = self.noDtaaText;
    self.barChart.maxVisibleCount = 60;
    self.barChart.pinchZoomEnabled = NO;
    self.barChart.drawBarShadowEnabled = NO;
    self.barChart.drawGridBackgroundEnabled = NO;

    //    图例
    self.barChart.legend.enabled = YES;
    self.barChart.legend.position = ChartLegendPositionBelowChartCenter;
    self.barChart.legend.form = ChartLegendFormSquare;
    self.barChart.legend.formSize = 9.0;
    self.barChart.legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
    self.barChart.legend.xEntrySpace = 4.0;
    
       [self addSubview:_barChart];
    
    [self addLayoutConstraintWithView:_barChart];
  
    
    
    ChartXAxis *xAxis =  self.barChart.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
//    xAxis.avoidFirstLastClippingEnabled = YES;
    //    xAxis.spaceBetweenLabels = 0.8;
    xAxis.drawAxisLineEnabled = NO;
    xAxis.drawGridLinesEnabled = NO;
    xAxis.granularity = 1;
    xAxis.granularityEnabled = YES;
//    xAxis.centerAxisLabelsEnabled = YES;
//    xAxis.labelRotationAngle = -60;//给x轴坐标价格角度
    

    
    ChartYAxis *leftAxis =  self.barChart.leftAxis;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    leftAxis.labelCount = 8;
    
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.maximumFractionDigits = 1;
    pFormatter.negativeSuffix = @"";
    pFormatter.positiveSuffix = @"";
    
    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:pFormatter];
    
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    leftAxis.spaceTop = 0.15;
    leftAxis.axisMinValue = 0.0; // this replaces startAtZero = YES
    
    ChartYAxis *rightAxis = self.barChart.rightAxis;
    rightAxis.enabled = NO;
    self.barChart.legend.enabled = YES;
    
 
   
}
- (void)getPieChartWithframe:(CGRect) frame{
    //创建饼状图
    self.pieChart = [[PieChartView alloc] init];

    self.pieChart.delegate = self.delegate == NULL ? self : self.delegate;
    self.pieChart.backgroundColor = [UIColor clearColor];
    //    [self.view addSubview:self.pieChartView];
    
    //基本样式
//    [self.pieChart setExtraOffsetsWithLeft:30 top:0 right:30 bottom:0];//饼状图距离边缘的间隙
    self.pieChart.usePercentValuesEnabled = YES;//是否根据所提供的数据, 将显示数据转换为百分比格式
    self.pieChart.dragDecelerationEnabled = YES;//拖拽饼状图后是否有惯性效果
    self.pieChart.drawSliceTextEnabled = YES;//是否显示区块文本
    //实心饼状图样式
    self.pieChart.drawHoleEnabled = NO;
    //饼状图中间描述
    if (self.pieChart.isDrawHoleEnabled == YES) {
        self.pieChart.drawCenterTextEnabled = YES;//是否显示中间文字
    }
    //饼状图描述
    self.pieChart.noDataText = self.noDtaaText;
    self.pieChart.descriptionText = self.desc;
    self.pieChart.descriptionFont = [UIFont systemFontOfSize:15];
    self.pieChart.descriptionTextColor = [UIColor grayColor];
    //饼状图图例
    self.pieChart.legend.maxSizePercent = 1;//图例在饼状图中的大小占比, 这会影响图例的宽高
    self.pieChart.legend.formToTextSpace = 5;//文本间隔
    self.pieChart.legend.font = [UIFont systemFontOfSize:10];//字体大小
    self.pieChart.legend.textColor = [UIColor grayColor];//字体颜色
    self.pieChart.legend.position = ChartLegendPositionBelowChartCenter;//图例在饼状图中的位置
    self.pieChart.legend.form = ChartLegendFormSquare;//图示样式: 方形、线条、圆形
    self.pieChart.legend.formSize = 12;//图示大小
    
    //为饼状图提供数据
    //设置动画效果
    [self.pieChart animateWithXAxisDuration:1.0f easingOption:ChartEasingOptionEaseOutExpo];
    
    [self addSubview:_pieChart];
    
    [self addLayoutConstraintWithView:_pieChart];
    
}

- (void)getLineChartWithframe:(CGRect) frame{
    //添加LineChartView
    self.lineChart = [[LineChartView alloc] init];

    
    self.lineChart.delegate = self.delegate == NULL ? self : self.delegate;//设置代理
    
    //基本样式
    self.lineChart.backgroundColor =  [UIColor whiteColor];
    self.lineChart.noDataText = self.noDtaaText;
    self.lineChart.descriptionText = self.desc;
    //交互样式
    self.lineChart.scaleYEnabled = NO;//取消Y轴缩放
    self.lineChart.doubleTapToZoomEnabled = NO;//取消双击缩放
    self.lineChart.dragEnabled = YES;//启用拖拽图标
    self.lineChart.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
    self.lineChart.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
    //X轴样式
    ChartXAxis *xAxis = self.lineChart.xAxis;
    xAxis.axisLineWidth = 1.0/[UIScreen mainScreen].scale;//设置X轴线宽
    xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
    xAxis.avoidFirstLastClippingEnabled = YES;
    xAxis.drawGridLinesEnabled = YES;//不绘制网格线
    xAxis.granularity = 1;
    xAxis.granularityEnabled = YES;
    //    xAxis.spaceBetweenLabels = 4;//设置label间隔

    //Y轴样式
    self.lineChart.rightAxis.enabled = NO;//不绘制右边轴
    
    self.lineChart.legend.form = ChartLegendFormLine;
    self.lineChart.legend.formSize = 30;
    self.lineChart.legend.textColor = [UIColor darkGrayColor];
    
    [self.lineChart animateWithXAxisDuration:1.0f];
    
    [self addSubview:self.lineChart];
    
    [self addLayoutConstraintWithView:_lineChart];
    
}


-(ChartData *)getData:(NSMutableArray *)datasource{
    ChartData *data = [[ChartData alloc]init];
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    
 
    
    if (self.type == ChartViewTypeBar || self.type == ChartViewTypeVBarHorizontal) {
        
        for (int i = 0; i < datasource.count; i ++) {
            ChartViewModel * model = datasource[i];
            [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:model.y]];
            [xVals addObject:model.xTitle];
        }
            self.xVals = xVals;
        
        BarChartDataSet *set1 = nil;
        if ( self.barChart.data.dataSetCount > 0)
        {
            set1 = (BarChartDataSet *) self.barChart.data.dataSets[0];
            set1.values = yVals;
            self.barChart.data.dataSets = yVals;
            [ self.barChart notifyDataSetChanged];
        }
        else
        {
            set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@""];
            set1.colors = ChartColorTemplates.vordiplom;
            set1.drawValuesEnabled = YES;
            set1.stackLabels = xVals;
            NSMutableArray *dataSets = [[NSMutableArray alloc] init];
            [dataSets addObject:set1];
            
            BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
            data.barWidth = 0.6;
            [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];//文字字体
            
            self.barChart.data = data;
            
       
        }
        [ self.barChart setNeedsDisplay];
    }else if (self.type == ChartViewTypePieInSide || self.type == ChartViewTypePieOutSide) {
        
        for (int i = 0; i < datasource.count; i ++) {
            ChartViewModel * model = datasource[i];
            [yVals addObject:[[PieChartDataEntry alloc] initWithValue:model.y label:model.xTitle]];
             
            [xVals addObject:model.xTitle];
        }
              self.xVals = xVals;
        
        PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:yVals label:@""];
        dataSet.sliceSpace = 2.0;
        // add a lot of colors
        NSMutableArray *colors = [[NSMutableArray alloc] init];
        [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
        [colors addObjectsFromArray:ChartColorTemplates.joyful];
        [colors addObjectsFromArray:ChartColorTemplates.colorful];
        [colors addObjectsFromArray:ChartColorTemplates.liberty];
        [colors addObjectsFromArray:ChartColorTemplates.pastel];
        [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
        
        dataSet.colors = colors;
        
        dataSet.valueLinePart1OffsetPercentage = 0.8;
        dataSet.valueLinePart1Length = 0.2;
        dataSet.valueLinePart2Length = 0.4;
        //    内容显示在圈里还是在标注线上
        if (self.type == ChartViewTypePieOutSide) {
            dataSet.xValuePosition = PieChartValuePositionOutsideSlice;
            dataSet.yValuePosition = PieChartValuePositionOutsideSlice;
        }else if (self.type == ChartViewTypePieInSide) {
            dataSet.xValuePosition = PieChartValuePositionInsideSlice;
            dataSet.yValuePosition = PieChartValuePositionInsideSlice;
        }
        

        
        PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
        
        NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
        pFormatter.numberStyle = NSNumberFormatterPercentStyle;
        pFormatter.maximumFractionDigits = 1;
        pFormatter.multiplier = @1.f;
        pFormatter.percentSymbol = @" %";
        [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];
        [data setValueTextColor:UIColor.blackColor];
        
        self.pieChart.data = data;
        [self.pieChart highlightValues:nil];
        
    }else if (self.type == ChartViewTypeLine ) {
    
    
        NSMutableArray *colors = [[NSMutableArray alloc] init];
        [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
        [colors addObjectsFromArray:ChartColorTemplates.joyful];
        [colors addObjectsFromArray:ChartColorTemplates.colorful];
        [colors addObjectsFromArray:ChartColorTemplates.liberty];
        [colors addObjectsFromArray:ChartColorTemplates.pastel];
        [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        for (int i = 0; i < datasource.count; i ++) {

            LineChartDataSet * dataSet =  [self createLineDataSet:datasource[i] label:[NSString stringWithFormat:@"图例%d" , i + 1] count:i color:colors[i]];

            [dataSets addObject:dataSet];
        }


        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        [data setValueTextColor:UIColor.whiteColor];
        [data setValueFont:[UIFont systemFontOfSize:9.f]];
        
        _lineChart.xAxis.drawGridLinesEnabled = NO;

        _lineChart.data = data;
        
    }else if (self.type == ChartViewTypeVLineHorizontal) {
        

        for (int i = 0; i < datasource.count; i++)
        {
            ChartViewModel * model = datasource[i];
            [yVals addObject:[[ChartDataEntry alloc] initWithX:i y:model.y]];
        }
        
        LineChartDataSet *set1 = nil;
        if (_lineChart.data.dataSetCount > 0)
        {
            set1 = (LineChartDataSet *)_lineChart.data.dataSets[0];
            set1.values = yVals;
            [_lineChart.data notifyDataChanged];
            [_lineChart notifyDataSetChanged];
        }
        else
        {
            set1 = [[LineChartDataSet alloc] initWithValues:yVals label:@""];
            
            set1.drawIconsEnabled = NO;
            
            set1.lineDashLengths = @[@5.f, @2.5f];
            set1.highlightLineDashLengths = @[@5.f, @2.5f];
            [set1 setColor:UIColor.blackColor];
            [set1 setCircleColor:UIColor.blackColor];
            set1.lineWidth = 1.0;
            set1.circleRadius = 3.0;
            set1.drawCircleHoleEnabled = NO;
            set1.valueFont = [UIFont systemFontOfSize:9.f];
            set1.formLineDashLengths = @[@5.f, @2.5f];
            set1.formLineWidth = 1.0;
            set1.formSize = 15.0;

            
            NSArray *gradientColors = @[
                                        (id)[ChartColorTemplates colorFromString:@"#00ff0000"].CGColor,
                                        (id)[ChartColorTemplates colorFromString:@"#ffff0000"].CGColor
                                        ];
            CGGradientRef gradient = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
            
            set1.fillAlpha = 1.f;
            set1.fill = [ChartFill fillWithLinearGradient:gradient angle:90.f];
            set1.drawFilledEnabled = YES;
            
            CGGradientRelease(gradient);
            
            NSMutableArray *dataSets = [[NSMutableArray alloc] init];
            [dataSets addObject:set1];
            
            LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
            
            _lineChart.data = data;
        }
        
        
    }
    
    
  
    
    return data;
}


- (LineChartDataSet *)createLineDataSet:(NSMutableArray *)datasource label:(NSString *)label count:(NSInteger)count color:(UIColor *)color{
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < datasource.count; i++)
    {
        ChartViewModel * model = datasource[i];
        [yVals addObject:[[ChartDataEntry alloc] initWithX:i y:model.y]];
    }
    LineChartDataSet *set1 = nil;
    
    if (_lineChart.data.dataSetCount > 0)
    {
        for (int i = 0; i < _lineChart.data.dataSets.count; i ++) {
            set1 = (LineChartDataSet *)_lineChart.data.dataSets[i];
            set1.values = yVals;
            [_lineChart.data notifyDataChanged];
            [_lineChart notifyDataSetChanged];
        }
    }
    else
    {
        set1 = [[LineChartDataSet alloc] initWithValues:yVals label:label];
        set1.axisDependency = AxisDependencyLeft;

        

        [set1 setColor:color];
        [set1 setCircleColor:UIColor.whiteColor];
        set1.lineWidth = 2.0;
        set1.circleRadius = 3.0;
        set1.fillAlpha = 65/255.0;
        set1.fillColor = [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f];
        set1.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
        set1.drawCircleHoleEnabled = NO;
        
        

        
        return set1;
    }
    return NULL;
    
}




- (void)setDataSource:(NSMutableArray<ChartViewModel *> *)dataSource {
    _dataSource = dataSource;
    [self getData:dataSource];
}
- (void)setDesc:(NSString *)desc {
    _desc = desc;
    if (_pieChart) {
            _pieChart.descriptionText = desc;
    }
    if (_barChart) {
            _barChart.descriptionText = desc;
    }
    if (_lineChart) {
        _lineChart.descriptionText = desc;
    }


}
- (void)setNoDtaaText:(NSString *)noDtaaText {
    _noDtaaText = noDtaaText;
    if (_pieChart) {
        _pieChart.noDataText = noDtaaText;
    }
    if (_barChart) {
        _barChart.noDataText = noDtaaText;
    }
    if (_lineChart) {
        _lineChart.noDataText = noDtaaText;
    }

}
- (void)setLeftNegativeSuffix:(NSString *)leftNegativeSuffix {
    
    _leftNegativeSuffix = leftNegativeSuffix;
    if (_pieChart) {
        NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
        pFormatter.numberStyle = NSNumberFormatterPercentStyle;
        pFormatter.maximumFractionDigits = 1;
        pFormatter.multiplier = @1.f;
        pFormatter.percentSymbol = leftNegativeSuffix;
        
        [self.pieChart.data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
    }
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.maximumFractionDigits = 1;
    pFormatter.negativeSuffix = leftNegativeSuffix;
    pFormatter.positiveSuffix = leftNegativeSuffix;
    if (_barChart) {
           self.barChart.leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:pFormatter];
    }
    if (_lineChart) {
            self.lineChart.leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:pFormatter];
    }


    
}
- (NSMutableArray *)setDataWithy:(NSArray *)y xtitle:(NSArray *)xtitle {
    
    self.xVals = xtitle;
    NSMutableArray * data = [NSMutableArray array];
    for (int i = 0; i < y.count; i ++) {
        ChartViewModel * model = [ChartViewModel new];
        model.xTitle = xtitle[i];
        model.y = [y[i] doubleValue];
        [data addObject:model];
    }
    if (self.type == ChartViewTypeLine) {
        return data;
    }
    
    _dataSource = data;
    [self getData:data];
    
    return data;
}
- (void)setLinedataSource:(NSMutableArray<NSMutableArray *> *)linedataSource {
    _linedataSource = linedataSource;
    self.type = ChartViewTypeLine;
    [self getData:linedataSource];
}


- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
   
    if (self.selectBlock) {
            self.selectBlock(chartView, entry, highlight.x);
    }

    
}

- (void)chartViewDidSelect:(void (^)(ChartViewBase *, ChartDataEntry *, NSInteger))block {
    
    if (block) {
        self.selectBlock = block;
    }
}
- (void)setDelegate:(id<ChartViewDelegate>)delegate {
    
    _delegate = delegate;
    if (_pieChart) {
        _pieChart.delegate = delegate;
    }
    if (_barChart) {
        _barChart.delegate = delegate;
    }
    if (_lineChart) {
        _lineChart.delegate = delegate;
    }
    
}
- (void)addLimitData:(CGFloat)data text:(NSString *)text {
    ChartLimitLine *ll1 = [[ChartLimitLine alloc] initWithLimit:data label:text];
    ll1.lineWidth = 4.0;
    ll1.lineDashLengths = @[@5.f, @5.f];
    ll1.labelPosition = ChartLimitLabelPositionLeftTop;
    ll1.valueFont = [UIFont systemFontOfSize:10.0];
    if (_barChart) {
        [_barChart.leftAxis addLimitLine:ll1];
    }
    if (_lineChart) {
        [_lineChart.leftAxis addLimitLine:ll1];
    }
}
- (void)setIsxAxisTitle:(BOOL)isxAxisTitle {
    
    _isxAxisTitle = isxAxisTitle;
    
    if (isxAxisTitle) {
        if (_barChart) {
            self.barChart.xAxis.valueFormatter = [[ChartDefaultValueFomatter alloc]initWithCount:_dataSource.count values:self.xVals];
            self.barChart.legend.enabled = NO;
        }
        if (_lineChart ) {
            self.lineChart.xAxis.valueFormatter = [[ChartDefaultValueFomatter alloc]initWithCount:_dataSource.count values:self.xVals];
            self.lineChart.legend.enabled = NO;
        }
    }

}
- (void)setBalloonViewEnabled:(BOOL)balloonViewEnabled{
    _balloonViewEnabled = balloonViewEnabled;
    if (balloonViewEnabled) {
        BalloonMarker *marker = [[BalloonMarker alloc]
                                 initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
                                 font: [UIFont systemFontOfSize:12.0]
                                 textColor: UIColor.whiteColor
                                 insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
     
        if (_lineChart) {
            marker.chartView = _lineChart;
            marker.minimumSize = CGSizeMake(80.f, 40.f);
            _lineChart.marker = marker;
        }
        if (_barChart) {
            marker.chartView = _barChart;
            marker.minimumSize = CGSizeMake(80.f, 40.f);
            _barChart.marker = marker;
        }
    }
}
- (void)drawPieChartHoleEnabled:(BOOL)enabled text:(NSString *)text {
    
    self.pieChart.drawHoleEnabled = enabled;
    if (self.pieChart.isDrawHoleEnabled == YES) {
        self.pieChart.drawCenterTextEnabled = YES;
        self.pieChart.centerText = text;
    }
}

- (void)addLayoutConstraintWithView:(UIView *)view {
    
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *topCos = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [self addConstraint:topCos];
    
    NSLayoutConstraint *leftCos = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    [self addConstraint:leftCos];
    
    NSLayoutConstraint *rightCos = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    [self addConstraint:rightCos];
    
    NSLayoutConstraint *bottomCos = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self addConstraint:bottomCos];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
