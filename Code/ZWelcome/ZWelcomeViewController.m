//
//  ZWelcomeViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZWelcomeViewController.h"
#import "ZWelcomeCollectionViewCell.h"
@import ZBridge;
@import SToolsKit;
@import Masonry;

@interface ZWelcomeViewController ()

@property (nonatomic ,strong) UIButton *skipItem;

@property (nonatomic ,strong) UIPageControl *pageControl;

@property (nonatomic ,strong) ZWelcomeBridge *bridge;

@property (nonatomic ,copy) ZWelcomeSkipBlock block;

@end

@implementation ZWelcomeViewController

+ (instancetype)createWelcomeWithSkipBlock:(ZWelcomeSkipBlock)block {
    
    return [[self alloc] initWithSkipBlock:block];
}

- (instancetype)initWithSkipBlock:(ZWelcomeSkipBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (UIButton *)skipItem {
    
    if (!_skipItem) {
        
        _skipItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _skipItem.tag = 101;
        
        _skipItem.layer.borderWidth = 1;
        
        _skipItem.layer.masksToBounds = true;
        
        _skipItem.layer.cornerRadius = 5;
        
        _skipItem.titleLabel.font = [UIFont systemFontOfSize:15];
        
        _skipItem.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@ZFragmentColor].CGColor;
        
        [_skipItem setTitleColor: [UIColor s_transformToColorByHexColorStr:@ZFragmentColor] forState:UIControlStateNormal];
        
        [_skipItem setTitleColor: [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@ZFragmentColor]] forState:UIControlStateHighlighted];
    }
    return _skipItem;
}
- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        
        _pageControl.tag = 102;
        
        _pageControl.pageIndicatorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@ZFragmentColor]];
        
        _pageControl.numberOfPages = ZWelcomeImgs.count;
        
        _pageControl.currentPage = 0;
        
        _pageControl.currentPageIndicatorTintColor = [UIColor s_transformToColorByHexColorStr:@ZFragmentColor];
    }
    return _pageControl;
}

- (void)addOwnSubViews {
    [super addOwnSubViews];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGSize itemSize = self.view.bounds.size;
    
    layout.itemSize = itemSize;
    
    layout.minimumLineSpacing = 0.1;
    
    layout.minimumInteritemSpacing = 0.1;
    
    layout.sectionInset = UIEdgeInsetsZero;
    
    UICollectionView *collectionView = [self createCollectionWithLayout:layout];
    
    collectionView.pagingEnabled = true;
    
    [self.view addSubview:collectionView];
    
    [self.view addSubview:self.skipItem];
    
    [self.view addSubview:self.pageControl];
}
- (void)configOwnSubViews {
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.bottom.mas_equalTo(@0);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.centerX.mas_equalTo(@0);
        
        make.height.mas_equalTo(@20);
        
        make.bottom.mas_equalTo(@-60);
    }];
    
    [self.collectionView registerClass:[ZWelcomeCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
#if ZWelcomeFormOne
    
    [self.skipItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.height.mas_equalTo(@30);
        
        make.centerX.mas_equalTo(@0);
        
        make.centerY.mas_equalTo(self.pageControl.mas_centerY);
    }];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateNormal];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateHighlighted];
    
#elif ZWelcomeFormTwo
    
    [self.skipItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.height.mas_equalTo(@30);
        
        make.right.mas_equalTo(@-15);
        
        make.top.mas_equalTo(@60);
    }];
    
#else
    
#endif //
    
}
- (void)configViewModel {
    
    ZWelcomeBridge *bridge = [ZWelcomeBridge new];
    
    self.bridge = bridge;
    
#if ZWelcomeFormOne
    __weak typeof(self) weakSelf = self;
    [bridge configViewModel:self welcomeImgs:ZWelcomeImgs canPageHidden:true skipAction:^(ZBaseViewController * _Nonnull vc) {
        weakSelf.block(vc);
    }];
#elif ZWelcomeFormTwo
    __weak typeof(self) weakSelf = self;
    
    [bridge configViewModel:self welcomeImgs:ZWelcomeImgs canPageHidden:false skipAction:^(ZBaseViewController * _Nonnull vc) {
        weakSelf.block(vc);
    }];
    
#endif
    
}
- (UICollectionViewCell *)configCollectionViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZWelcomeCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:ip];
    
    cell.icon = data;
    
    return cell;
}
- (void)collectionViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    
}
@end
