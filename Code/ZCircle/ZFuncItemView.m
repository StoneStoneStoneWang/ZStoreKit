//
//  ZFuncItemView.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZFuncItemView.h"
@import SToolsKit;
@import Masonry;
@interface ZFuncItemView ()

@property (nonatomic ,strong) UIButton *watchItem;

@property (nonatomic ,strong) UIButton *funItem;

@property (nonatomic ,strong) UIButton *moreItem;

@property (nonatomic ,strong) UIButton *commentItem;

@property (nonatomic ,assign) BOOL isMy;

@end

@implementation ZFuncItemView

- (UIButton *)watchItem {
    
    if (!_watchItem) {
        
        _watchItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //        [_watchItem setImage:[UIImage imageNamed:@ZWatchIcon] forState:UIControlStateNormal];
        
        _watchItem.titleLabel.font = [UIFont systemFontOfSize:11];
        
        [_watchItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#666666"] forState:UIControlStateNormal];
        
        [_watchItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#666666"] forState:UIControlStateHighlighted];
    }
    return _watchItem;
}

- (UIButton *)funItem {
    
    if (!_funItem) {
        
        _funItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_funItem setImage:[UIImage imageNamed:@ZFunNormalIcon] forState:UIControlStateNormal];
        
        [_funItem setImage:[UIImage imageNamed:@ZFunSelectedIcon] forState:UIControlStateSelected];
        
        _funItem.titleLabel.font = [UIFont systemFontOfSize:11];
        
        [_funItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#666666"] forState:UIControlStateNormal];
        
        [_funItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#666666"] forState:UIControlStateSelected];
    }
    return _funItem;
}

- (UIButton *)moreItem {
    
    if (!_moreItem) {
        
        _moreItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_moreItem setImage:[UIImage imageNamed:@ZMoreIcon] forState:UIControlStateNormal];
    }
    return _moreItem;
}

- (UIButton *)commentItem {
    
    if (!_commentItem) {
        
        _commentItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _commentItem.titleLabel.font = [UIFont systemFontOfSize:11];
        
        [_commentItem setImage:[UIImage imageNamed:@ZCommentIcon] forState:UIControlStateNormal];
        
        [_commentItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#666666"] forState:UIControlStateNormal];
        
        [_commentItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#666666"] forState:UIControlStateHighlighted];
    }
    return _commentItem;
}
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self commitInit];
    }
    return self;
}
- (void)commitInit {
    
    [self addSubview:self.watchItem];
    
    [self addSubview:self.commentItem];
    
    [self addSubview: self.funItem];
    
    [self addSubview:self.moreItem];
    
    [self.watchItem addTarget:self action:@selector(onWatchItemClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.commentItem addTarget:self action:@selector(onCommentItemClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.funItem addTarget:self action:@selector(onFunItemClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.moreItem addTarget:self action:@selector(onMoreItemClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)onWatchItemClick {
    
    if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(onFuncItemClick:)]) {
        
        [self.mDelegate onFuncItemClick:ZFuncItemTypeWatch];
    }
}

- (void)onFunItemClick {
    
    if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(onFuncItemClick:)]) {
        
        [self.mDelegate onFuncItemClick:ZFuncItemTypeFun];
    }
}
- (void)onCommentItemClick {
    
    if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(onFuncItemClick:)]) {
        
        [self.mDelegate onFuncItemClick:ZFuncItemTypeComment];
    }
}

- (void)onMoreItemClick {
    
    if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(onFuncItemClick:)]) {
        
        [self.mDelegate onFuncItemClick:ZFuncItemTypeMore];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.watchItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.centerY.equalTo(self);
        
        make.width.mas_equalTo(35);
    }];
    
    [self.commentItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        
        make.width.mas_equalTo(35);
        
        make.left.equalTo(self.watchItem.mas_right);
    }];
    
    [self.funItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        
        make.width.mas_equalTo(35);
        
        make.left.equalTo(self.commentItem.mas_right);
    }];
    
    [self.moreItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        
        make.width.mas_equalTo(35);
        
        make.left.equalTo(self.funItem.mas_right);
    }];
}

- (void)setCircleBean:(ZCircleBean *)circleBean {
    
    [self.funItem setTitle:[NSString stringWithFormat:@" %ld",circleBean.countLaud] forState:UIControlStateNormal];
    
    [self.commentItem setTitle:[NSString stringWithFormat:@" %ld",circleBean.countComment] forState:UIControlStateNormal];
    
    self.funItem.selected = circleBean.isLaud;
}

@end
