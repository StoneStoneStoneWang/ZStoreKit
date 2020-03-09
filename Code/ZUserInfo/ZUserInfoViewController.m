//
//  ZUserInfoViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZUserInfoViewController.h"
#import "ZUserInfoTableViewCell.h"
#import "ZNickNameViewController.h"
#import "ZSignatureViewController.h"
#import "ZFragmentConfig.h"
@import ZBridge;
@import JXTAlertManager;
@import ZDatePicker;
@import SToolsKit;
@import CoreServices;
@import WLToolsKit;

@interface ZUserInfoViewController () <UIImagePickerControllerDelegate ,UINavigationControllerDelegate>

@property (nonatomic ,strong) ZUserInfoBridge *bridge;

@property (nonatomic ,strong) ZDatePicker *picker;

@property (nonatomic ,strong) UIImagePickerController *imagePicker;

@end

@implementation ZUserInfoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor]];
    
}

- (UIImagePickerController *)imagePicker {
    
    if (!_imagePicker) {
        
        _imagePicker = [UIImagePickerController new];
        
        _imagePicker.allowsEditing = false;
        
        _imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
        
        _imagePicker.delegate = self;
    }
    return _imagePicker;
}

- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.tableView registerClass:[ZUserInfoTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZUserInfoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.userInfo = data;
    
    return cell;
}

- (void)configViewModel {
    
    self.bridge = [ZUserInfoBridge new];
    
    [self.bridge createUserInfo:self];
}

- (void)configNaviItem {
    
    self.title = @"我的资料";
}
- (void)tableViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZUserInfoBean *userInfo = (ZUserInfoBean *)data;
    
    switch (userInfo.type) {
        case ZUserInfoTypeName:
        {
            __weak typeof(self) weakSelf = self;
            
            ZNickNameViewController *nickname = [ZNickNameViewController createNickname:^{
                
                [weakSelf.tableView reloadData];
            }];
            
            [self presentViewController:[[ZTNavigationController alloc] initWithRootViewController:nickname] animated:true completion:nil];
        }
            break;
        case ZUserInfoTypeSignature:
        {
            
            __weak typeof(self) weakSelf = self;
            
            ZSignatureViewController *signature = [ZSignatureViewController createSignature:^{
                
                [weakSelf.tableView reloadData];
            }];
            
            [self presentViewController:[[ZTNavigationController alloc] initWithRootViewController:signature] animated:true completion:nil];
        }
            break;
        case ZUserInfoTypeSex:
        {
            __weak typeof(self) weakSelf = self;
            
            [self jxt_showActionSheetWithTitle:@"选择性别" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                
                alertMaker.
                addActionCancelTitle(@"取消").
                addActionDefaultTitle(@"男").
                addActionDefaultTitle(@"女");
            } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                
                if ([action.title isEqualToString:@"取消"]) {
                    
                }
                else if ([action.title isEqualToString:@"男"]) {
                    
                    [weakSelf.bridge updateUserInfoWithType:ZUserInfoTypeSex value:@"1" succ:^{
                        
                        [weakSelf.tableView reloadData];
                    }];
                    
                } else if ([action.title isEqualToString:@"女"]) {
                    
                    [weakSelf.bridge updateUserInfoWithType:ZUserInfoTypeSex value:@"2" succ:^{
                        
                        [weakSelf.tableView reloadData];
                        
                    }];
                }
            }];
        }
            break;
        case ZUserInfoTypeBirth:
        {
            if (!self.picker) {
                
                self.picker = [[ZDatePicker alloc] initWithTextColor:[UIColor s_transformToColorByHexColorStr:@"#666666"] buttonColor:[UIColor s_transformToColorByHexColorStr:@ZFragmentColor] font:[UIFont systemFontOfSize:15] locale:[NSLocale localeWithLocaleIdentifier:@"zh-Hans"] showCancelButton:true];
            }
            
            __weak typeof(self) weakSelf = self;
            
            [self.picker show:@"" doneButtonTitle:@"完成" cancelButtonTitle:@"取消" defaultDate:[NSDate date] minimumDate:nil maximumDate:[NSDate date] datePickerMode:UIDatePickerModeDate callback:^(NSDate * _Nullable date) {
                
                if (date) {
                    
                    [weakSelf.bridge updateUserInfoWithType:ZUserInfoTypeBirth value:[NSString stringWithFormat:@"%ld",(NSInteger)date.timeIntervalSince1970] succ:^{
                        
                        [weakSelf.tableView reloadData];
                    }];
                }
            }];
        }
            break;
        case ZUserInfoTypeHeader:
        {
            
            __weak typeof(self) weakSelf = self;
            
            [self jxt_showActionSheetWithTitle:@"选择头像图片" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                
                alertMaker.
                addActionCancelTitle(@"取消").
                addActionDefaultTitle(@"相册").
                addActionDefaultTitle(@"相机");
            } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                
                if ([action.title isEqualToString:@"取消"]) {
                    
                }
                else if ([action.title isEqualToString:@"相册"]) {
                    
                    weakSelf.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    
                    [weakSelf presentViewController:weakSelf.imagePicker animated:true completion:nil];
                    
                } else if ([action.title isEqualToString:@"相机"]) {
                    
                    weakSelf.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    
                    [weakSelf presentViewController:weakSelf.imagePicker animated:true completion:nil];
                }
            }];
        }
            break;
        default:
            break;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    __weak typeof(self) weakSelf = self;
    
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    
    if (picker.allowsEditing) {
        
        originalImage = info[UIImagePickerControllerEditedImage];
    }
    
    [self.bridge updateHeader:[UIImage compressImageWithImage:originalImage andMaxLength:500 * 1024] succ:^{
        
        [weakSelf.tableView reloadData];
    }];
    
    [picker dismissViewControllerAnimated:true completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:true completion:nil];
}

- (BOOL)canPanResponse {
    
    return true ;
}


@end
