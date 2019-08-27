//
//  ZBaseTableViewCell.h
//  ZTable
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger ,ZBottomLineType) {
    
    ZBottomLineTypeNormal NS_SWIFT_NAME(normal),
    
    ZBottomLineTypeNone NS_SWIFT_NAME(none) ,
    
    ZBottomLineTypeCustom NS_SWIFT_NAME(custom)
};

@interface ZBaseTableViewCell : UITableViewCell

@property (nonatomic ,strong ,readonly) UIImageView *bottomView;

+ (instancetype)instance:(ZBottomLineType ) bottomLineType withReuseId:(NSString *)iden;

- (instancetype)initWith:(ZBottomLineType)bottomLineType withReuseId:(NSString *)iden;

@property (nonatomic ,assign) ZBottomLineType bottomLineType;

- (void)commitInit;
@end

NS_ASSUME_NONNULL_END
