//
//  YHTableViewModel.m
//  YHTableViewDemo
//
//  Created by 彭依汉 on 2019/5/6.
//  Copyright © 2019 com.yohanpeng. All rights reserved.
//

#import "YHTableViewModel.h"

@interface YHTableViewModel ()

@property (weak, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray<YHTableUIModel *> *arr_UIModel;

@end

@implementation YHTableViewModel

#pragma mark ----------
#pragma mark ---------- life cycle ------------
- (instancetype)initWithTable:(UITableView *)tableView{
    self = [super init];
    if (self) {
        self.tableView = tableView;
        [self configTableView];
    }
    return self;
}

- (void)refreshTableView:(NSArray<YHTableUIModel *> *)arr_UIModel{
    _arr_UIModel = [NSMutableArray arrayWithArray:arr_UIModel];
    [self.tableView reloadData];
    
}

- (void)configTableView{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)registerCellClass:(NSArray<NSString *> *)arr_cellClass sectionHFViewClass:(NSArray<NSString *> *)arr_sectionHFView{
    for (NSString *item in arr_cellClass) {
        [self.tableView registerClass:[NSClassFromString(item) class]  forCellReuseIdentifier:item];
    }
    for (NSString *item in arr_sectionHFView) {
        [self.tableView registerClass:[NSClassFromString(item) class] forHeaderFooterViewReuseIdentifier:item];
    }
}

- (void)registerCellNib:(NSArray<NSString *> *)arr_cellClass sectionHFViewNib:(NSArray<NSString *> *)arr_sectionHFView{
    for (NSString *item in arr_cellClass) {
        UINib *nib = [UINib nibWithNibName:item bundle:[NSBundle mainBundle]];
        [self.tableView registerNib:nib forCellReuseIdentifier:item];
    }
    
    for (NSString *item in arr_sectionHFView) {
        UINib *nib = [UINib nibWithNibName:item bundle:[NSBundle mainBundle]];
        [self.tableView registerNib:nib forCellReuseIdentifier:item];
    }
}

- (void)fetch:(void (^)(NSError *error,NSArray<YHTableUIModel *>* arr))completion{
    if (completion) {
        completion(nil,@[]);
    }
}

#pragma mark ----------
#pragma mark ----------  UITableViewDataSource ------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arr_UIModel.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    YHTableUIModel *uiModel = [self.arr_UIModel objectAtIndex:section];
    return uiModel.arr_cellModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHTableCellModel *cellModel = [self cellModelAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellModel.sCellClassId];
    if ([cell respondsToSelector:@selector(fillData:)]) {
        [(id <YHTableViewUIDelegate>)cell fillData:cellModel];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    YHTableSectionHeaderFooterModel *headerModel = [self headerModelInSection:section];
    if (headerModel.sViewClassId.length) {
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerModel.sViewClassId];
        if ([headerView respondsToSelector:@selector(fillData:)]) {
            [(id <YHTableViewUIDelegate>)headerView fillData:headerModel];
        }
        return headerView;
    } else {
        return [UIView new];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    YHTableSectionHeaderFooterModel *fotterModel = [self footerModelInSection:section];
    if (fotterModel.sViewClassId.length) {
        UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:fotterModel.sViewClassId];
        if ([footerView respondsToSelector:@selector(fillData:)]) {
           [(id <YHTableViewUIDelegate>)footerView fillData:fotterModel];
        }
        return footerView;
    } else {
        return [UIView new];
    }
}

#pragma mark ----------
#pragma mark ---------- UITableViewDelegate ------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YHTableCellModel *cellModel = [self cellModelAtIndexPath:indexPath];
    if(self.didSelectBlock){
        self.didSelectBlock(self.tableView, cellModel, indexPath);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHTableCellModel *cellModel = [self cellModelAtIndexPath:indexPath];
    return [cellModel.cellHeight floatValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    YHTableUIModel *uiModel = [self.arr_UIModel objectAtIndex:section];
    YHTableSectionHeaderFooterModel *headerModel = uiModel.sectionHeaderModel;
    if (headerModel) {
        return [headerModel.viewHeight floatValue];
    } else {
        return CGFLOAT_MIN;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    YHTableUIModel *uiModel = [self.arr_UIModel objectAtIndex:section];
    YHTableSectionHeaderFooterModel *footerModel = uiModel.sectionFooterModel;
    if (footerModel) {
        return [footerModel.viewHeight floatValue];
    } else {
        return CGFLOAT_MIN;
    }
}

#pragma mark ----------
#pragma mark ---------- DataSource Helper ------------
- (YHTableCellModel *)cellModelAtIndexPath:(NSIndexPath *)indexPath{
    YHTableUIModel *uiModel = [self.arr_UIModel objectAtIndex:indexPath.section];
    YHTableCellModel *cellModel = [uiModel.arr_cellModels objectAtIndex:indexPath.row];
    return cellModel;
}

- (YHTableSectionHeaderFooterModel *)headerModelInSection:(NSUInteger)section{
    YHTableUIModel *uiModel = [self.arr_UIModel objectAtIndex:section];
    return uiModel.sectionHeaderModel;
}

- (YHTableSectionHeaderFooterModel *)footerModelInSection:(NSUInteger)section{
    YHTableUIModel *uiModel = [self.arr_UIModel objectAtIndex:section];
    return uiModel.sectionFooterModel;
}


@end
