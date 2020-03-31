//
//  YHTableViewCell.m
//  YHTableViewDemo
//
//  Created by 彭依汉 on 2019/5/6.
//  Copyright © 2019 com.yohanpeng. All rights reserved.
//

#import "TableViewCell.h"



@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (CGFloat)calculateHeight:(id)dataModel{
    NSInteger num = [dataModel integerValue];
    return num%2 ? 50 : 100;
}

- (void)fillData:(id)data{
    YHTableCellModel *cellModel = data;
    self.textLabel.text = cellModel.cellData;
    NSInteger num = [cellModel.cellData integerValue];
    self.contentView.backgroundColor = num%2 ? [UIColor redColor] : [UIColor blueColor];
}

@end
