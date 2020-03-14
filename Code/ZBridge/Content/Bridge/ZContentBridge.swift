//
//  ZContentBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/9/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ZTable
import RxDataSources
import ZCocoa
import RxCocoa
import RxSwift
import ZBean

public typealias ZContentAction = (_ keyValue: ZKeyValueBean,_ ip: IndexPath) -> ()

@objc (ZContentBridge)
public final class ZContentBridge: ZBaseBridge {
    
    typealias Section = ZSectionModel<(), ZKeyValueBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: ZContentViewModel!
    
    weak var vc: ZTableNoLoadingViewConntroller!
}

extension ZContentBridge {
    
    @objc public func createContent(_ vc: ZTableNoLoadingViewConntroller ,circleBean: ZCircleBean ,contentAction: @escaping ZContentAction) {
        
        self.vc = vc
        
        let input = ZContentViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(ZKeyValueBean.self),
                                              itemSelect: vc.tableView.rx.itemSelected,
                                              circle: circleBean)
        
        viewModel = ZContentViewModel(input)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(item, for: ip)  })
        
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
                
                contentAction(type,ip)
            })
            .disposed(by: disposed)
        
        vc
            .tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
        
    }
}
extension ZContentBridge: UITableViewDelegate {
    
    @objc public func converToCircle(_ circleJson: [String : Any]) -> ZCircleBean {
        
        return ZCircleBean(JSON: circleJson)!
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return vc.caculate(forCell: datasource[indexPath], for: indexPath)
    }
}
