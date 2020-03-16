//
//  ZReportHeaderView.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZReportHeaderView.h"
#import "ZFragmentConfig.h"
@import Masonry;
@import SToolsKit;

@interface ZReportHeaderView ()

@property (nonatomic ,strong) UILabel *textLabel;

@property (nonatomic ,strong) UIView *line;

@end

@implementation ZReportHeaderView

- (UILabel *)textLabel {
    
    if (!_textLabel) {
        
        _textLabel = [UILabel new];
        
        _textLabel.font = [UIFont systemFontOfSize:14];
        
        _textLabel.textAlignment = NSTextAlignmentLeft;
        
        _textLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#333333"];
        
        _textLabel.numberOfLines = 0;
#if ZAppFormGlobalOne
        
        _textLabel.text = @ZReportHeaderText;
        
#elif ZAppFormGlobalTwo
        _textLabel.text = @ZReportHeaderText;
        
#elif ZAppFormGlobalThree
        
        
#endif
    }
    return _textLabel;
}

- (UIView *)line {
    
    if (!_line) {
        
        _line = [[UIView alloc] init];
        
        _line.backgroundColor = [UIColor s_transformToColorByHexColorStr:@"#e1e1e1"];
    }
    return _line;
}
- (void)commitInit {
    [super commitInit];
    
    [self addSubview:self.textLabel];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.line];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(10);
        
        make.right.bottom.mas_equalTo(-10);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        
        make.height.mas_equalTo(1);
    }];
    
}
@end
