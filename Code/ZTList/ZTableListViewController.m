//
//  ZTableListViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZTableListViewController.h"
#import "ZTableListTableViewCell.h"
#if ZAppFormMap

#if ZAppFormMapOne

@import ZBridge;

@interface ZTableListViewController ()

@property (nonatomic ,strong) ZTListBridge *bridge;

@property (nonatomic ,assign) BOOL isMy;

@property (nonatomic ,strong) NSString *tag;

@end

@implementation ZTableListViewController

+ (instancetype)createTableList:(BOOL )isMy andTag:(NSString *)tag {
    
    return [[self alloc] initWithTableList:isMy andTag:tag];
}

- (instancetype)initWithTableList:(BOOL )isMy andTag:(NSString *)tag {
    
    if (self = [super init]) {
        
        self.isMy = isMy;
        
        self.tag = tag;
    }
    return self;
}
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
- (void)configViewModel {
    
    self.bridge = [ZTListBridge new];
    
    [self.bridge createFocus:self isMy:false tag:self.tag];
}

@end

#endif


#else


#endif



