//
//  ZTableLoadingViewController.m
//  ZContainer
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZTableLoadingViewController.h"

@interface ZTableLoadingViewController ()

@end

@implementation ZTableLoadingViewController

- (WLBaseRefreshTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [WLBaseRefreshTableView baseTableView];
        
        _tableView.frame = self.view.bounds;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip{
    
    return [UITableViewCell new];
}
- (CGFloat )caculateForCell:(id )data forIndexPath:(NSIndexPath *)ip {
    
    return 0;
}

@end
