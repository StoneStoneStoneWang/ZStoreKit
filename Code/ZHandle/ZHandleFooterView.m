//
//  ZHandleFooterView.m
//  ZFragment
//
//  Created by three stone 王 on 2019/10/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZHandleFooterView.h"
@import Masonry;
@import SToolsKit;
#import "ZFragmentConfig.h"


@implementation ZhandleButton

- (void)layoutButtonWithImageTitleSpace:(CGFloat)space
{
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
    labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

@end

@interface ZHandleFooterView()

@property (nonatomic ,strong ,readwrite) ZhandleButton *completeItem;

@end

@implementation ZHandleFooterView

- (ZhandleButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = [ZhandleButton buttonWithType:UIButtonTypeCustom];
        
        _completeItem.tag = 301;
        
        [_completeItem setBackgroundImage:[UIImage s_transformFromHexColor:@ZFragmentColor] forState:UIControlStateNormal];
        
        [_completeItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@ZFragmentColor]] forState:UIControlStateHighlighted];
        
        [_completeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_completeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        [_completeItem setImage:[UIImage imageNamed:@ZGoldIcon] forState:UIControlStateNormal];
        
        [_completeItem setImage:[UIImage imageNamed:@ZGoldIcon] forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@ZGoldIcon forState:UIControlStateNormal];
        
        [_completeItem setTitle:@ZGoldIcon forState:UIControlStateHighlighted];
        
        _completeItem.titleLabel.font = [UIFont systemFontOfSize:15];
        
        _completeItem.layer.cornerRadius = 50;
        
        _completeItem.layer.masksToBounds = true;
    }
    return _completeItem;
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.completeItem];
        
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(context, CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds));//移动画笔到指定坐标点
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);//填充颜色
    CGContextAddArc(context, CGRectGetWidth(self.bounds) / 2 ,  300 , 300, 0, M_PI / 2, true);
    CGContextDrawPath(context, kCGPathFill); //填充路径
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(100);
        
        make.centerX.equalTo(self.mas_centerX);
        
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.completeItem layoutButtonWithImageTitleSpace:5];
}
@end
