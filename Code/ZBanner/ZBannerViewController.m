//
//  ZBannerViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZBannerViewController.h"
#import "ZBannerCollectionViewCell.h"
@import ZBridge;
@import SToolsKit;
@import Masonry;

#if ZBannerFormOne

@interface ZBannerFormOneLayout : UICollectionViewFlowLayout


@end

@implementation ZBannerFormOneLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGSize itemSize = CGSizeMake(KSSCREEN_WIDTH, KSSCREEN_WIDTH / 2);
    
    self.itemSize = itemSize;
    
    self.minimumLineSpacing = 0.1;
    
    self.minimumInteritemSpacing = 0.1;
    
    self.sectionInset = UIEdgeInsetsZero;
    
}

@end
#elif ZBannerFormTwo

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define ITEM_ZOOM 0.05
#define THE_ACTIVE_DISTANCE 230
#define LEFT_OFFSET 60

@interface ZBannerFormTwoLayout : UICollectionViewFlowLayout


@end

@implementation ZBannerFormTwoLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGSize itemSize = CGSizeMake(KSSCREEN_WIDTH - 80, (KSSCREEN_WIDTH - 120 ) / 2);
    
    self.itemSize = itemSize;
    
    self.minimumLineSpacing = 20.0f;
    
    self.sectionInset = UIEdgeInsetsMake(60, 40, 0, 40);
    
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray * array = [[NSArray alloc]initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    CGRect visiableRect;
    visiableRect.origin = self.collectionView.contentOffset;
    visiableRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes * attributes in array)
    {
        if (CGRectIntersectsRect(attributes.frame, rect))
        {
            CGFloat distance = CGRectGetMidX(visiableRect) - attributes.center.x;
            distance = ABS(distance);
            if (distance < KSSCREEN_WIDTH/2 + self.itemSize.width)
            {
                CGFloat zoom = 1 + ITEM_ZOOM * (1 - distance/THE_ACTIVE_DISTANCE);
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0f);
                attributes.transform3D = CATransform3DTranslate(attributes.transform3D, 0, -zoom * 25, 0);
                attributes.alpha = zoom - ITEM_ZOOM;
            }
        }
    }
    return array;
}

- (CGPoint )targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat offsetAdjustment = MAXFLOAT;
    
    CGFloat horizontalCenter_X = proposedContentOffset.x + CGRectGetWidth(self.collectionView.bounds)/2.0;
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 20, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray *array = [super layoutAttributesForElementsInRect:targetRect];
    for (UICollectionViewLayoutAttributes * attributes in array)
    {
        CGFloat itemHorizontalCenter_X = attributes.center.x;
        if (ABS(itemHorizontalCenter_X - horizontalCenter_X) < ABS(offsetAdjustment))
        {
            offsetAdjustment = itemHorizontalCenter_X - horizontalCenter_X;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

@end

#else

#endif


@interface ZBannerViewController ()

@property (nonatomic ,strong) UIPageControl *pageControl;

@property (nonatomic ,strong) ZBannerBridge *bridge;
@end

@implementation ZBannerViewController

- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        
        _pageControl.tag = 102;
        
        _pageControl.pageIndicatorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@ZFragmentColor]];
        
        _pageControl.numberOfPages = 4;
        
        _pageControl.currentPage = 0;
        
        _pageControl.currentPageIndicatorTintColor = [UIColor s_transformToColorByHexColorStr:@ZFragmentColor];
    }
    return _pageControl;
}

- (void)addOwnSubViews {
    [super addOwnSubViews];
    
#if ZBannerFormOne
    
    ZBannerFormOneLayout *layout = [ZBannerFormOneLayout new];
    
    UICollectionView *collectionView = [self createCollectionWithLayout:layout];
    
#elif ZBannerFormTwo
    
    ZBannerFormTwoLayout *layout = [ZBannerFormTwoLayout new];
    
    UICollectionView *collectionView = [self createCollectionWithLayout:layout];
    
#else
    
    
#endif //
    
    collectionView.pagingEnabled = true;
    
    [self.view addSubview:collectionView];
    
    [self.view addSubview:self.pageControl];
}
- (void)configOwnSubViews {
    
    [self.collectionView registerClass:[ZBannerImageCollectionViewCell class] forCellWithReuseIdentifier:@"image"];
    
    [self.collectionView registerClass:[ZBannerVideoCollectionViewCell class] forCellWithReuseIdentifier:@"video"];
    
#if ZBannerFormOne
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(0);
        
        make.height.mas_equalTo(KSSCREEN_WIDTH / 2);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(80);
        
        make.centerX.mas_equalTo(0);
        
        make.height.mas_equalTo(20);
        
        make.top.mas_equalTo(KSSCREEN_WIDTH / 2 - 30 );
    }];
#elif ZBannerFormTwo
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(0);
        
        make.height.mas_equalTo( (KSSCREEN_WIDTH - 100 ) / 2);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(80);
        
        make.centerX.mas_equalTo(0);
        
        make.height.mas_equalTo(20);
        
        make.top.mas_equalTo(KSSCREEN_WIDTH / 2 - 80 );
    }];
#else
    
#endif //
    
}
- (void)configViewModel {
    
    ZBannerBridge *bridge = [ZBannerBridge new];
    
    self.bridge = bridge;
    
    
    
#if ZBannerFormOne
    
    [bridge createBanner:self canPageHidden:false style:ZBannerStyleOne];
    
#elif ZBannerFormTwo
    
    [bridge createBanner:self canPageHidden:false style:ZBannerStyleTwo];
    
#else
    
#endif
    
}
- (UICollectionViewCell *)configCollectionViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZCircleBean *circleBean = (ZCircleBean *)data;
    
    BOOL isVideo = false;
    
    for (ZKeyValueBean *keyValue in circleBean.contentMap) {
        
        if ([keyValue.type isEqualToString:@"video"]) {
            
            isVideo = true;
            
            break;
        }
    }
    
    if (isVideo) {
        
        ZBannerVideoCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"video" forIndexPath:ip ];
        
        cell.circleBean = data;
        
        return cell;
    } else {
        
        ZBannerImageCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"image" forIndexPath:ip ];
        
        cell.circleBean = data;
        
        return cell;
    }
}

- (void)collectionViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    
}

@end
