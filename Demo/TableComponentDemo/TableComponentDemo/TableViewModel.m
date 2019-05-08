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
    
    //异步请求数据
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        YHTableUIModel *uiModel = [[YHTableUIModel alloc]initWithBusinessId:@""];
        for (NSInteger i = 0; i < 10 ; i++) {
            YHTableCellModel *cellModel = [[YHTableCellModel alloc]initWithBusinessId:@"" cellClass:@"TableViewCell"];
            [cellModel fillDataAndRefreshHeight:[NSString stringWithFormat:@"%ld",i]];
            [uiModel.arr_cellModels addObject:cellModel];
        }
        
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil,@[uiModel]);
            });
        }
    });
}

@end
