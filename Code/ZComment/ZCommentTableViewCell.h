//
//  ZCommentTableViewCell.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTable/ZTable.h>
#import "ZFragmentMix.h"
@import ZBean;
NS_ASSUME_NONNULL_BEGIN

@interface ZCommentTableViewCell : ZBaseTableViewCell

@property (nonatomic ,strong) ZCommentBean *comment;

@end

@interface ZCommentTotalTableViewCell : ZCommentTableViewCell

@end

@interface ZCommentRectangleTableViewCell : ZCommentTableViewCell

@end

@interface ZCommentNoMoreTableViewCell : ZCommentTableViewCell

@end

@interface ZCommentFailedTableViewCell : ZCommentTableViewCell

@end

@interface ZCommentEmptyTableViewCell : ZCommentTableViewCell

@end

@interface ZCommentContentTableViewCell : ZCommentTableViewCell


@end

NS_ASSUME_NONNULL_END

