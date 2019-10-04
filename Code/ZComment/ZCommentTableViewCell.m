//
//  ZCommentTableViewCell.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZCommentTableViewCell.h"
@import SToolsKit;
@import Masonry;
@import SDWebImage;

@interface ZCommentTableViewCell ()

@end

@implementation ZCommentTableViewCell


@end

@interface ZCommentTotalTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;
@end

@implementation ZCommentTotalTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.numberOfLines = 1;
        
        _titleLabel.text = @"全部评论";
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.titleLabel];
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        
        make.left.mas_equalTo(15);
    }];
}
@end

@interface ZCommentRectangleTableViewCell ()

@end

@implementation ZCommentRectangleTableViewCell

- (void)commitInit {
    [super commitInit];
    
    self.backgroundColor = [UIColor clearColor];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end

@interface ZCommentNoMoreTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;

@end

@implementation ZCommentNoMoreTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.numberOfLines = 1;
        
        _titleLabel.font = [UIFont systemFontOfSize:13];
        
        _titleLabel.text = @"没有更多数据了";
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)commitInit {
    [super commitInit];
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self);
    }];
}

@end

@interface ZCommentFailedTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;

@end

@implementation ZCommentFailedTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.numberOfLines = 1;
        
        _titleLabel.font = [UIFont systemFontOfSize:13];
        
        _titleLabel.text = @"网络错误,点击重新拉取";
        
        _titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@ZFragmentColor];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)commitInit {
    [super commitInit];
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self);
    }];
}

@end

@interface ZCommentEmptyTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;

@end

@implementation ZCommentEmptyTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.numberOfLines = 1;
        
        _titleLabel.font = [UIFont systemFontOfSize:13];
        
        _titleLabel.text = @"暂无评论";
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)commitInit {
    [super commitInit];
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self);
    }];
}

@end

@interface ZCommentContentTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *nameLabel;

@property (nonatomic ,strong) UILabel *timeLabel;

@property (nonatomic ,strong) UIButton *moreItem;

@property (nonatomic ,strong) ZCommentBean *commentBean;

@end

@implementation ZCommentContentTableViewCell

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [UIImageView new];
        
        _iconImageView.contentMode = UIViewContentModeCenter;
        
        _iconImageView.layer.cornerRadius = 20;
        
        _iconImageView.layer.masksToBounds = true;
    }
    return _iconImageView;
}
- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        
        _nameLabel = [UILabel new];
        
        _nameLabel.font = [UIFont systemFontOfSize:15];
        
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        
        _nameLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#333333"];
        
    }
    return _nameLabel;
}
- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        
        _timeLabel = [UILabel new];
        
        _timeLabel.font = [UIFont systemFontOfSize:12];
        
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        
        _timeLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#999999"];
        
    }
    return _timeLabel;
}
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.font = [UIFont systemFontOfSize:13];
        
        _titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#666666"];
        
        _titleLabel.numberOfLines = 0;
        
    }
    return _titleLabel;
}

- (UIButton *)moreItem {
    
    if (!_moreItem) {
        
        _moreItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_moreItem setImage:[UIImage imageNamed:@ZMoreIcon] forState:UIControlStateNormal];
    }
    return _moreItem;
}

- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.iconImageView];
    
    [self.contentView addSubview:self.nameLabel];
    
    [self.contentView addSubview:self.timeLabel];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.moreItem];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.moreItem addTarget:self action:@selector(onMoreItemClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setComment:(ZCommentBean *)comment {
    
    self.commentBean = comment;
    
    self.nameLabel.text = comment.users.nickname;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_200,h_200",comment.users.headImg]] placeholderImage:[UIImage imageNamed:@ZLogoIcon] options:SDWebImageRefreshCached];
    
    self.timeLabel.text = [[NSString stringWithFormat:@"%ld",comment.intime / 1000] s_convertToDate:SDateTypeDateStyle];
    
    self.titleLabel.text = comment.content;
}
- (void)onMoreItemClick {
    
    if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(onMoreItemClick:)]) {
        
        [self.mDelegate onMoreItemClick:self.commentBean];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(15);
        
        make.height.width.mas_equalTo(40);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        
        make.bottom.equalTo(self.iconImageView).offset(-1);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        
        make.top.equalTo(self.iconImageView).offset(1);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-40);
        
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        
        make.top.equalTo(self.iconImageView.mas_bottom).offset(15);
        
    }];
    
    [self.moreItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self.iconImageView);
    }];
}

@end
