//
//  ZCollectLoadingViewController.h
//  ZContainer
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

@import ZLoading;
@import MJRefresh;

NS_ASSUME_NONNULL_BEGIN

@interface ZCollectLoadingViewController : ZBaseViewController

@property (nonatomic ,strong) UICollectionView *collectionView;

+ (instancetype)createCollectionWithLayout:(UICollectionViewFlowLayout *)layout;

- (UICollectionViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip ;

@end

NS_ASSUME_NONNULL_END
