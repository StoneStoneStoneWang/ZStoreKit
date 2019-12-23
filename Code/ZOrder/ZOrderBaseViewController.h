//
//  ZOrderBasaeViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/11/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

@import ZCollection;
#import "ZFragmentConfig.h"
NS_ASSUME_NONNULL_BEGIN


@interface ZOrderBaseCollectionViewCell : UICollectionViewCell

- (void)setTitle:(NSString *)title;

@end

@interface ZOrderBaseCollectionView : UICollectionView

@end

@interface ZOrderBaseViewController : ZCollectionNoLoadingViewController

+ (instancetype)createOrderBase;

@end

NS_ASSUME_NONNULL_END
