//
//  ZPublishHeaderView.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZPublishHeaderView.h"
@import SToolsKit;
@import Masonry;

@interface ZPublishHeaderView()

@property (nonatomic ,strong , readwrite) WLBaseTextField *textField;

@property (nonatomic ,strong) UIView *line;

@end

@implementation ZPublishHeaderView

- (UIView *)line {
    
    if (!_line) {
        
        _line = [UIView new];
        
        _line.backgroundColor = [UIColor s_transformToColorByHexColorStr:@"#e1e1e1"];
    }
    return _line;
}
- (WLBaseTextField *)textField {
    
    if (!_textField) {
        
        _textField = [[WLBaseTextField alloc] initWithFrame:CGRectZero];
        
        _textField.placeholder = @"有趣的话题吸引更多人看哦";
    }
    return _textField;
}
- (void)commitInit {
    [super commitInit];
    
    [self addSubview:self.textField];
    
    [self addSubview:self.line];
    
    self.backgroundColor = [UIColor whiteColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.centerY.equalTo(self);
        
        make.right.mas_equalTo(-15);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        
        make.height.mas_equalTo(1);
    }];
}
@end
