//
//  ChartViewModel.h
//  ChartsDemo
//
//  Created by 软件技术中心 on 2017/10/23.
//  Copyright © 2017年 dcg. All rights reserved.
//
@import Charts;
#import <Foundation/Foundation.h>

@interface ChartViewModel : NSObject
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;

@property (nonatomic,retain) NSString * xTitle;
@end
