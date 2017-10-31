//
//  ChartDefaultValueFomatter.h
//  ValleyWaterSource
//
//  Created by 软件技术中心 on 2017/10/25.
//  Copyright © 2017年 lonwin. All rights reserved.
//

@import Charts;
#import <Foundation/Foundation.h>

@interface ChartDefaultValueFomatter : NSObject <IChartAxisValueFormatter>

@property (nonatomic,assign) NSInteger count;
@property (nonatomic,retain) NSArray *values;

- (instancetype)initWithCount:(NSInteger )count values:(NSArray *)values;
@end
