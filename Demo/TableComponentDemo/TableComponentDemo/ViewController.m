//
//  ViewController.m
//  YHTableViewDemo
//
//  Created by pengehan on 2019/4/10.
//  Copyright © 2019 com.yohanpeng. All rights reserved.
//

#import "ViewController.h"
#import "TableViewModel.h"

@interface ViewController ()

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) TableViewModel *viewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
    
    self.viewModel = [[TableViewModel alloc]initWithTable:self.tableView];
    
    [self.viewModel registerCellClass:@[@"TableViewCell"] sectionHFViewClass:@[]];
    
    [self.viewModel fetch:^(NSError *error, NSArray<YHTableUIModel *> *arr) {
        [self.viewModel refreshTableView:arr];
    }];
    
//
//    [self.viewModel refreshTableView:@[uiModel]];
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
    }
    return _tableView;
}



@end
