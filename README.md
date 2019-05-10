# YHTableComponent
#### YHTableComponent优点：

1. 更好的管理TableView数据源，特别是需要灵活配置展示项目的时候，按照以前实现协议DataSource和Delegate的时候会写很多HardCode，让人不堪其烦。在YHTableComponent中使用YHUIModel对象的数组来管理数据源，逻辑清晰。
2. 支持异步异步计算Cell、SectionHeader、SectionFooter高度， 在传递DataModel给到YHTableSectionHeaderFooterModel、YHTableCellModel的时候，就会调用各个类实现的calculateHeight方法计算并保存高度。

Cell、SectionHeader、SectionFooter需实现以下协议

```objective-c
@protocol YHTableViewUIDelegate <NSObject>

@required
//计算高度
+ (CGFloat)calculateHeight:(id)dataModel;
@optional
//填充内容
- (void)fillData:(id)data;

@end
```



ViewModel中组合数据源：

```objective-c
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
```



* 目前只提供Objective-C版本