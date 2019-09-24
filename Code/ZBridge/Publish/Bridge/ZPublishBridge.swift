//
//  ZPublishBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/9/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ZTable
import RxDataSources
import ZCocoa
import ZHud
import RxCocoa
import RxSwift
import ZBean
import ZNoti
import ZRealReq
import ZUpload
import AVFoundation

public typealias ZPublishOperateSucc = (_ value: String) -> ()

@objc (ZPublishBridge)
public final class ZPublishBridge: ZBaseBridge {
    
    typealias Section = ZSectionModel<(), ZKeyValueBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: ZPublishViewModel!
    
    weak var vc: ZTableNoLoadingViewConntroller!
}

extension ZPublishBridge {
    
    @objc public func createPublish(_ vc: ZTableNoLoadingViewConntroller ,type: ZPublishType,pTag: String,tf: UITextField ) {
        
        if let completeItem = vc.navigationItem.rightBarButtonItem?.customView as? UIButton {
            
            self.vc = vc
            
            let input = ZPublishViewModel.WLInput(tag: pTag,
                                                  title: tf.rx.text.orEmpty.asDriver(),
                                                  modelSelect: vc.tableView.rx.modelSelected(ZKeyValueBean.self),
                                                  itemSelect: vc.tableView.rx.itemSelected,
                                                  completeTaps: completeItem.rx.tap.asSignal())
            
            viewModel = ZPublishViewModel(input, type: type)
            
            let dataSource = RxTableViewSectionedReloadDataSource<Section>(
                configureCell: { ds, tv, ip, item in return vc.configTableViewCell(item, for: ip)  },
                canEditRowAtIndexPath: { _,_ in return true })
            
            viewModel
                .input
                .tableData
                .asDriver()
                .map({ [Section(model: (), items: $0)]  })
                .drive(vc.tableView.rx.items(dataSource: dataSource))
                .disposed(by: disposed)
            
            self.dataSource = dataSource
            
            viewModel
                .output
                .zip
                .subscribe(onNext: { (type,ip) in
                    
                    vc.tableViewSelectData(type, for: ip)
                })
                .disposed(by: disposed)
            
            vc
                .tableView
                .rx
                .setDelegate(self)
                .disposed(by: disposed)
            
        }
    }
    
    @objc public func removeContent(_ keyValue: ZKeyValueBean) {
        
        var value = viewModel.input.tableData.value
        
        if let idx = value.firstIndex(of: keyValue) {
            
            value.remove(at: idx)
        }
        
        viewModel.input.tableData.accept(value)
    }
    
    @objc public func addContent(_ keyValue: ZKeyValueBean) {
        
        var value = viewModel.input.tableData.value
        
        value += [keyValue]
        
        viewModel.input.tableData.accept(value)
    }
    @objc public func replaceContent(_ keyValue: ZKeyValueBean) {
        
        vc.tableView.reloadData()
    }
    
    @objc public func updateImage(_ data: Data ,succ: @escaping ZPublishOperateSucc) {
        
        ZHudUtil.show(withStatus: "上传图片中...")
        
        ZUserInfoViewModel
            .fetchAliToken()
            .drive(onNext: { (result) in
                
                switch result {
                case .fetchSomeObject(let obj):
                    
                    DispatchQueue.global().async {
                        
                        onUploadImgResp(data, file: "circle", param: obj as! ZALCredentialsBean)
                            .subscribe(onNext: { [weak self] (value) in
                                
                                guard let `self` = self else { return }
                                
                                DispatchQueue.main.async {
                                    
                                    succ(value)
                                    
                                    ZHudUtil.pop()
                                    ZHudUtil.showInfo("上传图片成功")
                                }
                                
                                }, onError: { (error) in
                                    
                                    ZHudUtil.pop()
                                    
                                    ZHudUtil.showInfo("上传图片失败")
                            })
                            .disposed(by: self.disposed)
                    }
                    
                case let .failed(msg):
                    
                    ZHudUtil.pop()
                    
                    ZHudUtil.showInfo(msg)
                    
                default: break
                    
                }
            })
            .disposed(by: disposed)
    }
    @objc public func updateVideo(_ data: Data ,succ: @escaping ZPublishOperateSucc) {
        
        ZHudUtil.show(withStatus: "上传视频中...")
        
        ZUserInfoViewModel
            .fetchAliToken()
            .drive(onNext: { (result) in
                
                switch result {
                case .fetchSomeObject(let obj):
                    
                    DispatchQueue.global().async {
                        
                        onUploadVideoResp(data, file: "circle", param: obj as! ZALCredentialsBean)
                            .subscribe(onNext: { (value) in
                                
                                ZHudUtil.pop()
                                
                                ZHudUtil.showInfo("上传视频成功")
                                
                                DispatchQueue.main.async {
                                    
                                    succ(value)
                                }
                                
                            }, onError: { (error) in
                                
                                ZHudUtil.pop()
                                
                                ZHudUtil.showInfo("上传视频失败")
                                
                            })
                            .disposed(by: self.disposed)
                    }
                    
                case let .failed(msg):
                    
                    ZHudUtil.pop()
                    
                    ZHudUtil.showInfo(msg)
                    
                default: break
                    
                }
            })
            .disposed(by: disposed)
    }
    @objc public static func movFileTransformToMp4WithSourceUrl(sourceUrl: URL) -> URL? {
        //以当前时间来为文件命名
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        let fileName = formatter.string(from: date) + ".mp4"
        
        //保存址沙盒路径
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
        let videoSandBoxPath = (docPath as String) + "/ablumVideo" + fileName
        
        print(videoSandBoxPath)
        
        //转码配置
        let avAsset = AVURLAsset(url: sourceUrl, options: nil)
        
        //取视频的时间并处理，用于上传
        let time = avAsset.duration
        let number = Float(CMTimeGetSeconds(time)) - Float(Int(CMTimeGetSeconds(time)))
        let totalSecond = number > 0.5 ? Int(CMTimeGetSeconds(time)) + 1 : Int(CMTimeGetSeconds(time))
        let photoId = String(totalSecond)
        
        let exportSession = AVAssetExportSession(asset: avAsset, presetName: AVAssetExportPresetMediumQuality)
        exportSession?.shouldOptimizeForNetworkUse = true
        exportSession?.outputURL = URL(fileURLWithPath: videoSandBoxPath)
        exportSession?.outputFileType = AVFileType.mp4 //控制转码的格式
        
        let wait = DispatchSemaphore(value: 0)
        
        exportSession?.exportAsynchronously(completionHandler: {
            if exportSession?.status == AVAssetExportSession.Status.failed {
                print("转码失败")
            }
            if exportSession?.status == AVAssetExportSession.Status.completed {
                print("转码成功")
            }
            
            wait.signal()
        })
        
        let timeout = wait.wait(timeout: DispatchTime.distantFuture)
        
        if timeout == .timedOut  {
            
            debugPrint("超时")
        }
        
        wait.suspend()
        
        return URL(fileURLWithPath: videoSandBoxPath)
    }
    
    @objc public static func getVideoCropPicture(videoUrl: URL) -> UIImage {
        let avAsset = AVAsset(url: videoUrl)
        let generator = AVAssetImageGenerator(asset: avAsset)
        generator.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(0.0, preferredTimescale: 600)
        var actualTime: CMTime = CMTimeMake(value: 0, timescale: 0)
        let imageP = try? generator.copyCGImage(at: time, actualTime: &actualTime)
        let image = UIImage.init(cgImage: imageP!)
        return image
    }
}

extension ZPublishBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return vc.caculate(forCell: datasource[indexPath], for: indexPath)
    }
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "删除") { [weak self] (a, ip) in
            
            guard let `self` = self else { return }
            
            let type = self.dataSource[ip]
            
            let alert = UIAlertController(title: "删除内容", message: "是否删除当前内容？", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "取消", style: .cancel) { (a) in }
            
            let confirm = UIAlertAction(title: "确定", style: .default) { [weak self] (a) in
                
                guard let `self` = self else { return }
                
                self.removeContent(type)
            }
            
            alert.addAction(cancel)
            
            alert.addAction(confirm)
            
            self.vc.present(alert, animated: true, completion: nil)
            
        }
        
        return [delete]
    }
}
