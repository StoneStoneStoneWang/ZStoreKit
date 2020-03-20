//
//  ZAreaHeaderBridge.swift
//  ZBombBridge
//
//  Created by three stone 王 on 2020/3/19.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import ZCollection
import RxCocoa
import RxSwift
import RxDataSources
import ZCocoa
import ZBridge

@objc (ZAreaHeaderBridge)
public final class ZAreaHeaderBridge: ZBaseBridge {
    
    var viewModel: ZAreaHeaderViewModel!
    
    typealias Section = ZSectionModel<(), ZAreaHeaderBean>
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<Section>!
}
// MARK: skip item 101 pagecontrol 102
extension ZAreaHeaderBridge {
    
    @objc public func createAreaHeader(_ vc: ZCollectionNoLoadingViewController) {
        
        let input = ZAreaHeaderViewModel.WLInput(modelSelect: vc.collectionView.rx.modelSelected(ZAreaHeaderBean.self),
                                                 itemSelect: vc.collectionView.rx.itemSelected)
        
        viewModel = ZAreaHeaderViewModel(input, disposed: disposed)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<Section>(
            configureCell: { ds, cv, ip, item in return vc.configCollectionViewCell(item, for: ip) })
        
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
            .subscribe(onNext: { (area,ip) in
                
                vc.collectionView.deselectItem(at: ip, animated: true)
                
                vc.collectionViewSelectData(area, for: ip)
            })
            .disposed(by: disposed)
    }
    
    @objc public func addheader(_ header: ZAreaHeaderBean) {
        
        var values = viewModel.output.tableData.value
        
        values += [header]
        
        viewModel.output.tableData.accept(values)
    }
    
    @objc public func fetchHeaderCount() -> Int {
        
        return viewModel.output.tableData.value.count
    }
    @objc public func removeHeader(_ header: ZAreaHeaderBean) {
        
        var values = viewModel.output.tableData.value
        
        if let idx = values.firstIndex(where: {  $0 == header }) {
            values.remove(at: idx)
        }
        viewModel.output.tableData.accept(values)
    }
}
