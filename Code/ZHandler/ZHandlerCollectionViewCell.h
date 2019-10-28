//
//  ZHandlerCollectionViewCell.h
//  ZFragment
//
//  Created by three stone 王 on 2019/10/23.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>
@import ZBean;
#import "ZFragmentMix.h"
#import "ZFragmentConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZHandlerCollectionViewCell : UICollectionViewCell

@property (nonatomic ,strong) ZKeyValueBean *keyValue;

@end

NS_ASSUME_NONNULL_END
