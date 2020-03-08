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

@objc (ZOrderBaseBridge)
public final class ZOrderBaseBridge: ZBaseBridge {
    
    var viewModel: ZOrderBaseViewModel!
    
    typealias Section = ZSectionModel<(), String>
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<Section>!
    
    var vc: ZCollectionNoLoadingViewController!
}

extension ZOrderBaseBridge {
    
    @objc public func createOrderBase(_ vc: ZCollectionNoLoadingViewController ,tableData: [String]) {
        
        self.vc = vc
        
        let input = ZOrderBaseViewModel.WLInput(modelSelect: vc.collectionView.rx.modelSelected(String.self),
                                                itemSelect: vc.collectionView.rx.itemSelected, tableData: tableData)
        
        viewModel = ZOrderBaseViewModel(input, disposed: disposed)
        
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
                
                vc.collectionViewSelectData(item, for: ip)
            })
            .disposed(by: disposed)
    }
}
