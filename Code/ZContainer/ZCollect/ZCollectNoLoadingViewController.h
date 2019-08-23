//
//  ZCollectNoLoadingViewController.h
//  ZContainer
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

@import ZBase;
#import "ZBaseViewController+ZContainer.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZCollectNoLoadingViewController : ZBaseViewController

@property (nonatomic ,strong) UICollectionView *collectionView;

+ (instancetype)createCollectionWithLayout:(UICollectionViewFlowLayout *)layout;

- (UICollectionViewCell *)configCollectionViewCell:(id)data forIndexPath:(NSIndexPath *)ip ;

- (void)collectViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip ;
@end

NS_ASSUME_NONNULL_END
