//
//  ChartViewModel.m
//  ChartsDemo
//
//  Created by 软件技术中心 on 2017/10/23.
//  Copyright © 2017年 dcg. All rights reserved.
//

#import "ChartViewModel.h"

@implementation ChartViewModel

- (NSString *)description {
    return [NSString stringWithFormat:@"x = %@   y= %@" , self.xTitle , @(self.y)];
}


@end
