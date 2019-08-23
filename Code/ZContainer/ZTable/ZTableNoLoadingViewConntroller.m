//
//  ZTableNoLoadingViewConntroller.m
//  ZContainer
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZTableNoLoadingViewConntroller.h"

@implementation ZTableNoLoadingViewConntroller

- (WLBaseTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [WLBaseTableView baseTableView];
        
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
- (void)tableViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    
}
@end
