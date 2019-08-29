//
//  ZTableListViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZTableListViewController.h"

#if ZAppFormMap

#if ZAppFormMapOne

#import "ZTableListTableViewCell.h"
@import ZBridge;

@interface ZTableListViewController ()

//@property (nonatomic ,strong)
@end

@implementation ZTableListViewController

- (void)configOwnSubViews {
    
    [self.tableView registerClass:[ZTableListTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZTableListTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.keyValue = data;
    
    cell.bottomLineType = ZBottomLineTypeNormal;
    
    return cell;
}

- (CGFloat)caculateForCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    return 5 + 25 + 20 + 20 + 15 + 40 + 5 + 5;
}

@end
#endif


#else


#endif



