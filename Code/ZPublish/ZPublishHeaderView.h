//
//  ZPublishHeaderView.h
//  ZFragment
//
//  Created by three stone 王 on 2019/9/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZTable/ZTable.h>
#import "ZFragmentMix.h"
#import "ZFragmentConfig.h"
@import ZTextField;

NS_ASSUME_NONNULL_BEGIN

@interface ZPublishHeaderView : ZTableHeaderView

@property (nonatomic ,strong ,readonly) WLBaseTextField *textField;

@end

NS_ASSUME_NONNULL_END
