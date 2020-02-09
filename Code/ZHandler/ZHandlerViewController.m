//
//  ZHandlerViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/10/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZHandlerViewController.h"
#import "ZHandlerCollectionViewCell.h"
@import ZBridge;
@import SToolsKit;
@import Masonry;
@import JXTAlertManager;
@import ZDatePicker;

@interface ZHandlerFormLayout : UICollectionViewFlowLayout


@end

@implementation ZHandlerFormLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.minimumLineSpacing = 1;
    
    self.minimumInteritemSpacing = 1;
    
    self.sectionInset = UIEdgeInsetsZero;
    
    self.itemSize = CGSizeMake(KSSCREEN_WIDTH, 48);
}

@end

@interface ZHandlerViewController ()

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,strong) ZHandlerBridge *bridge;

@property (nonatomic ,strong) ZDatePicker *picker;

@property (nonatomic ,strong) CLLocation *location;

@property (nonatomic ,strong) NSString *address;
@end

@implementation ZHandlerViewController

+ (instancetype)createHandlerWithLocation:(CLLocation *)location andAddress:(NSString *)address {
    
    return [[self alloc] initWithLocation:location andAddress:address];
}
- (instancetype)initWithLocation:(CLLocation *)location andAddress:(NSString *)address {
    
    if (self = [super init]) {
        
        self.location = location;
        
        self.address = address;
    }
    return self;
}
- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateNormal];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateSelected];
        
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

- (void)addOwnSubViews {
    [super addOwnSubViews];
    
    ZHandlerFormLayout *layout = [ZHandlerFormLayout new];
    
    UICollectionView *collectionView = [self createCollectionWithLayout:layout];
    
    [self.view addSubview:collectionView];
    
}
- (void)configOwnSubViews {
    
    [self.collectionView registerClass:[ZHandlerCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(0);
        
        make.bottom.mas_equalTo(0);
    }];
}
- (void)configViewModel {
    
    self.bridge = [ZHandlerBridge new];
    
    [self.bridge createHandler:self pTag:@"已发布" keyValues:ZPubKeyValues];
    
    [self.bridge updateLocation:self.location];
    
    [self.bridge updateLocationAddress:self.address];
}
- (void)configNaviItem {
    
    [self.completeItem sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.completeItem];
    
    self.title = @"预约";
}
- (UICollectionViewCell *)configCollectionViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZHandlerCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:ip ];
    
    cell.keyValue = data;
    
    return cell;
}
- (void)collectionViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZKeyValueBean *keyValue = (ZKeyValueBean *)data;
    
    __weak typeof(self) weakSelf = self;
    
    if ([keyValue.type isEqualToString:@"头/二胎"]) {
        
        [self jxt_showActionSheetWithTitle:keyValue.place message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            
            alertMaker.
            addActionCancelTitle(@"取消").
            addActionDefaultTitle(@"头胎").
            addActionDefaultTitle(@"二胎");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            
            if ([action.title isEqualToString:@"取消"]) {
                
            } else {
                
                keyValue.value = action.title;
                
                [weakSelf.bridge replaceContent:keyValue];
            }
        }];
        
    } else if ([keyValue.type isEqualToString:@"服务时间"]) {
        
        if (!self.picker) {
            
            self.picker = [[ZDatePicker alloc] initWithTextColor:[UIColor s_transformToColorByHexColorStr:@"#666666"] buttonColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor] font:[UIFont systemFontOfSize:15] locale:[NSLocale localeWithLocaleIdentifier:@"zh-Hans"] showCancelButton:true];
        }
        
        __weak typeof(self) weakSelf = self;
        
        [self.picker show:@"" doneButtonTitle:@"完成" cancelButtonTitle:@"取消" defaultDate:[NSDate date] minimumDate:nil maximumDate:[NSDate date] datePickerMode:UIDatePickerModeDate callback:^(NSDate * _Nullable date) {
            
            if (date) {
                
                keyValue.value = [[NSString stringWithFormat:@"%ld",(NSInteger)date.timeIntervalSince1970] s_convertToDate:SDateTypeLongStyle];
                
                [weakSelf.bridge replaceContent:keyValue];
            }
        }];
    }
}

@end
