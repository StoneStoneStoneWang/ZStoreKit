//
//  ZConntentTableViewCell.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/20.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTable/ZTable.h>
@import ZBean;
#import "ZFragmentMix.h"
#import "ZFragmentConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZContentTableViewCell : ZBaseTableViewCell

@property (nonatomic ,strong) ZKeyValueBean *keyValue;

@end

@interface ZContentTextTableViewCell : ZContentTableViewCell

@end

@interface ZContentImageTableViewCell : ZContentTableViewCell

@end


NS_ASSUME_NONNULL_END
