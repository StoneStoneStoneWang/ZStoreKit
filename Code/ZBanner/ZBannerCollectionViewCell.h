//
//  ZBannerCollectionViewCell.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>
@import ZBean;
#import "ZFragmentMix.h"
#import "ZFragmentConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZBannerCollectionViewCell : UICollectionViewCell

@property (nonatomic ,strong) ZCircleBean *circleBean;

- (void)commitInit;

@end

@interface ZBannerImageCollectionViewCell : ZBannerCollectionViewCell

- (void)setImage:(NSString *)image;

@end

@interface ZBannerVideoCollectionViewCell : ZBannerCollectionViewCell


@end

NS_ASSUME_NONNULL_END
