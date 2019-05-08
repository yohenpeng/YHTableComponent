//
//  YHTableViewUIModel.m
//  YHTableViewDemo
//
//  Created by pengehan on 2019/4/11.
//  Copyright © 2019 com.yohanpeng. All rights reserved.
//

#import "YHTableUIModel.h"

static double dynamicCalculateHeight(NSString *classString,id model){
    if (classString == nil) {
        return 0;
    }
    Class class = NSClassFromString(classString);
    
    if (class == nil) {
        return 0;
    }
    
    SEL sel;
    if ([class respondsToSelector:@selector(calculateHeight:)]) {
        sel = @selector(calculateHeight:);
    } else {
        return 0;
    }
    
    IMP imp = [class methodForSelector:sel];
    double (*calculateHeight)(id ,SEL,id);
    calculateHeight = (double (*)(id,SEL,id))imp;
    return calculateHeight(class, sel, model);
}

#pragma mark ----------
#pragma mark ---------- YHTableUIModel ------------
@interface YHTableUIModel ()

@property (copy, nonatomic, readwrite) NSString *sBusinessId;

@end

@implementation YHTableUIModel

- (instancetype)initWithBusinessId:(NSString *)businessId{
    self = [super init];
    if (self) {
        _sBusinessId = [businessId copy];
    }
    return self;
}

- (NSMutableArray<YHTableCellModel *>*) arr_cellModels{
    if (!_arr_cellModels) {
        _arr_cellModels = [NSMutableArray new];
    }
    return _arr_cellModels;
}

@end


#pragma mark ----------
#pragma mark ---------- YHTableSectionHeaderFooterModel ------------
@interface YHTableSectionHeaderFooterModel ()

@property (copy, nonatomic, readwrite) NSString *sBusinessId;
@property (copy, nonatomic, readwrite) NSString *sViewClassId;
@property (strong, nonatomic, readwrite) id viewData;

@end

@implementation YHTableSectionHeaderFooterModel

- (instancetype)initWithBusinessId:(NSString *)businessId viewClass:(nonnull NSString *)viewClassId{
    self = [super init];
    if (self) {
        _sBusinessId =  [businessId copy];
        _sViewClassId = [viewClassId copy];
    }
    return self;
}

- (void)fillDataAndRefreshHeight:(id)viewData{
    _viewData = viewData;
    _viewHeight = @(dynamicCalculateHeight(_sViewClassId, _viewData));
}


@end

#pragma mark ----------
#pragma mark ---------- YHTableCellModel ------------
@interface YHTableCellModel ()

@property (copy, nonatomic, readwrite) NSString *sBusinessId;
@property (copy, nonatomic, readwrite) NSString *sCellClassId;
@property (strong, nonatomic, readwrite) id cellData;

@end

@implementation YHTableCellModel

- (instancetype)initWithBusinessId:(NSString *)businessId cellClass:(nonnull NSString *)cellClassId{
    self = [super init];
    if (self) {
        _sBusinessId = [businessId copy];
        _sCellClassId = [cellClassId copy];
    }
    return self;
}

- (void)fillDataAndRefreshHeight:(id)cellData{
    _cellData = cellData;
    _cellHeight = @(dynamicCalculateHeight(_sCellClassId, _cellData));
}

@end
