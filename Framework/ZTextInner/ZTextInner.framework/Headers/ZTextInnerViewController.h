//
//  ZTextInnerViewController.h
//  ZTextInner
//
//  Created by three stone 王 on 2020/3/26.
//  Copyright © 2020 three stone 王. All rights reserved.
//

@import ZLoading;
NS_ASSUME_NONNULL_BEGIN

@interface ZTextInnerViewController : ZLoadingViewController

- (void)loadHtmlString:(NSString *)htmlString;
@end

NS_ASSUME_NONNULL_END
