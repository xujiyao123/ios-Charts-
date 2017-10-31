//
//  TableMaker.h
//  ChartViewDemo
//
//  Created by 软件技术中心 on 2017/10/31.
//  Copyright © 2017年 xujiyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TableMaker : NSObject <UITableViewDataSource , UITableViewDelegate>

@property (nonatomic ,retain) UITableView * tableView;
@property (nonatomic ,retain) UIViewController * superController;

- (instancetype)initWithTableView:(UITableView *)tableView superView:(UIViewController *)controller;
@end
