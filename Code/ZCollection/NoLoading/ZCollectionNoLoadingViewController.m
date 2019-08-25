//
//  ZCollectionNoLoadingViewController.m
//  ZContainer
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZCollectionNoLoadingViewController.h"

@interface ZCollectionNoLoadingViewController ()

@property (nonatomic ,strong ,readwrite) UICollectionView *collectionView;

@end

@implementation ZCollectionNoLoadingViewController

- (UICollectionView *)createCollectionWithLayout:(UICollectionViewFlowLayout *)layout {
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    collectionView.showsVerticalScrollIndicator = false;
    
    collectionView.showsHorizontalScrollIndicator = false;
    
    collectionView.backgroundColor = [UIColor clearColor];
    
    collectionView.bounces = true;
    
    self.collectionView = collectionView;
    
    return collectionView;
}

- (UICollectionViewCell *)configCollectionViewCell:(id)data forIndexPath:(NSIndexPath *)ip  {
    
    return [UICollectionViewCell new];
}
- (void)collectionViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    
}

@end
