//
//  ZPublishTableViewCell.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTable/ZTable.h>
@import ZBean;
#import "ZFragmentMix.h"
#import "ZFragmentConfig.h"
NS_ASSUME_NONNULL_BEGIN

@protocol ZPublishTableViewCellDelegate <NSObject>

- (void)onDeleteItemClick:(ZKeyValueBean *)keyValue;

@end

@interface ZPublishTableViewCell : ZBaseTableViewCell

@property (nonatomic ,strong) ZKeyValueBean *keyValue;

@property (nonatomic ,weak) id <ZPublishTableViewCellDelegate> mDelegate;

@end

@interface ZPublishTextTableViewCell : ZPublishTableViewCell

@end

@interface ZPublishImageTableViewCell : ZPublishTableViewCell

@end
@interface ZKeyValueBean (cate)

@property (nonatomic ,strong) NSURL *videoUrl;

@end
@interface ZPublishVideoTableViewCell : ZPublishTableViewCell


@end

NS_ASSUME_NONNULL_END
