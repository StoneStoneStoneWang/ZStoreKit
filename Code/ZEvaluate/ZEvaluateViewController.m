//
//  ZEvaluateViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/11.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZEvaluateViewController.h"
#import "ZEvaluateTableViewCell.h"
#import "ZReportHeaderView.h"
@import ZBridge;
@import SToolsKit;
#import "ZFragmentConfig.h"
@interface ZEvaluateViewController ()

@property (nonatomic ,strong) ZEvaluateBridge *bridge;

@property (nonatomic ,strong) ZCircleBean *circleBean;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,strong) ZEvaluateSucc op;

@end

@implementation ZEvaluateViewController

- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_completeItem setTitle:@"评价" forState:UIControlStateNormal];
        
        [_completeItem setTitle:@"评价" forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@"评价" forState:UIControlStateSelected];
        
        _completeItem.titleLabel.font = [UIFont systemFontOfSize:15];
        
        if ([@ZFragmentColor isEqualToString:@"#ffffff"]) {
            
            [_completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#666666"] forState:UIControlStateNormal];
            
            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#66666680"] forState:UIControlStateHighlighted];
            
            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#66666650"] forState:UIControlStateDisabled];
            
        } else {
            
            [_completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
            
            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff80"] forState:UIControlStateHighlighted];
            
            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff50"] forState:UIControlStateDisabled];
        }
    }
    return _completeItem;
}
+ (instancetype)createEvaluateWithCircleBean:(ZCircleBean *)circleBean andOp:(nonnull ZEvaluateSucc)op{
    
    return [[self alloc] initWithCircleBean:circleBean andOp:op];
}

- (instancetype)initWithCircleBean:(ZCircleBean *)circleBean andOp:(nonnull ZEvaluateSucc)op {
    
    if (self = [super init]) {
        
        self.circleBean = circleBean;
        
        self.op = op;
    }
    return self;
}
- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.tableView registerClass:[ZEvaluateTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZEvaluateTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.evaluateBean = data;
    
    return cell;
}

- (void)configViewModel {
    
    self.bridge = [ZEvaluateBridge new];
    
#if ZAppFormGlobalTwo
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createEvaluate:self evaluations:ZEvaluateKeyValues encoded:self.circleBean.encoded succ:^{
        
        weakSelf.circleBean.isattention = true;
        
        weakSelf.op();
    }];
    
#endif 
}

- (void)configNaviItem {
    
    self.title = @"评价";
    
    [self.completeItem sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.completeItem];
}

- (CGFloat)caculateForCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    return 48;
}
- (BOOL)canPanResponse {
    
    return true;
}
@end
