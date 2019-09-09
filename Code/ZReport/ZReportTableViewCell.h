//
//  ZReportTableViewCell.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTable/ZTable.h>
#import "ZFragmentMix.h"
@import ZBridge;
NS_ASSUME_NONNULL_BEGIN

@interface ZReportTableViewCell : ZBaseTableViewCell

@property (nonatomic ,strong) ZReportBean * reportBean;

@end

NS_ASSUME_NONNULL_END
