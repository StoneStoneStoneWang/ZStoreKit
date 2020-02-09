//
//  ZOrderViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/11/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTable/ZTable.h>
@import ZBridge;    
NS_ASSUME_NONNULL_BEGIN


@interface ZOrderViewController : ZTableLoadingViewController

+ (instancetype)createOrder:(NSString *)tag;

@end

@interface ZOrderTableViewCell : ZBaseTableViewCell

@property (nonatomic ,strong) ZCircleBean *circleBean;

@end

NS_ASSUME_NONNULL_END
