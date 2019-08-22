//
//  ZCollectLoadingViewController.m
//  ZContainer
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZCollectLoadingViewController.h"

@interface ZCollectLoadingViewController ()

@property (nonatomic ,strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation ZCollectLoadingViewController

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
        
        _collectionView.showsVerticalScrollIndicator = false;
        
        _collectionView.showsHorizontalScrollIndicator = false;
        
        _collectionView.backgroundColor = [UIColor clearColor];
        
        _collectionView.bounces = true;
        
        MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader new];
        
        _collectionView.mj_header = mj_header;
        
        mj_header.lastUpdatedTimeLabel.hidden = true;
        
        MJRefreshBackNormalFooter *mj_footer = [MJRefreshBackNormalFooter new];
        
        _collectionView.mj_header = mj_header;
        
        _collectionView.mj_footer = mj_footer;
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

+ (instancetype)createCollectionWithLayout:(UICollectionViewFlowLayout *)layout {
    
    return [[self alloc] initWithLayout:layout];
}

- (instancetype)initWithLayout:(UICollectionViewFlowLayout *)layout {
    
    if (self = [super init]) {
        
        self.flowLayout = layout;
    }
    return self;
}

- (UICollectionViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip  {
    
    return [UICollectionViewCell new];
}

@end
