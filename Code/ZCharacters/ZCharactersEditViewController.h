//
//  ZCharactersEditViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/9.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import <ZTable/ZTable.h>
#import "ZFragmentConfig.h"
#import "ZFragmentMix.h"
@import ZBean;

NS_ASSUME_NONNULL_BEGIN
typedef void(^ZCharactersEditBlock)(ZCircleBean *circle);
@interface ZCharactersEditTableViewCell : ZBaseTableViewCell

@end
@interface ZCharactersEditViewController : ZTableNoLoadingViewConntroller

+ (instancetype)creatCharactersEdit:(nullable ZCircleBean *)circle andEditSucc:(ZCharactersEditBlock) succ;

@end

NS_ASSUME_NONNULL_END
