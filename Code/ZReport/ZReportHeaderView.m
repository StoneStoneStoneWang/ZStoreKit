//
//  ZReportHeaderView.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZReportHeaderView.h"

@import Masonry;
@import SToolsKit;

@interface ZReportHeaderView ()

@property (nonatomic ,strong) UILabel *textLabel;

@end
@implementation ZReportHeaderView

- (UILabel *)textLabel {
    
    if (!_textLabel) {
        
        _textLabel = [UILabel new];
        
        _textLabel.font = [UIFont systemFontOfSize:15];
        
        _textLabel.textAlignment = NSTextAlignmentCenter;
        
        _textLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#333333"];
        
        _textLabel.text = @"您的举报十分关键,我们会根据您的举报审核";
    }
    return _textLabel;
}

@end
