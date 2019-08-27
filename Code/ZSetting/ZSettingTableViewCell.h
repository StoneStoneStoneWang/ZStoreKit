//
//  ZSettingTableViewCell.h
//  ZFragment
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFragmentConfig.h"
@import ZTable;
@import ZBridge;
NS_ASSUME_NONNULL_BEGIN

@interface ZSettingTableViewCell : ZBaseTableViewCell

@property (nonatomic ,strong) ZSettingBean *setting;

@end

NS_ASSUME_NONNULL_END
