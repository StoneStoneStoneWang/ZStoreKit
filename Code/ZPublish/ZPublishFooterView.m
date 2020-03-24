//
//  ZPublishFooterView.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZPublishFooterView.h"

@import SToolsKit;
@import Masonry;
@interface ZPublishFooterView ()

@property (nonatomic ,strong ,readwrite) UIButton *textItem;

@property (nonatomic ,strong ,readwrite) UIButton *imageItem;

@property (nonatomic ,strong ,readwrite) UIButton *videoItem;

@end

@implementation ZPublishFooterView

- (UIButton *)textItem {
    
    if (!_textItem) {
        
        _textItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _textItem.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [_textItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
        
        [_textItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateHighlighted];
        
        [_textItem setBackgroundImage:[UIImage s_transformFromColor:[UIColor s_transformToColorByHexColorStr: @ZFragmentColor]] forState:UIControlStateNormal];
        
        [_textItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@60",@ZFragmentColor]] forState:UIControlStateHighlighted];
        
        [_textItem setTitle:@"文字" forState: UIControlStateNormal];
        
        [_textItem setTitle:@"文字" forState: UIControlStateHighlighted];
        
        _textItem.layer.cornerRadius = 15;
        
        _textItem.layer.masksToBounds = true;
    }
    return _textItem;
}

- (UIButton *)imageItem {
    
    if (!_imageItem) {
        
        _imageItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _imageItem.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [_imageItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
        
        [_imageItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateHighlighted];
        
        [_imageItem setBackgroundImage:[UIImage s_transformFromColor:[UIColor s_transformToColorByHexColorStr: @ZFragmentColor]] forState:UIControlStateNormal];
        
        [_imageItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@60",@ZFragmentColor]] forState:UIControlStateHighlighted];
        
        [_imageItem setTitle:@"图片" forState: UIControlStateNormal];
        
        [_imageItem setTitle:@"图片" forState: UIControlStateHighlighted];
        
        _imageItem.layer.cornerRadius = 15;
        
        _imageItem.layer.masksToBounds = true;
    }
    return _imageItem;
}

- (UIButton *)videoItem {
    
    if (!_videoItem) {
        
        _videoItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _videoItem.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [_videoItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
        
        [_videoItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateHighlighted];
        
        [_videoItem setBackgroundImage:[UIImage s_transformFromColor:[UIColor s_transformToColorByHexColorStr: @ZFragmentColor]] forState:UIControlStateNormal];
        
        [_videoItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@60",@ZFragmentColor]] forState:UIControlStateHighlighted];
        
        [_videoItem setTitle:@"视频" forState: UIControlStateNormal];
        
        [_videoItem setTitle:@"视频" forState: UIControlStateHighlighted];
        
        _videoItem.layer.cornerRadius = 15;
        
        _videoItem.layer.masksToBounds = true;
    }
    return _videoItem;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self commitInit];
    }
    return self;
}
- (void)commitInit {
    
    [self addSubview:self.textItem];
    
    [self addSubview: self.imageItem];
    
    [self addSubview:self.videoItem];
    
    self.backgroundColor = [UIColor whiteColor];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    
    NSString *version = info[@"CFBundleShortVersionString"];
    
    if ([version compare:@"1.1.0"] == NSOrderedAscending) {
        
        
        CGFloat width = (CGRectGetWidth(self.bounds) - 40) / 2;
        
        [self.textItem mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self);
            
            make.left.mas_equalTo(15);
            
            make.width.mas_equalTo(width);
            
            make.height.mas_equalTo(30);
        }];
        
        [self.imageItem mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self);
            
            make.width.mas_equalTo(width);
            
            make.left.equalTo(self.textItem.mas_right).offset(10);
            
            make.height.mas_equalTo(30);
        }];
        
    } else {
        
        CGFloat width = (CGRectGetWidth(self.bounds) - 70) / 3;
        
        [self.textItem mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self);
            
            make.left.mas_equalTo(15);
            
            make.width.mas_equalTo(width);
            
            make.height.mas_equalTo(30);
        }];
        
        [self.imageItem mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self);
            
            make.width.mas_equalTo(width);
            
            make.left.equalTo(self.textItem.mas_right).offset(10);
            
            make.height.mas_equalTo(30);
        }];
        
        [self.videoItem mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self);
            
            make.width.mas_equalTo(width);
            
            make.left.equalTo(self.imageItem.mas_right).offset(15);
            
            make.height.mas_equalTo(30);
        }];
    }
}

@end

