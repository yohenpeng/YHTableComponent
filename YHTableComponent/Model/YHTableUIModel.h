//
//  YHTableViewUIModel.h
//  YHTableViewDemo
//
//  Created by pengehan on 2019/4/11.
//  Copyright © 2019 com.yohanpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class YHTableSectionHeaderFooterModel;
@class YHTableCellModel;

@protocol YHTableViewUIDelegate <NSObject>

@required
+ (CGFloat)calculateHeight:(id)dataModel;

- (void)fillData:(id)data;

@end


/**
 对应Section
 */
@interface YHTableUIModel : NSObject
- (instancetype)initWithBusinessId:(NSString *)businessId;

@property (copy, nonatomic, readonly) NSString *sBusinessId;
@property (strong, nonatomic) YHTableSectionHeaderFooterModel* sectionHeaderModel;
@property (strong, nonatomic) NSMutableArray<YHTableCellModel *>* arr_cellModels;
@property (strong, nonatomic) YHTableSectionHeaderFooterModel* sectionFooterModel;
@end


/**
 对应SectionHeader、SectionFooter
 */
@interface YHTableSectionHeaderFooterModel : NSObject
- (instancetype)initWithBusinessId:(NSString *)businessId viewClass:(nonnull NSString *)viewClassId;

- (void)fillDataAndRefreshHeight:(id)viewData;

@property (copy, nonatomic, readonly) NSString *sBusinessId;
@property (copy, nonatomic, readonly) NSString *sViewClassId;
@property (strong, nonatomic) NSNumber* viewHeight;
@property (strong, nonatomic, readonly) id viewData;
@end


/**
 对应Cell
 */
@interface YHTableCellModel : NSObject
- (instancetype)initWithBusinessId:(NSString *)businessId cellClass:(nonnull NSString *)cellClassId;

- (void)fillDataAndRefreshHeight:(id)cellData;

@property (copy, nonatomic, readonly) NSString *sBusinessId;
@property (copy, nonatomic, readonly) NSString *sCellClassId;
@property (strong, nonatomic) NSNumber* cellHeight;
@property (strong, nonatomic, readonly) id cellData;
@end
