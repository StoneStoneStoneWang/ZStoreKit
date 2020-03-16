//
//  ZReportViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTable/ZTable.h>
#import "ZFragmentConfig.h"
#import "ZFragmentMix.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZReportViewController : ZTableNoLoadingViewConntroller

+ (instancetype)createReportWithUid:(NSString *)uid andEncode:(NSString *)encode;

@end

NS_ASSUME_NONNULL_END
