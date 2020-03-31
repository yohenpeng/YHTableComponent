//
//  YHTableViewModel.h
//  YHTableViewDemo
//
//  Created by 彭依汉 on 2019/5/6.
//  Copyright © 2019 com.yohanpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YHTableUIModel.h"

typedef void(^DidSelectRowAtIndexPathBlock)(UITableView *tableView,YHTableCellModel *cellModel,NSIndexPath* indexPath);

@interface YHTableViewModel : NSObject <UITableViewDelegate,UITableViewDataSource>

@property (copy, nonatomic) DidSelectRowAtIndexPathBlock didSelectBlock;

- (instancetype)initWithTable:(UITableView *)tableView;


/**
 注册代码实现的Cell

 @param arr_cellClass <#arr_cellClass description#>
 @param arr_sectionHFView <#arr_sectionHFView description#>
 */
- (void)registerCellClass:(NSArray<NSString *> *)arr_cellClass sectionHFViewClass:(NSArray<NSString *> *)arr_sectionHFView;


/**
 注册Xib实现的Cell

 @param arr_cellClass <#arr_cellClass description#>
 @param arr_sectionHFView <#arr_sectionHFView description#>
 */
- (void)registerCellNib:(NSArray<NSString *> *)arr_cellClass sectionHFViewNib:(NSArray<NSString *> *)arr_sectionHFView;

- (void)refreshTableView:(NSArray<YHTableUIModel *> *)arr_UIModel;

- (void)fetch:(void (^)(NSError *error,NSArray<YHTableUIModel *>* arr))completion;

@end

