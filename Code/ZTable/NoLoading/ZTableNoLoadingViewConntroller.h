//
//  ZTableNoLoadingViewConntroller.h
//  ZContainer
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

@import ZBase;
@import WLBaseTableView;
#import "ZBaseViewController+ZContainer.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZTableNoLoadingViewConntroller : ZBaseViewController

@property (nonatomic ,strong) WLBaseTableView *tableView;

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip ;

- (CGFloat )caculateForCell:(id )data forIndexPath:(NSIndexPath *)ip;

- (void)tableViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip;

@end


NS_ASSUME_NONNULL_END
