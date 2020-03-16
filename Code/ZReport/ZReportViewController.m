//
//  ZReportViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZReportViewController.h"
#import "ZReportTableViewCell.h"
#import "ZReportHeaderView.h"
@import ZBridge;
@import SToolsKit;

@interface ZReportViewController ()

@property (nonatomic ,strong) ZReportBridge *bridge;

@property (nonatomic ,strong) UITextView *textView;

@property (nonatomic ,copy) NSString *uid;

@property (nonatomic ,copy) NSString *encode;

@property (nonatomic ,strong) UIButton *completeItem;

@end

@implementation ZReportViewController

- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_completeItem setTitle:@"举报" forState:UIControlStateNormal];
        
        [_completeItem setTitle:@"举报" forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@"举报" forState:UIControlStateSelected];
        
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

- (UITextView *)textView {
    
    if (!_textView) {
        
        _textView = [[UITextView alloc] initWithFrame:CGRectZero];
        
        _textView.font = [UIFont systemFontOfSize:15];
        
        _textView.textContainerInset = UIEdgeInsetsMake(15, 15, 15, 15);
        
        _textView.tag = 201;
    }
    return _textView;
}

+ (instancetype)createReportWithUid:(NSString *)uid andEncode:(NSString *)encode {
    
    return [[self alloc] initWithUid:uid andEncode:encode];
}
- (instancetype)initWithUid:(NSString *)uid andEncode:(NSString *)encode {
    
    if (self = [super init]) {
        
        self.uid = uid;
        
        self.encode = encode;
    }
    return self;
}
- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.tableView registerClass:[ZReportTableViewCell class] forCellReuseIdentifier:@"cell"];

    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 150)];
    
    footerView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableFooterView = footerView;
    
    [footerView addSubview:self.textView];
    
    self.textView.frame = footerView.bounds;
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZReportTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.reportBean = data;
    
    return cell;
}

- (void)configViewModel {
    
    self.bridge = [ZReportBridge new];
    
#if ZAppFormGlobalCircle
    [self.bridge createReport:self
                      reports:ZReportKeyValues uid:self.uid
                      encoded:self.encode
                     textView:self.textView];
    
#endif
}

- (void)configNaviItem {
    
    self.title = @"举报";
    
    [self.completeItem sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.completeItem];
}

- (CGFloat)caculateForCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    return 48;
}
@end
