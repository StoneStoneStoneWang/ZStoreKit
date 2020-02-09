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
@import ZBridge;
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
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
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

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        
        self.titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@ZFragmentColor];
        
        self.titleLabel.font = [UIFont systemFontOfSize:15];
    } else {
        
        self.titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#666666"];
        
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
}

@end

@implementation ZOrderBaseCollectionView



@end

@interface ZOrderBaseViewController () <UIPageViewControllerDelegate ,UIPageViewControllerDataSource>

@property (nonatomic ,strong) UIPageViewController *pageViewController;

@property (nonatomic ,strong) NSMutableArray *subVCs;

@property (nonatomic ,strong) ZOrderBaseBridge *bridge;

@property (nonatomic ,strong) NSIndexPath *lastIp;

@property (nonatomic ,strong) UIViewController *pendvc;
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
- (NSMutableArray *)subVCs {
    
    if (!_subVCs) {
        
        _subVCs = [NSMutableArray array];
    }
    return _subVCs;
}
- (UIPageViewController *)pageViewController {
    
    if (!_pageViewController) {
        
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:(UIPageViewControllerTransitionStyleScroll) navigationOrientation:(UIPageViewControllerNavigationOrientationHorizontal) options:@{}];
    }
    return _pageViewController;
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
- (ZOrderBaseBridge *)bridge {
    
    if (!_bridge) {
        
        _bridge = [ZOrderBaseBridge new];
    }
    return _bridge;
}

- (UICollectionViewCell *)configCollectionViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZOrderBaseCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:ip];
    
    [cell setTitle:data];
    
    return cell;
}
- (void)collectionViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    NSLog(@"collectionViewSelectData");
    
//    [self.collectionView deselectItemAtIndexPath:self.lastIp animated:true];
    
    [self.collectionView selectItemAtIndexPath:ip animated:true scrollPosition:(UICollectionViewScrollPositionNone)];
    
    if (self.lastIp.row < ip.row) {
        
        [self.pageViewController setViewControllers:@[self.subVCs[ip.row]] direction:(UIPageViewControllerNavigationDirectionForward) animated:true completion:nil];
    } else {
        
        [self.pageViewController setViewControllers:@[self.subVCs[ip.row]] direction:(UIPageViewControllerNavigationDirectionReverse) animated:true completion:nil];
    }
    
    self.lastIp = ip;
    
}

- (void)addOwnSubViews {
    
    ZOrderBaseLayout *layout = [ZOrderBaseLayout new];
    
    UICollectionView *collectionView = [self createCollectionWithLayout:layout];
    
    [self.view addSubview:collectionView];
    
    collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)configViewModel {
    
    [self.bridge createOrderBase:self tableData:ZOrderKeyValues];
    
    self.lastIp = [NSIndexPath indexPathForRow:0 inSection:0];
    
    for (NSString *t in ZOrderKeyValues) {
        
        ZOrderViewController *order = [ZOrderViewController createOrder:t];
        
        [self.subVCs addObject:order];
    }
    
    [self.collectionView selectItemAtIndexPath:self.lastIp animated:true scrollPosition:(UICollectionViewScrollPositionNone)];
    
    self.pageViewController.delegate = self;
    
    self.pageViewController.dataSource = self;
    
    [self addChildViewController:self.pageViewController];
    
    [self.view addSubview:self.pageViewController.view];
    
    self.pageViewController.view.frame = CGRectMake(0, KTOPLAYOUTGUARD + 48, KSSCREEN_WIDTH, KSSCREEN_HEIGHT - KTOPLAYOUTGUARD - 48);
    
    [self.pageViewController setViewControllers:@[self.subVCs.firstObject] direction:(UIPageViewControllerNavigationDirectionReverse) animated:true completion:nil];
    
}

#pragma mark UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSInteger after = self.lastIp.row + 1;
    
    if (after >= self.subVCs.count) {
        after = 0;
    }
    return self.subVCs[after];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger before = self.lastIp.row - 1;
    if (before < 0) {
        before = self.subVCs.count - 1;
    }
    return self.subVCs[before];
}
#pragma mark UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
    
    self.pendvc = pendingViewControllers.firstObject;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    
    if (completed) {
        
        self.lastIp = [NSIndexPath indexPathForRow:[self.subVCs indexOfObject:self.pendvc] inSection:0];
    } else {
        
        self.lastIp = [NSIndexPath indexPathForRow:[self.subVCs indexOfObject:previousViewControllers.lastObject] inSection:0];
    }
    
    [self.collectionView selectItemAtIndexPath:self.lastIp animated:true scrollPosition:(UICollectionViewScrollPositionNone)];
}

- (BOOL)canPanResponse {
    
    return true;
}

@end

// 黑下潜行金团开组 来天空 150  宝石30 力量之手 300 红木120 老板
