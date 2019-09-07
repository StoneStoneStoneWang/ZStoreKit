//
//  ZAMapTableViewCell.h
//  ZFragment
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTable/ZTable.h>
#import "ZFragmentMix.h"
@import ZBean;
NS_ASSUME_NONNULL_BEGIN

@interface ZAMapTableViewCell : ZBaseTableViewCell

@property (nonatomic ,strong) ZKeyValueBean *keyValue;

@end

NS_ASSUME_NONNULL_END
