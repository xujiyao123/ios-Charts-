//
//  ChartDefaultValueFomatter.m
//  ValleyWaterSource
//
//  Created by 软件技术中心 on 2017/10/25.
//  Copyright © 2017年 lonwin. All rights reserved.
//

#import "ChartDefaultValueFomatter.h"

@implementation ChartDefaultValueFomatter


- (instancetype)initWithCount:(NSInteger )count values:(NSArray *)values
{
    self = [super init];
    if (self) {
        
        self.count = count;
        self.values = values;
        
    }
    return self;
}


- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    
//    axis.labelCount = self.count;
    
//    NSLog(@"%f" , value);

    return [self.values objectAtIndex:(NSInteger)value];
    
}

@end
