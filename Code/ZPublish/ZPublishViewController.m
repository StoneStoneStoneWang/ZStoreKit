//
//  ZPublishViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZPublishViewController.h"
#import "ZPublishHeaderView.h"
#import "ZPublishTableViewCell.h"
#import "ZPublishFooterView.h"
#import "ZTextEditViewController.h"
@import ZBean;
@import SToolsKit;
@import ZBridge;
@import JXTAlertManager;
@import CoreServices;
@import WLToolsKit;
@import AVFoundation;

@interface ZPublishViewController () <UIImagePickerControllerDelegate ,UINavigationControllerDelegate ,ZPublishTableViewCellDelegate>

@property (nonatomic ,strong) ZPublishFooterView *footerView;

@property (nonatomic ,strong) ZPublishBridge *bridge;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,strong) UIImagePickerController *imagePicker;

@property (nonatomic ,strong) NSIndexPath *selectedIp;

@property (nonatomic ,strong) ZKeyValueBean *selectedKv;
@end

@implementation ZPublishViewController

- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateNormal];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateSelected];
        
        _completeItem.titleLabel.font = [UIFont systemFontOfSize:15];
        
        if ([@ZFragmentColor isEqualToString:@"#ffffff"]) {
            
            [_completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#666666"] forState:UIControlStateNormal];
            
            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#66666680"] forState:UIControlStateHighlighted];
            
            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#66666650"] forState:UIControlStateDisabled];
            
        } else {
            
            [_completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
            
            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff80"] forState:UIControlStateHighlighted];
            
            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff50"] forState:UIControlStateDisabled];
        }
    }
    return _completeItem;
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
    
    ZPublishHeaderView *headerView = [[ZPublishHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 55)];
    
    self.headerView = headerView;
    
    self.tableView.tableHeaderView = self.headerView;
    
    [self.tableView registerClass:[ZPublishTextTableViewCell class] forCellReuseIdentifier:@"text"];
    
    [self.tableView registerClass:[ZPublishImageTableViewCell class] forCellReuseIdentifier:@"image"];
    
    [self.tableView registerClass:[ZPublishVideoTableViewCell class] forCellReuseIdentifier:@"video"];
    
    ZPublishFooterView *footerView = [[ZPublishFooterView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 50)];
    
    self.tableView.tableFooterView = footerView;
    
    [footerView.textItem addTarget:self action:@selector(onTextItemClick) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView.imageItem addTarget:self action:@selector(onImageItemClick) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView.videoItem addTarget:self action:@selector(onVideoItemClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)configViewModel {
    
    self.bridge = [ZPublishBridge new];
    
    ZPublishHeaderView *headerView = (ZPublishHeaderView *)self.headerView;
    
    [self.bridge createPublish:self type:ZPublishTypeImage pTag:@"" tf:headerView.textField];
}
- (void)onTextItemClick {
    
    __weak typeof(self) weakSelf = self;
    
    ZTextEditViewController *textEdit = [ZTextEditViewController createTextEdit:^(NSString * _Nonnull text) {
        
        ZKeyValueBean *keyValue = [ZKeyValueBean new];
        
        keyValue.type = @"txt";
        
        keyValue.value = text;
        
        [weakSelf.bridge addContent:keyValue];
    }];
    
    [self presentViewController:[[ZTNavigationController alloc] initWithRootViewController:textEdit] animated:true completion:nil];
}
- (void)onDeleteItemClick:(ZKeyValueBean *)keyValue {
    
    __weak typeof(self) weakSelf = self;
    
    [self jxt_showAlertWithTitle:@"是否删除当前内容" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        
        alertMaker.
        addActionCancelTitle(@"取消").
        addActionDefaultTitle(@"确定");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        
        if ([action.title isEqualToString:@"取消"]) {
            
        }
        else if ([action.title isEqualToString:@"确定"]) {
            
            [weakSelf.bridge removeContent:keyValue];
        }
    }];
}
- (void)onImageItemClick {
    
    __weak typeof(self) weakSelf = self;
    
    self.selectedKv = nil;
    
    self.imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
    
    [self jxt_showActionSheetWithTitle:@"选择上传图片" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        
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

- (void)onVideoItemClick {
    
    __weak typeof(self) weakSelf = self;
    
    self.imagePicker.mediaTypes = @[(NSString *)kUTTypeMovie];
    
    self.imagePicker.videoQuality = UIImagePickerControllerQualityTypeMedium;
    
    self.imagePicker.videoMaximumDuration = 60;
    
    self.selectedKv = nil;
    
    [self jxt_showActionSheetWithTitle:@"选择上传视频" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        
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

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZKeyValueBean *keyValue = (ZKeyValueBean *)data;
    
    if ([keyValue.type isEqualToString:@"txt"]) {
        
        ZPublishTextTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"text"];
        
        cell.keyValue = data;
        
        cell.mDelegate = self;
        
        return cell;
    } else if ([keyValue.type isEqualToString:@"image"]) {
        
        ZPublishImageTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"image"];
        
        cell.keyValue = data;
        
        cell.mDelegate = self;
        
        return cell;
    } else {
        
        ZPublishVideoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"video"];
        
        cell.keyValue = data;
        
        cell.mDelegate = self;
        
        return cell;
    }
}

- (void)tableViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZKeyValueBean *keyValue = (ZKeyValueBean *)data;
    
    __weak typeof(self) weakSelf = self;
    
    if ([keyValue.type isEqualToString:@"txt"]) {
        
        ZTextEditViewController *textEdit = [ZTextEditViewController createTextEdit:^(NSString * _Nonnull text) {
            
            keyValue.value = text;
            
            [weakSelf.bridge replaceContent:keyValue];
        }];
        
        [self presentViewController:[[ZTNavigationController alloc] initWithRootViewController:textEdit] animated:true completion:nil];
        
        
    } else if ([keyValue.type isEqualToString:@"image"]) {
        
        self.selectedKv = keyValue;
        
        [self jxt_showActionSheetWithTitle:@"选择上传图片" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            
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
        
    } else {
        
        self.selectedKv = keyValue;
        
        [self jxt_showActionSheetWithTitle:@"选择上传视频" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            
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
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    __weak typeof(self) weakSelf = self;
    
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    
    if (picker.allowsEditing) {
        
        originalImage = info[UIImagePickerControllerEditedImage];
    }
    
    if (originalImage) {
        
        [weakSelf.bridge updateImage:[UIImage compressImageWithImage:originalImage andMaxLength:30 * 1024] succ:^(NSString * _Nonnull value) {
            
            if (weakSelf.selectedKv) {
                
                weakSelf.selectedKv.value = value;
                
                weakSelf.selectedKv.img = originalImage;
                
                [weakSelf.bridge replaceContent:weakSelf.selectedKv];
                
            } else {
                
                ZKeyValueBean *keyValue = [ZKeyValueBean new];
                
                keyValue.type = @"image";
                
                keyValue.value = value;
                
                keyValue.img = originalImage;
                
                [weakSelf.bridge addContent:keyValue];
            }
        }];
    } else {
        
        NSURL *url = info[UIImagePickerControllerMediaURL];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        [weakSelf.bridge updateVideo:data succ:^(NSString * _Nonnull value) {
            
            if (weakSelf.selectedKv) {
                
                weakSelf.selectedKv.value = value;
                
                weakSelf.selectedKv.img = [ZPublishViewController firstFrameWithVideoURL:url size:CGSizeMake(KSSCREEN_WIDTH, KSSCREEN_WIDTH / 2)];
                
                weakSelf.selectedKv.videoUrl = url;
                
                [weakSelf.bridge replaceContent:weakSelf.selectedKv];
                
            } else {
                
                ZKeyValueBean *keyValue = [ZKeyValueBean new];
                
                keyValue.type = @"video";
                
                keyValue.value = value;
                
                keyValue.videoUrl = url;
                
                keyValue.img = [ZPublishViewController firstFrameWithVideoURL:url size:CGSizeMake(KSSCREEN_WIDTH, KSSCREEN_WIDTH / 2)];
                
                [weakSelf.bridge addContent:keyValue];
            }
        }];
        
    }
    
    [picker dismissViewControllerAnimated:true completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:true completion:nil];
}

- (BOOL)canPanResponse {
    
    return true ;
}
- (CGFloat)caculateForCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    ZKeyValueBean *keyValue = (ZKeyValueBean *)data;
    
    if ([keyValue.type isEqualToString:@"txt"]) {
        
        CGFloat height = 0;
        
        CGFloat contnetHeight = [keyValue.value boundingRectWithSize:CGSizeMake(KSSCREEN_WIDTH - 30, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size.height;
        
        height += contnetHeight;
        
        height += 20;
        
        return height;
    } else {
        
        return (KSSCREEN_WIDTH - 30) / 2  + 10;
    }
}
+ (UIImage *)firstFrameWithVideoURL:(NSURL *)url size:(CGSize)size
{
    // 获取视频第一帧
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.appliesPreferredTrackTransform = YES;
    generator.maximumSize = CGSizeMake(size.width, size.height);
    NSError *error = nil;
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 10) actualTime:NULL error:&error];
    {
        return [UIImage imageWithCGImage:img];
    }
    return nil;
}
- (void)configNaviItem {
    
    [self.completeItem sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.completeItem];
    
    self.title = @"发布话题";
}

@end
