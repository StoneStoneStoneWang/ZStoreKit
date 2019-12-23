//
//  ZOrderBasaeViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/11/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZOrderBaseViewController.h"
#import "ZOrderViewController.h"
@import SToolsKit;
@import Masonry;

@interface ZOrderBaseLayout : UICollectionViewFlowLayout

@end

@implementation ZOrderBaseLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGSize itemSize = CGSizeMake( (KSSCREEN_WIDTH  - ZOrderKeyValues.count + 1) / ZOrderKeyValues.count, 48);
    
    self.itemSize = itemSize;
    
    self.minimumLineSpacing = 1;
    
    self.minimumInteritemSpacing = 1;
    
    self.sectionInset = UIEdgeInsetsZero;
    
}

@end

@interface ZOrderBaseCollectionViewCell()

@property (nonatomic ,strong) UILabel *titleLabel;

@end

@implementation ZOrderBaseCollectionViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self commitInit];
    }
    return self;
}
- (void)commitInit {
    
    [self.contentView addSubview:self.titleLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = self.bounds;
}

- (void)setTitle:(NSString *)title {
    
    self.titleLabel.text = title;
}
@end

@implementation ZOrderBaseCollectionView



@end

@interface ZOrderBaseViewController ()

@property (nonatomic ,strong) UIPageViewController *pageViewController;

@end

@implementation ZOrderBaseViewController

+ (instancetype)createOrderBase {
    
    return [self new];
}
- (instancetype)init {
    
    if (self = [super init]) {
        
        
    }
    return self;
}
- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.mas_equalTo(0);

        make.height.mas_equalTo(48);
        
        make.top.mas_equalTo(@KTOPLAYOUTGUARD);
    }];
    
    [self.collectionView registerClass:[ZOrderBaseCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}


- (UICollectionViewCell *)configCollectionViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZOrderBaseCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:ip];
    
    cell.backgroundColor = [UIColor redColor];
    
    [cell setTitle:ZOrderKeyValues[ip.row]];
    
    return cell;
}

- (void)addOwnSubViews {
    
    ZOrderBaseLayout *layout = [ZOrderBaseLayout new];
    
    UICollectionView *collectionView = [self createCollectionWithLayout:layout];
    
    collectionView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:collectionView];
}

- (void)configViewModel {
    
    
}

@end
