//
//  ZGoldCleanerTableViewCell.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTable/ZTable.h>
#import "ZFragmentConfig.h"
#import "ZFragmentMix.h"
@import ZBean;

NS_ASSUME_NONNULL_BEGIN

@interface ZGoldCleanerTableViewCell : ZBaseTableViewCell

@property (nonatomic ,strong) ZCircleBean *keyValue;
@end

NS_ASSUME_NONNULL_END
