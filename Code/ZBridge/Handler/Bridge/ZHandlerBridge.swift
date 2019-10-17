//
//  ZHandlerBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/10/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ZCollection
import RxDataSources
import ZCocoa
import ZHud
import RxCocoa
import RxSwift
import ZBean
import ZNoti
import ZRealReq

public typealias ZHandlerOperateSucc = (_ value: String) -> ()

@objc (ZHandlerBridge)
public final class ZHandlerBridge: ZBaseBridge {
    
    typealias Section = ZSectionModel<(), ZKeyValueBean>
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<Section>!
    
    var viewModel: ZHandlerViewModel!
    
    weak var vc: ZCollectionNoLoadingViewController!
}

extension ZHandlerBridge {
    
    @objc public func createHandler(_ vc: ZCollectionNoLoadingViewController,pTag: String,tf: UITextField ) {
        
        if let completeItem = vc.navigationItem.rightBarButtonItem?.customView as? UIButton {
            
            self.vc = vc
            
            let input = ZHandlerViewModel.WLInput(tag: pTag,
                                                  modelSelect: vc.collectionView.rx.modelSelected(ZKeyValueBean.self),
                                                  itemSelect: vc.collectionView.rx.itemSelected,
                                                  completeTaps: completeItem.rx.tap.asSignal())
            
            viewModel = ZHandlerViewModel(input)
            
            let dataSource = RxCollectionViewSectionedReloadDataSource<Section>(
                configureCell: { ds, tv, ip, item in return vc.configCollectionViewCell(item, for: ip)})
            
            viewModel
                .input
                .tableData
                .asDriver()
                .map({ [Section(model: (), items: $0)]  })
                .drive(vc.collectionView.rx.items(dataSource: dataSource))
                .disposed(by: disposed)
            
            self.dataSource = dataSource
            
            viewModel
                .output
                .zip
                .subscribe(onNext: { (type,ip) in
                    
                    vc.collectionViewSelectData(type, for: ip)
                })
                .disposed(by: disposed)
            
            
            viewModel
                .output
                .completing
                .drive(onNext: { _ in
                    
                    vc.view.endEditing(true)
                    
                    ZHudUtil.show(withStatus: "您发布的内容会在我们的系统1小时内审核，发布中...")
                    
                })
                .disposed(by: disposed)
            
            // MARK: 登录事件返回序列
            viewModel
                .output
                .completed
                .drive(onNext: {
                    
                    ZHudUtil.pop()
                    
                    switch $0 {
                        
                    case let .failed(msg): ZHudUtil.showInfo(msg)
                        
                    case let .operation(obj):
                        
                        ZHudUtil.showInfo("发布成功")
                        
                        ZNotiConfigration.postNotification(withName: NSNotification.Name(ZNotiCirclePublishSucc), andValue: ["tag": pTag,"circle": obj], andFrom: vc)
                        
                        vc.dismiss(animated: true, completion: nil)
                        
                    default: break
                    }
                })
                .disposed(by: disposed)
        }
    }
    
    @objc public func replaceContent(_ keyValue: ZKeyValueBean) {
        
//        vc.tableView.reloadData()
    }
    
}
