//
//  ZOrderBaseBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/12/23.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ZCollection
import RxCocoa
import RxSwift
import RxDataSources
import ZCocoa
import ZBridge

@objc (ZOrderHeaderBridge)
public final class ZOrderHeaderBridge: ZBaseBridge {
    
    var viewModel: ZOrderHeaderViewModel!
    
    typealias Section = ZSectionModel<(), ZOrderHeaderBean>
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<Section>!
    
    var vc: ZCollectionNoLoadingViewController!
}

extension ZOrderHeaderBridge {
    
    @objc public func createOrderBase(_ vc: ZCollectionNoLoadingViewController) {
        
        self.vc = vc
        
        let input = ZOrderHeaderViewModel.WLInput(modelSelect: vc.collectionView.rx.modelSelected(ZOrderHeaderBean.self),
                                                itemSelect: vc.collectionView.rx.itemSelected)
        
        viewModel = ZOrderHeaderViewModel(input, disposed: disposed)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<Section>(
            configureCell: { ds, cv, ip, item in return vc.configCollectionViewCell(item, for: ip)})
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .tableData
            .asObservable()
            .map({ [Section(model: (), items: $0)] })
            .bind(to: vc.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { (item,ip) in
                
                vc.collectionView.deselectItem(at: ip, animated: true)
                
                vc.collectionViewSelectData(item, for: ip)
            })
            .disposed(by: disposed)
    }
}
