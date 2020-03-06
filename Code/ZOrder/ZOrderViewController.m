//
//  ZOrderViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/11/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZOrderViewController.h"
#include <stdlib.h>
@import Masonry;
@import SToolsKit;
@import ZBean;
#import "ZFragmentConfig.h"
@interface ZOrderTableViewCell ()

@property (nonatomic ,strong)  UIView *whiteContentView;

@property (nonatomic ,strong) UILabel *iconLabel;

@property (nonatomic ,strong) UILabel *contactLabel;

@property (nonatomic ,strong) UILabel *addressLabel;

@property (nonatomic ,strong) UILabel *isBornLabel;

@end

@implementation ZOrderTableViewCell

- (void)setCircleBean:(ZCircleBean *)circleBean {
    
    self.bottomLineType = ZBottomLineTypeNone;

    NSString *addressText = nil;
    
    BOOL isBorn = false;
    
    for (ZKeyValueBean *keyValue in circleBean.contentMap) {
        
        if ([keyValue.value containsString:@"头/二胎"]) {
            
            self.iconLabel.text =  [keyValue.value componentsSeparatedByString:@":"].lastObject;
        }
        
        if ([keyValue.value containsString:@"服务时间"]) {
            
            self.contactLabel.text = keyValue.value;
        }
        
        if ([keyValue.value containsString:@"详细地址"]) {
            
            addressText = keyValue.value;
        }
        
        if ([keyValue.value containsString:@"address"]) {
            
            NSString *first = [addressText componentsSeparatedByString:@":"].firstObject;
            
            NSString *last = [addressText componentsSeparatedByString:@":"].lastObject;
            
            addressText = [NSString stringWithFormat:@"%@: %@ %@",first,[keyValue.value componentsSeparatedByString:@":"].lastObject,last];
        }
        
        if ([keyValue.value containsString:@"生产状态"]) {
            
            isBorn = [[keyValue.value componentsSeparatedByString:@":"].lastObject isEqualToString:@"是"];
        }
    }
    
    self.addressLabel.text = addressText;
    
    self.isBornLabel.text =  isBorn ? @"已生产" : @"未生产";
}

- (UILabel *)iconLabel {
    
    if (!_iconLabel) {
        
        _iconLabel = [UILabel new];
        
        _iconLabel.font = [UIFont systemFontOfSize:18];
        
        _iconLabel.textAlignment = NSTextAlignmentCenter;
        
        _iconLabel.textColor = [UIColor whiteColor];
        
        _iconLabel.numberOfLines = 1;
        
        _iconLabel.layer.cornerRadius = 30;
        
        _iconLabel.layer.masksToBounds = true;
        
        _iconLabel.backgroundColor = [UIColor s_transformToColorByHexColorStr: @ZFragmentColor];
    }
    return _iconLabel;
}
- (UILabel *)isBornLabel {
    
    if (!_isBornLabel) {
        
        _isBornLabel = [UILabel new];
        
        _isBornLabel.font = [UIFont systemFontOfSize:15];
        
        _isBornLabel.textAlignment = NSTextAlignmentLeft;
        
        _isBornLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#999999"];
        
        _isBornLabel.numberOfLines = 1;
    }
    return _isBornLabel;
}

- (UILabel *)contactLabel {
    
    if (!_contactLabel) {
        
        _contactLabel = [UILabel new];
        
        _contactLabel.font = [UIFont systemFontOfSize:15];
        
        _contactLabel.textAlignment = NSTextAlignmentLeft;
        
        _contactLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#999999"];
        
        _contactLabel.numberOfLines = 1;
    }
    return _contactLabel;
}

- (UILabel *)addressLabel {
    
    if (!_addressLabel) {
        
        _addressLabel = [UILabel new];
        
        _addressLabel.font = [UIFont systemFontOfSize:15];
        
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        
        _addressLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#999999"];
        
        _addressLabel.numberOfLines = 1;
    }
    return _addressLabel;
}

- (UIView *)whiteContentView {
    
    if (!_whiteContentView) {
        
        _whiteContentView = [UIView new];
        
        _whiteContentView.backgroundColor = [UIColor whiteColor];
        
        _whiteContentView.layer.cornerRadius = 5;
        
        _whiteContentView.layer.masksToBounds = true;
    }
    return _whiteContentView;
}
- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.whiteContentView];
    
    [self.whiteContentView addSubview:self.iconLabel];
    
    [self.whiteContentView addSubview:self.isBornLabel];
    
    [self.whiteContentView addSubview:self.contactLabel];
    
    [self.whiteContentView addSubview:self.addressLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.whiteContentView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.mas_equalTo(12);
        
        make.bottom.mas_equalTo(0);
        
        make.right.mas_equalTo(-12);
    }];
    
    [self.iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_equalTo(12);

        make.height.width.mas_equalTo(60);
        
        make.centerY.mas_equalTo(0);
    }];
    
    [self.contactLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.iconLabel.mas_right).offset(12);
        
        make.centerY.mas_equalTo(self.iconLabel.mas_centerY);
    }];
    
    [self.isBornLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.iconLabel.mas_right).offset(12);
        
        make.bottom.mas_equalTo(self.contactLabel.mas_top).offset(-2);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.iconLabel.mas_right).offset(12);
        
        make.top.mas_equalTo(self.contactLabel.mas_bottom).offset(2);
    }];
    
}

@end

@interface ZOrderViewController ()

@property (nonatomic ,strong) NSString *aTag;

@property (nonatomic ,strong) ZOrderBridge *bridge;

@end

@implementation ZOrderViewController

- (ZOrderBridge *)bridge {
    
    if (!_bridge) {
        
        _bridge = [ZOrderBridge new];
    }
    return _bridge;
}
+ (instancetype)createOrder:(NSString *)tag {
    
    return [[self alloc] initWithATag:tag];
}
- (instancetype)initWithATag:(NSString *)tag {
    
    if (self = [super init]) {
        
        self.aTag = tag;
    }
    return self;
}


- (void)onReloadItemClick {
    [super onReloadItemClick];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)configOwnProperties {
    
    
}

- (void)configViewModel {
    
    [self.bridge createTList:self tag:self.aTag];
    
    [self.tableView.mj_header beginRefreshing];
    
    [self.tableView registerClass:[ZOrderTableViewCell class] forCellReuseIdentifier:@"order"];
}

// 小儿黄纳米颗粒
- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    if ([self.parentViewController isKindOfClass:[UINavigationController class]]) {
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.mas_equalTo(0);
            
            make.top.mas_equalTo(KTOPLAYOUTGUARD);
            
            make.bottom.mas_equalTo(0);
        }];
        
    } else {
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.top.right.bottom.mas_equalTo(0);
            
        }];
    }
}
- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZOrderTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"order"];
    
    cell.circleBean = data;
    
    cell.bottomLineType = ZBottomLineTypeNone;

    return cell;
}
- (CGFloat)caculateForCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    return 120;
}
@end

// 黑下金团来天空腿老板 来宝石老板
// 黑下金团来个打工贼
// 出租毕业熊T。无需求 三大本 任务 不需不贪 50一本 保证效率 不回等于自强。打扰勿怪
// 有奶和dps 去三大本提升么
// 本人副本招聘话语 （TL开组速刷 毛暗影之皮 毛绿装 其他都roll 奶妈补助(黑暗符文) 来提升装备各种  来fs=1 ）
// 出 [次级体质秘药] [次级体质秘药] [野性之皮] 现货
// STSM 血色区(前门)(爱与家庭)  毛炼金图纸 (一需多贪) 来DPS。N
// 黑石深渊 救公主前置+mc门+救公主 来N DPS
//  [次级坚韧秘药] [次级体质秘药] [专注秘药] [野性之皮] 出现货
// 所有人都是希望买的便宜 卖的贵
// 柱擎天 60战士 所在工会<Defense of the Ancients> 自己由于啥被踢 心里 没逼数？   大过年的 碰到你们工会这种人 我也是醉了  不服 nga见 本人副本招聘话语 （TL开组速刷 毛暗影之皮 毛绿装 其他都roll 奶妈补助(黑暗符文) 来提升装备各种  来DPS N ）
// TL 速刷T已到位(T无需蓝绿补助) N(黑暗符文补助） DPS
// TL 速刷T(T无需蓝绿补助) N(黑暗符文补助）来各种
// [专注秘药]  [次级坚韧秘药]  [次级体质秘药] [野性之皮] 出现货代工
// 免税收[熟化毛皮][精炼石中盐] 27 [水之精华] 12 [生命精华]3.5 邮寄立取 打扰见谅
// TL 速刷T已到位(T无需蓝绿补助) N(黑暗符文补助）来T 和fs

// TL 速刷T(T无需蓝绿补助) N(黑暗符文补助）来T
//  [野性之皮]。出现货or代工  头腿100血 8法伤 货不多
// JJC 将军 傀儡 3连刷 毛正义之手  来个55+DPS N
// 黑石深渊全通 毕业熊T带 跳骚勿扰 一个半小时速通 来55+法师 =1
// 36魔暴龙皮 +2熟化毛皮+3附文线 + 62硬甲皮
// 参加开荒的 20一件 不参加的30一件 找安妮买[奥妮克希亚鳞片披风] 黑翼每人必备
// 参加开荒的 [奥妮克希亚鳞片披风] 黑翼每人必备 出or代工
// [奥妮克希亚鳞片披风] 没准备的准备了  奥格来交易我 30金一个 跟工会 团的来找我买 不跟工会团的 别找我了  不邮寄 顾不上 最后四个
