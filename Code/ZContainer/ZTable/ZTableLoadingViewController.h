//
//  ZTableLoadingViewController.h
//  ZContainer
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

@import ZLoading;
@import WLBaseTableView;
#import "ZBaseViewController+ZContainer.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZTableLoadingViewController : ZLoadingViewController

@property (nonatomic ,strong) WLBaseRefreshTableView *tableView;

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip ;

- (CGFloat )caculateForCell:(id )data forIndexPath:(NSIndexPath *)ip;



@end

NS_ASSUME_NONNULL_END
