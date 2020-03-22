//
//  ZAreaHeaderViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import "ZAreaHeaderViewController.h"
#import "ZAreaViewController.h"
@import SToolsKit;

@interface ZAreaHeaderLayout: UICollectionViewFlowLayout

@end
#define ZArea_Width 80

#define ZArea_Height 44
@implementation ZAreaHeaderLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.minimumLineSpacing = 0.1;
    
    self.sectionInset = UIEdgeInsetsMake(0, 15, 0, 0);
    
    self.itemSize = CGSizeMake(ZArea_Width, ZArea_Height);
}

@end

@interface ZAreaHeaderCollectionViewCell : UICollectionViewCell

@property (nonatomic ,strong) ZAreaHeaderBean *headerBean;

@property (nonatomic ,strong) UILabel *titleLabel;
@end

@implementation ZAreaHeaderCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self commitInit];
    }
    return self;
}
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.font = [UIFont systemFontOfSize:15];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#333333"];
        
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _titleLabel;
    
}
- (void)commitInit {
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.titleLabel];
}
- (void)setHeaderBean:(ZAreaHeaderBean *)headerBean {
    
    if (headerBean.areaBean) {
        
        self.titleLabel.text = headerBean.areaBean.name;
    } else {
        
        self.titleLabel.text = @"请选择";
    }
    
    NSLog(@"%@ ==== %d ",headerBean.areaBean ,headerBean.isSelected);
    
    if (headerBean.isSelected) {
        
        self.titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@ZFragmentColor];
    } else {
        
        self.titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#666666"];
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = self.bounds;
    
}

@end

@interface ZAreaHeaderViewController () <UIPageViewControllerDelegate,UIPageViewControllerDataSource ,UIViewControllerTransitioningDelegate>

@property (nonatomic ,assign) NSInteger pid;

@property (nonatomic ,assign) NSInteger cid;

@property (nonatomic ,assign) NSInteger rid;

@property (nonatomic ,copy) ZAreaHeaderBlock block;

@property (nonatomic ,strong) UIPageViewController *pageViewController;

@property (nonatomic ,strong) ZAreaViewController *province;

@property (nonatomic ,strong) ZAreaViewController *city;

@property (nonatomic ,strong) ZAreaViewController *region;

@property (nonatomic ,strong) ZAreaHeaderBean *provinceHeader;

@property (nonatomic ,strong) ZAreaHeaderBean *cityHeader;

@property (nonatomic ,strong) ZAreaHeaderBean *regionHeader;

@property (nonatomic ,strong) ZAreaHeaderBridge *bridge;

@property (nonatomic ,assign) NSInteger currentIdx;

@property (nonatomic ,strong) NSMutableArray *viewControllers;

@property (nonatomic ,strong) ZAreaPresentAnimation *presentAnimation;

@property (nonatomic ,strong) ZAreaDismissAnimation *dismissAnimation;

@property (nonatomic ,strong) UIButton *cancleItem;

@end

@implementation ZAreaHeaderViewController

- (UIButton *)cancleItem {
    
    if (!_cancleItem) {
        
        _cancleItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_cancleItem setTitle:@"取消" forState:UIControlStateNormal];
        
        [_cancleItem setTitle:@"取消" forState:UIControlStateHighlighted];
        
        _cancleItem.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [_cancleItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor] forState:UIControlStateNormal];
        
        [_cancleItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@ZFragmentColor] forState:UIControlStateHighlighted];
    }
    return _cancleItem;
}
+ (instancetype)createAreaHeaderWithPid:(NSInteger)pid andCid:(NSInteger)cid andRid:(NSInteger)rid andAreaHeaderBlock:( ZAreaHeaderBlock)block{
    
    return [[self alloc] initWithPid:pid andCid:cid andRid:rid andAreaHeaderBlock:block];
}
- (instancetype)initWithPid:(NSInteger)pid andCid:(NSInteger)cid andRid:(NSInteger)rid andAreaHeaderBlock:( ZAreaHeaderBlock)block{
    
    if (self = [super init]) {
        
        self.pid = pid;
        
        self.cid = cid;
        
        self.rid = rid;
        
        self.block = block;
    }
    return self;
}
- (ZAreaPresentAnimation *)presentAnimation {
    
    if (!_presentAnimation) {
        
        _presentAnimation = [ZAreaPresentAnimation new];
        
    }
    return _presentAnimation;
}
- (ZAreaDismissAnimation *)dismissAnimation {
    
    if (!_dismissAnimation) {
        
        _dismissAnimation = [ZAreaDismissAnimation new];
    }
    return _dismissAnimation;
}
- (ZAreaHeaderBean *)provinceHeader {
    
    if (!_provinceHeader) {
        
        _provinceHeader = [ZAreaHeaderBean new];
    }
    return _provinceHeader;
}

- (ZAreaHeaderBean *)cityHeader {
    
    if (!_cityHeader) {
        
        _cityHeader = [ZAreaHeaderBean new];
    }
    return _cityHeader;
}
- (ZAreaHeaderBean *)regionHeader {
    
    if (!_regionHeader) {
        
        _regionHeader = [ZAreaHeaderBean new];
    }
    return _regionHeader;
}
- (NSMutableArray *)viewControllers {
    
    if (!_viewControllers) {
        
        _viewControllers = [NSMutableArray array];
    }
    return _viewControllers;
}
- (UIPageViewController *)pageViewController {
    
    if (!_pageViewController) {
        
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:(UIPageViewControllerTransitionStyleScroll) navigationOrientation:(UIPageViewControllerNavigationOrientationHorizontal) options:@{}];
    }
    return _pageViewController;
}

- (void)addOwnSubViews {
    
    self.pageViewController.view.frame = CGRectMake(0, ZArea_Height + 1, self.view.bounds.size.width, self.view.bounds.size.height - ZArea_Height);
    
    [self addChildViewController:self.pageViewController];
    
    [self.view addSubview:self.pageViewController.view];
    
    ZAreaHeaderLayout *layout = [ZAreaHeaderLayout new];
    
    UICollectionView *collectionView = [self createCollectionWithLayout:layout];
    
    [self.view addSubview:collectionView];
    
    collectionView.frame = CGRectMake(0, 0, self.view.bounds.size.width, ZArea_Height);
    
    collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.cancleItem];
    
    self.cancleItem.frame = CGRectMake(self.view.bounds.size.width - 40, 0, 40, ZArea_Height);

}
- (void)onCancleItemTap {
    
    [self dismissViewControllerAnimated:true completion:nil];
}
- (UICollectionViewCell *)configCollectionViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZAreaHeaderCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:ip];
    
    cell.headerBean = data;
    
    return cell;
}

- (void)collectionViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    [self.pageViewController setViewControllers:@[self.viewControllers[ip.row]] direction:UIPageViewControllerNavigationDirectionForward animated:false completion:nil];
}
- (void)configOwnProperties {
    
    self.transitioningDelegate = self;
    
}
- (void)configOwnSubViews {
    
    [self.collectionView registerClass:[ZAreaHeaderCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.pageViewController.dataSource = self;
    
    self.pageViewController.delegate = self;
    
    self.bridge = [ZAreaHeaderBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    self.province = [ZAreaViewController createAreaWithType:ZAreaTypeProvince andAreaBlock:^(ZBaseViewController * _Nonnull from, ZAreaBean * _Nonnull selectedArea, ZAreaType type, BOOL hasNext) {
        
        if (weakSelf.viewControllers.count == 1) {
            
            [weakSelf.viewControllers addObject:weakSelf.city];
        }
        
        ZAreaViewController *city = weakSelf.viewControllers[1];
        
        [weakSelf.pageViewController setViewControllers:@[city] direction:(UIPageViewControllerNavigationDirectionForward) animated:true completion:nil];
        
        [city updateAreas:selectedArea.areaId];
        
        weakSelf.provinceHeader.isSelected = true;
        
        weakSelf.provinceHeader.areaBean = selectedArea;
        
        weakSelf.cityHeader.isSelected = false;
        
        weakSelf.cityHeader.areaBean = nil;
        
        weakSelf.regionHeader.isSelected = false;
        
        weakSelf.regionHeader.areaBean = nil;
        
        if ([weakSelf.bridge fetchHeaderCount] == 1) {
            
            [weakSelf.bridge addheader:weakSelf.cityHeader];
        } else if ([weakSelf.bridge fetchHeaderCount] == 3) {
            
            [weakSelf.bridge removeHeader:weakSelf.regionHeader];
        }
        
        [weakSelf.collectionView reloadData];
    }];
    
    [self.viewControllers addObject:self.province];
    
    self.city = [ZAreaViewController createAreaWithType:ZAreaTypeCity andAreaBlock:^(ZBaseViewController * _Nonnull from, ZAreaBean * _Nonnull selectedArea, ZAreaType type, BOOL hasNext) {
        
        if (hasNext) {
            
            if (weakSelf.viewControllers.count == 2) {
                
                [weakSelf.viewControllers addObject:weakSelf.region];
            }
            
            ZAreaViewController *region = weakSelf.viewControllers.lastObject;
            
            [weakSelf.pageViewController setViewControllers:@[region] direction:(UIPageViewControllerNavigationDirectionForward) animated:true completion:nil];
            
            [region updateAreas:selectedArea.areaId];
            
            weakSelf.cityHeader.isSelected = true;
            
            weakSelf.cityHeader.areaBean = selectedArea;
            
            weakSelf.regionHeader.isSelected = false;
            
            weakSelf.regionHeader.areaBean = nil;
            
            if ([weakSelf.bridge fetchHeaderCount] == 2) {
                
                [weakSelf.bridge addheader:weakSelf.regionHeader];
            }
            
            [weakSelf.collectionView reloadData];
        } else {
            
            weakSelf.cityHeader.isSelected = true;
            
            weakSelf.cityHeader.areaBean = selectedArea;
            
            weakSelf.block(weakSelf, weakSelf.provinceHeader.areaBean, weakSelf.cityHeader.areaBean, weakSelf.regionHeader.areaBean);
        }
        
    }];
    
    [self.viewControllers addObject:self.city];
    
    self.region = [ZAreaViewController createAreaWithType:ZAreaTypeRegion andAreaBlock:^(ZBaseViewController * _Nonnull from, ZAreaBean * _Nonnull selectedArea, ZAreaType type, BOOL hasNext) {
        
        weakSelf.regionHeader.isSelected = true;
        
        weakSelf.regionHeader.areaBean = selectedArea;
        
        weakSelf.block(weakSelf, weakSelf.provinceHeader.areaBean, weakSelf.cityHeader.areaBean, weakSelf.regionHeader.areaBean);
    }];
    
    [self.viewControllers addObject:self.region];
    
    [self.bridge createAreaHeader:self];
    
    [self.cancleItem addTarget:self action:@selector(onCancleItemTap) forControlEvents:UIControlEventTouchUpInside];
    
    [self performSelector:@selector(onDelay) withObject:nil afterDelay:0.1];
    
    
}
- (void)onDelay {
    
    __weak typeof(self) weakSelf = self;
    
    if (self.pid) {
        
        if (self.cid) {
            
            if (self.rid) {
                
                [self.pageViewController setViewControllers:@[self.province] direction:(UIPageViewControllerNavigationDirectionForward) animated:false completion:nil];
                
                [self.pageViewController setViewControllers:@[self.city] direction:(UIPageViewControllerNavigationDirectionForward) animated:false completion:nil];
                
                [self.city selectedArea:self.cid andBlock:^(ZBaseViewController * _Nonnull from, ZAreaBean * _Nonnull selectedArea, ZAreaType type, BOOL hasNext) {
                    
                    if (hasNext) {
                        
                        weakSelf.provinceHeader.isSelected = true;
                        
                        weakSelf.provinceHeader.areaBean = [weakSelf.province fetchAreaWithId:weakSelf.pid];
                        
                        [weakSelf.bridge addheader:weakSelf.provinceHeader];
                        
                        
                        weakSelf.cityHeader.isSelected = true;
                        
                        weakSelf.cityHeader.areaBean = [weakSelf.city fetchAreaWithId:weakSelf.cid];
                        
                        [weakSelf.bridge addheader:weakSelf.cityHeader];
                        
                        [weakSelf.city updateAreas:weakSelf.pid];
                        
                        [weakSelf.pageViewController setViewControllers:@[weakSelf.region] direction:(UIPageViewControllerNavigationDirectionForward) animated:true completion:nil];
                        
                        weakSelf.regionHeader.isSelected = true;
                        
                        weakSelf.regionHeader.areaBean = [weakSelf.region fetchAreaWithId:weakSelf.rid];
                        
                        [weakSelf.bridge addheader:weakSelf.regionHeader];
                        
                        [weakSelf.region updateAreas:selectedArea.areaId];
                        
                    }
                }];
            
            } else {
                
                [self.viewControllers removeLastObject];
                
                [self.pageViewController setViewControllers:@[self.province] direction:(UIPageViewControllerNavigationDirectionForward) animated:false completion:nil];
                
                [self.province selectedArea:self.pid andBlock:^(ZBaseViewController * _Nonnull from, ZAreaBean * _Nonnull selectedArea, ZAreaType type, BOOL hasNext) {
                    
                    ZAreaViewController *province = weakSelf.viewControllers[0];
                    
                    ZAreaViewController *city = weakSelf.viewControllers[1];
                    
                    [weakSelf.pageViewController setViewControllers:@[city] direction:(UIPageViewControllerNavigationDirectionForward) animated:true completion:nil];
                    
                    [city updateAreas:selectedArea.areaId];
                    
                    weakSelf.provinceHeader.isSelected = true;
                    
                    weakSelf.provinceHeader.areaBean = [province fetchAreaWithId:weakSelf.pid];
                    
                    [weakSelf.bridge addheader:weakSelf.provinceHeader];
                    
                    weakSelf.cityHeader.isSelected = true;
                    
                    weakSelf.cityHeader.areaBean = [city fetchAreaWithId:weakSelf.cid];
                    
                    [weakSelf.bridge addheader:weakSelf.cityHeader];
                    
                    [weakSelf.collectionView reloadData];
                }];
            }
        }
        
    } else {
        
        [self.viewControllers removeLastObject];
        
        [self.viewControllers removeLastObject];
        
        [self.pageViewController setViewControllers:@[self.province] direction:(UIPageViewControllerNavigationDirectionForward) animated:true completion:nil];
        
        [self.bridge addheader:self.provinceHeader];
        
        [weakSelf.collectionView reloadData];
    }
    
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSInteger idx = [self.viewControllers indexOfObject:viewController];
    
    if (idx == NSNotFound) {
        return nil;
    }
    
    if (idx == self.viewControllers.count - 1) {
        
        return nil;
    }
    return self.viewControllers[idx + 1];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSInteger idx = [self.viewControllers indexOfObject:viewController];
    
    if (idx  == 0 || idx == NSNotFound) {
        
        return nil;
    }
    
    return self.viewControllers[idx - 1];
}
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
    UIViewController *controller = (UIViewController *)pendingViewControllers.firstObject;
    
    self.currentIdx = [self.viewControllers indexOfObject:controller];
    
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    if (completed) {
        
        UIViewController *controller = (UIViewController *)previousViewControllers.firstObject;
        
        self.currentIdx = [self.viewControllers indexOfObject:controller];
    }
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    return self.dismissAnimation;
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    return self.presentAnimation;
}
@end


@implementation ZAreaPresentAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.5;
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect finalRect = CGRectMake(0, KSSCREEN_HEIGHT / 4, KSSCREEN_WIDTH, KSSCREEN_HEIGHT * 3 / 4);
    
    toVC.view.frame = CGRectOffset(finalRect, 0, KSSCREEN_HEIGHT * 3 / 4);
    
    UIView *snapView = [fromVC.view snapshotViewAfterScreenUpdates:false];
    
    snapView.frame = transitionContext.containerView.bounds;
    
    snapView.tag = 8888;
    
    UIView *cover = [[UIView alloc] initWithFrame:CGRectZero];
    
    cover.frame = transitionContext.containerView.bounds;
    
    cover.tag = 9999;
    
    cover.alpha = 0.0;
    
    cover.backgroundColor = [UIColor s_transformToColorByHexColorStr:@"#333333"];
    
    [transitionContext.containerView addSubview:snapView];
    
    [transitionContext.containerView addSubview:cover];
    
    [transitionContext.containerView addSubview:toVC.view];
    
    fromVC.view.hidden = true;
    
    [UIView  animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:(UIViewAnimationOptionCurveLinear) animations:^{
        
        toVC.view.frame = finalRect;
        
        snapView.transform = CGAffineTransformMakeScale(0.8, 0.8);
        
        cover.alpha = 0.4;
    } completion:^(BOOL finished) {
        
        fromVC.view.hidden = false;
        
        [transitionContext completeTransition:true];
    }];
}


@end

@implementation ZAreaDismissAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.3;
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect initRect = [transitionContext initialFrameForViewController:fromVC];
    
    CGRect finalRect = CGRectOffset(initRect, 0, KSSCREEN_HEIGHT * 3 / 4);
    
    [transitionContext.containerView addSubview:toVC.view];
    
    [transitionContext.containerView sendSubviewToBack:toVC.view];
    
    UIView *snapViewFrom = [transitionContext.containerView viewWithTag:8888];
    
    [snapViewFrom removeFromSuperview];
    
    toVC.view.frame = transitionContext.containerView.bounds;
    
    toVC.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
    
    [UIView  animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:(UIViewAnimationOptionCurveLinear) animations:^{
        
        fromVC.view.frame = finalRect;
        
        toVC.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:true];
    }];
}

@end
