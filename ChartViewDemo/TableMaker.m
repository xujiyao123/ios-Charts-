//
//  TableMaker.m
//  ChartViewDemo
//
//  Created by 软件技术中心 on 2017/10/31.
//  Copyright © 2017年 xujiyao. All rights reserved.
//

#import "TableMaker.h"
#import "BarViewController.h"
#import "Bar2ViewController.h"
#import "PieViewController.h"
#import "LineViewController.h"
#import "Line2ViewController.h"

#define SUBTIELE @[@"BarViewController" , @"Bar2ViewController" , @"PieViewController" , @"LineViewController" , @"Line2ViewController"]
#define TITLE @[@"柱状图" ,@"柱状图横" ,@"饼图" , @"多折线图" , @"折线图（趋势）"]
@implementation TableMaker


- (instancetype)initWithTableView:(UITableView *)tableView superView:(UIViewController *)controller {
    
    self = [super init];
    if (self) {
        
        
        self.tableView = tableView;
        self.superController = controller;
    }
    
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * identifier = @"cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.text = TITLE[indexPath.row];
    cell.detailTextLabel.text = SUBTIELE[indexPath.row];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0: {
            BarViewController * bar = [BarViewController new];
            bar.title = TITLE[indexPath.row];
            [self.superController.navigationController pushViewController:bar animated:YES];
        }
            break;
        case 1: {
            Bar2ViewController * bar = [Bar2ViewController new];
                 bar.title = TITLE[indexPath.row];
            [self.superController.navigationController pushViewController:bar animated:YES];
        }
            break;
        case 2: {
            PieViewController * pie = [PieViewController new];
                 pie.title = TITLE[indexPath.row];
            [self.superController.navigationController pushViewController:pie animated:YES];
        }
            break;
        case 3: {
            LineViewController * line = [LineViewController new];
                 line.title = TITLE[indexPath.row];
            [self.superController.navigationController pushViewController:line animated:YES];
        }
            break;
        case 4: {
            Line2ViewController * line = [Line2ViewController new];
                 line.title = TITLE[indexPath.row];
            [self.superController.navigationController pushViewController:line animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}

@end
