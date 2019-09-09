//
//  ZReportTableViewCell.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZReportTableViewCell.h"
@import SToolsKit;
@import Masonry;

@interface ZReportTableViewCell()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UIButton *selectItem;

@end

@implementation ZReportTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.font = [UIFont systemFontOfSize:15];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#666666"];
    }
    return _titleLabel;
}

- (UIButton *)selectItem {
    
    if (!_selectItem) {
        
        _selectItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_selectItem setImage:[UIImage imageNamed:@ZNormalIcon] forState:UIControlStateNormal];
        
        [_selectItem setImage:[UIImage imageNamed:@ZSelectedIcon] forState:UIControlStateSelected];
        
        [_selectItem sizeToFit];
        
    }
    return _selectItem;
}
- (void)setReportBean:(ZReportBean *)reportBean {
    _reportBean = reportBean;
    
    self.selectItem.selected = reportBean.isSelected;
    
    self.titleLabel.text = reportBean.title;
    
    self.bottomLineType = ZBottomLineTypeNormal;
}

- (void)commitInit {
    [super commitInit];
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    self.accessoryView = self.selectItem;
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.titleLabel];

}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(10);
        
        make.centerY.equalTo(self);
    }];
    
}
@end
