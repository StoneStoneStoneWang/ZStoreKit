//
//  ZTableLoadingViewController.h
//  ZContainer
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

@import ZLoading;
@import MJRefresh;
NS_ASSUME_NONNULL_BEGIN

@interface ZTableLoadingViewController : ZLoadingViewController

@property (nonatomic ,strong) UITableView *tableView;

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip ;

- (CGFloat )caculateForCell:(id )data forIndexPath:(NSIndexPath *)ip;

- (void)tableViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip;

- (void)tableViewEmptyShow;

- (void)tableViewEmptyHidden;
@end

NS_ASSUME_NONNULL_END
