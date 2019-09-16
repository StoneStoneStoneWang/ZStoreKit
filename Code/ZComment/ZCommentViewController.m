//
//  ZCommentViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZCommentViewController.h"

#import "ZCommentTableViewCell.h"
@import ZCache;
@import JXTAlertManager;
@import ZNoti;
@import ZBridge;
@import SToolsKit;
@import ZNoti;

#define BottomBar_Height KTABBAR_HEIGHT
@interface ZCommentViewController () <UITextFieldDelegate>

@property (nonatomic ,strong) ZCommentBridge *bridge;

@property (nonatomic ,copy) NSString *encode;

@property (nonatomic ,strong ,readwrite) UIView *bottomBar;

@property (nonatomic ,strong) UITextField *editTF;

@property (nonatomic ,strong) UIButton *publishItem;

@property (nonatomic ,strong) UIButton *coverItem;

@end

@implementation ZCommentViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor]];
    
}

+ (instancetype)createCommentWithEncode:(NSString *)encode {
    
    return [[self alloc] initWithEncode:encode];
}
- (instancetype)initWithEncode:(NSString *)endcode {
    
    if (self = [super init]) {
        
        self.encode = endcode;
    }
    return self;
}

- (UIView *)bottomBar {
    
    if (!_bottomBar) {
        
        _bottomBar = [[UIView alloc] init];
        
        _bottomBar.backgroundColor = [UIColor whiteColor];
    }
    return _bottomBar;
}
- (UITextField *)editTF {
    
    if (!_editTF) {
        
        _editTF = [[UITextField alloc] initWithFrame:CGRectZero];
        
        _editTF.placeholder = @"请输入评论内容";
        
        _editTF.font = [UIFont systemFontOfSize:13];
        
        _editTF.delegate = self;
        
        _editTF.returnKeyType = UIReturnKeyDone;
    }
    return _editTF;
}
- (UIButton *)coverItem {
    
    if (!_coverItem) {
        
        _coverItem = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _coverItem;
}
- (UIButton *)publishItem {
    
    if (!_publishItem) {
        
        _publishItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_publishItem setTitle:@"发布" forState:UIControlStateNormal];
        
        [_publishItem setTitle:@"发布" forState:UIControlStateHighlighted];
        
        [_publishItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#333333"] forState:UIControlStateNormal];
        
        [_publishItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#333333"] forState:UIControlStateHighlighted];
        
        _publishItem.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _publishItem;
}

- (void)configOwnSubViews {
    
    [self.tableView registerClass:[ZCommentRectangleTableViewCell class] forCellReuseIdentifier:@"rectangle"];
    
    [self.tableView registerClass:[ZCommentTotalTableViewCell class] forCellReuseIdentifier:@"total"];
    
    [self.tableView registerClass:[ZCommentNoMoreTableViewCell class] forCellReuseIdentifier:@"nomore"];
    
    [self.tableView registerClass:[ZCommentFailedTableViewCell class] forCellReuseIdentifier:@"failed"];
    
    [self.tableView registerClass:[ZCommentContentTableViewCell class] forCellReuseIdentifier:@"content"];
    
    [self.tableView registerClass:[ZCommentEmptyTableViewCell class] forCellReuseIdentifier:@"empty"];
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSSCREEN_WIDTH, BottomBar_Height)];
    
    self.tableView.tableFooterView = footer;
    
    self.bottomBar.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - BottomBar_Height , CGRectGetWidth(self.view.bounds), BottomBar_Height);
    
    self.editTF.frame = CGRectMake(15, 0, CGRectGetWidth(self.view.bounds) - 45, 49);
    
    self.coverItem.frame = self.bottomBar.bounds;
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    self.publishItem.frame = CGRectMake(CGRectGetWidth(self.view.bounds) - 60, 0 , 40, 49);
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZCommentBean *comment = (ZCommentBean *)data;
    
    if (comment.type == WLCommentTypeRectangle) {
        
        ZCommentRectangleTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"rectangle"];
        
        cell.bottomLineType = ZBottomLineTypeNone;
        
        return cell;
        
    } else if (comment.type == WLCommentTypeTotal ) {
        
        ZCommentTotalTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"total"];
        
        cell.bottomLineType = ZBottomLineTypeNormal;
        
        return cell;
        
    } else if (comment.type == WLCommentTypeEmpty ) {
        
        ZCommentEmptyTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"empty"];
        
        cell.bottomLineType = ZBottomLineTypeNormal;
        
        return cell;
        
    } else if (comment.type == WLCommentTypeFailed ) {
        
        ZCommentFailedTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"failed"];
        
        cell.bottomLineType = ZBottomLineTypeNormal;
        
        return cell;
        
    } else if (comment.type == WLCommentTypeNoMore ) {
        
        ZCommentNoMoreTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"nomore"];
        
        cell.bottomLineType = ZBottomLineTypeNormal;
        
        return cell;
    } else {
        
        ZCommentContentTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"content"];
        
        cell.bottomLineType = ZBottomLineTypeNormal;
        
        return cell;
    }
}

- (CGFloat)caculateForCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZCommentBean *comment = (ZCommentBean *)data;
    
    if (comment.type == WLCommentTypeRectangle) {
        
        return 10;
        
    } else if (comment.type == WLCommentTypeTotal ) {
        
        return 55;
        
    } else if (comment.type == WLCommentTypeEmpty ) {
        
        return 100;
        
    } else if (comment.type == WLCommentTypeFailed ) {
        
        return 120;
        
    } else if (comment.type == WLCommentTypeNoMore ) {
        
        return 60;
    } else {
        
        CGFloat height = 60;
        
        CGFloat contnetHeight = [comment.content boundingRectWithSize:CGSizeMake(KSSCREEN_WIDTH - 60 - 40, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:13]} context:nil].size.height;
        
        height += contnetHeight;
        
        height += 20;
        
        return height ;
    }
}

- (void)configViewModel {
    
    self.bridge = [ZCommentBridge new];
    
    [self.bridge createTList:self encode:self.encode];
    
    [self.tableView.mj_header beginRefreshing];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.view addSubview:self.bottomBar];
    
    [self.bottomBar addSubview:self.editTF];
    
    [self.bottomBar addSubview:self.publishItem];
    
    [self.bottomBar addSubview:self.coverItem];
    
    [self.coverItem addTarget:self action:@selector(onCoverItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.publishItem addTarget:self action:@selector(onPublishItemClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onCoverItemClick:(UIButton *)sender {
    
    if ([[ZAccountCache shared] isLogin]) {
        
        [self.editTF becomeFirstResponder];
        
        sender.enabled = false;
    } else {
        
        [ZNotiConfigration postNotificationWithName:ZNotiUnLogin andValue:nil andFrom:self];
    }
}
- (void)onPublishItemClick:(UIButton *)sender {
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge addComment:self.encode content:self.editTF.text succ:^{
        
        [weakSelf.editTF resignFirstResponder];
    }];
}

- (void)onReloadItemClick {
    [super onReloadItemClick];
    
    [self.tableView.mj_header beginRefreshing];
}

- (BOOL)canPanResponse {
    return true;
}
- (void)configNaviItem {
    
    self.title = @"评论列表";
}

- (void)tableViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    [self.view endEditing:true];
    
    ZCommentBean *comment = (ZCommentBean *)data;
    
    if (comment.type == WLCommentTypeFailed) {
        
        [self.tableView.mj_footer beginRefreshing];
    }
}

- (void)keyboardWillShow:(NSNotification *)noti {
    
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.bottomBar.frame = CGRectMake(0, frame.origin.y - 49 , CGRectGetWidth(self.view.bounds), 49);
        
    } completion:^(BOOL finished) {
        
        
    }];
}

- (void)keyboardWillHide:(NSNotification *)noti {
    
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat h = BottomBar_Height;
    
    [UIView animateWithDuration:duration animations:^{
        
        self.bottomBar.frame = CGRectMake(0, frame.origin.y - h , CGRectGetWidth(self.view.bounds), h);
        
        self.coverItem.enabled = true;
        
    } completion:^(BOOL finished) {
        
        
    }];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return true;
}

@end
