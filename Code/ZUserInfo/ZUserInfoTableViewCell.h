//
//  ZUserInfoTableViewCell.h
//  ZFragment
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFragmentMix.h"
#import "ZFragmentConfig.h"
@import ZBridge;
@import ZTable;

NS_ASSUME_NONNULL_BEGIN

@interface ZUserInfoTableViewCell : ZBaseTableViewCell

@property (nonatomic ,strong) ZUserInfoBean *userInfo;

@end

NS_ASSUME_NONNULL_END
