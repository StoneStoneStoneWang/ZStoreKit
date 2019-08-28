//
//  ZUserInfoBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/8/28.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ZTable
import ZHud
import ZBean
import RxCocoa
import ZCache
import RxSwift
import RxDataSources
import WLBaseTableView
import ZRealReq
import ZUpload

public typealias ZUserInfoOperateSucc = () -> ()

@objc (ZUserInfoBridge)
public final class ZUserInfoBridge: ZBaseBridge {
    
    typealias Section = WLSectionModel<(), ZUserInfoBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: ZUserInfoViewModel!
}

extension ZUserInfoBridge {
    
    @objc public func createUserInfo(_ vc: ZTableNoLoadingViewConntroller) {
        
        let input = ZUserInfoViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(ZUserInfoBean.self),
                                               itemSelect: vc.tableView.rx.itemSelected)
        
        viewModel = ZUserInfoViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(item, for: ip)})
        
        viewModel
            .output
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
                
                vc.tableView.deselectRow(at: ip, animated: true)
                
                vc.tableViewSelectData(type, for: ip)
            })
            .disposed(by: disposed)
        vc
            .tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
    }
    
    @objc public func updateUserInfo(type: ZUserInfoType,value: String,succ: @escaping ZUserInfoOperateSucc) {
        
        ZHudUtil.show(withStatus: "修改\(type.title)中...")
        
        ZUserInfoViewModel
            .updateUserInfo(type: type, value: value)
            .drive(onNext: { (result) in
                
                ZHudUtil.pop()
                switch result {
                    
                case .ok(let msg): ZHudUtil.showInfo(msg)
                case .failed(let msg): ZHudUtil.showInfo(msg)
                default: break
                }
            })
            .disposed(by: disposed)
    }
    @objc public func updateHeader(_ data: Data ,succ: @escaping ZUserInfoOperateSucc) {
        
        ZHudUtil.show(withStatus: "上传头像中...")
        
        ZUserInfoViewModel
            .fetchAliToken()
            .drive(onNext: { (result) in
                
                switch result {
                case .fetchSomeObject(let obj):
                    
                    DispatchQueue.global().async {
                        
                        onUploadImgResp(data, file: "headerImg", param: obj as! ZALCredentialsBean)
                            .subscribe(onNext: { [weak self] (value) in
                                
                                guard let `self` = self else { return }
                                
                                DispatchQueue.main.async {
                                    
                                    self.updateUserInfo(type: ZUserInfoType.header, value: value, succ: succ)
                                }
                                
                                }, onError: { (error) in
                                    
                                    ZHudUtil.pop()
                                    
                                    ZHudUtil.showInfo("上传头像失败")
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
}
extension ZUserInfoBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return datasource[indexPath].type.cellHeight
    }
}
