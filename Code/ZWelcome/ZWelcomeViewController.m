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

@property (nonatomic ,weak) id<ZWelcomeConfig> config;

@property (nonatomic ,strong) ZWelcomeBridge *bridge;

@end

@implementation ZWelcomeViewController

+ (instancetype)createWelcomeWithConfig:(id<ZWelcomeConfig>)config {
    
    return [[self alloc] initWithConfig:config];
}
- (instancetype)initWithConfig:(id<ZWelcomeConfig>)config {
    
    if (self = [super init]) {
        
        self.config = config;
        
        self.skipItem.titleLabel.font = [UIFont systemFontOfSize:15];
        
        self.skipItem.layer.borderColor = [UIColor s_transformToColorByHexColorStr:config.itemColor].CGColor;
        
        [self.skipItem setTitleColor: [UIColor s_transformToColorByHexColorStr:config.itemColor] forState:UIControlStateNormal];
        
        [self.skipItem setTitleColor: [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",config.itemColor]] forState:UIControlStateHighlighted];
        
        self.pageControl.pageIndicatorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",config.itemColor]];
        
        self.pageControl.numberOfPages = config.welcomeImgs.count;
        
        self.pageControl.currentPage = 0;
        
        self.pageControl.currentPageIndicatorTintColor = [UIColor s_transformToColorByHexColorStr:config.itemColor];
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
    }
    return _skipItem;
}
- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        
        _pageControl.tag = 102;
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
    [bridge configViewModel:self
                welcomeImgs:self.config.welcomeImgs
              canPageHidden:true];
#elif ZWelcomeFormTwo
    
    [bridge configViewModel:self
                welcomeImgs:self.config.welcomeImgs
              canPageHidden:false];
    
#else
    
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
