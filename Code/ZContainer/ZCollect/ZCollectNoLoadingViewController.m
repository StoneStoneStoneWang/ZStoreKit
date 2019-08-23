//
//  ZCollectNoLoadingViewController.m
//  ZContainer
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZCollectNoLoadingViewController.h"

@interface ZCollectNoLoadingViewController ()

@property (nonatomic ,strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation ZCollectNoLoadingViewController

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
        
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

- (UICollectionViewCell *)configCollectionViewCell:(id)data forIndexPath:(NSIndexPath *)ip  {
    
    return [UICollectionViewCell new];
}
- (void)collectViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    
}
@end
