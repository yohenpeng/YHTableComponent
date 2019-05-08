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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)calculateHeight:(id)dataModel{
    return 50;
}

- (void)fillData:(id)data{
    YHTableCellModel *cellModel = data;
    self.textLabel.text = cellModel.cellData;
}

@end
