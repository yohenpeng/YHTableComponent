//
//  TableViewModel.m
//  YHTableViewDemo
//
//  Created by 彭依汉 on 2019/5/8.
//  Copyright © 2019 com.yohanpeng. All rights reserved.
//

#import "TableViewModel.h"

@implementation TableViewModel

- (void)fetch:(void (^)(NSError *, NSArray<YHTableUIModel *> *))completion{
    
    //...
    //异步请求数据
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *array = [NSMutableArray new];
        {//section one
            YHTableUIModel *uiModel = [[YHTableUIModel alloc]initWithBusinessId:kSectionOneId];
            YHTableCellModel *cellModel = [[YHTableCellModel alloc]initWithBusinessId:@"" cellClass:kUserInfoCell];
            [cellModel fillDataAndRefreshHeight:@"yohenpeng"];
            [uiModel.arr_cellModels addObject:cellModel];
            for (NSInteger i = 0; i < 10; i++) {
                cellModel = [[YHTableCellModel alloc]initWithBusinessId:@"" cellClass:kOrderInfoCell];
                [cellModel fillDataAndRefreshHeight:@"orderInfo"];
                [uiModel.arr_cellModels addObject:cellModel];
            }
            [array addObject:uiModel];
        }
        { //section two
            //section header
            YHTableUIModel *uiModel = [[YHTableUIModel alloc]initWithBusinessId:kSectionTwoId];
            uiModel.sectionHeaderModel = [[YHTableSectionHeaderFooterModel alloc]initWithBusinessId:@"" viewClass:kSectionHeaderOneView];
            [uiModel.sectionHeaderModel fillDataAndRefreshHeight:@"sectionHeader"];
            YHTableCellModel *cellModel = [[YHTableCellModel alloc]initWithBusinessId:@"" cellClass:kHealthCircleCell];
            [cellModel fillDataAndRefreshHeight:@"circleInfo"];
            [uiModel.arr_cellModels addObject:cellModel];
            [array addObject:uiModel];
        }
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil,array);
            });
        }
    });
}

@end
