//
//  ZSettingBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/8/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ZTable
import RxDataSources
import WLBaseTableView
import ZNoti
import ZCache

@objc (ZSettingBridge)
public final class ZSettingBridge: ZBaseBridge {
    
    typealias Section = WLSectionModel<(), ZSettingType>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: ZSettingViewModel!
    
    weak var vc: ZTableNoLoadingViewConntroller!
}
extension ZSettingBridge {
    
    @objc public func createSetting(_ vc: ZTableNoLoadingViewConntroller) {
        
        self.vc = vc
        
        let input = ZSettingViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(ZSettingType.self),
                                              itemSelect: vc.tableView.rx.itemSelected)
        
        viewModel = ZSettingViewModel(input)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in  return vc.configTableViewCell(ZSettingBean.createSetting(item, title: item.title), for: ip) })
        
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
                
                switch type {
                    
                case .pwd:
                    
                    ZNotiConfigration.postNotification(withName: NSNotification.Name(ZNotiGotoFindPwd), andValue: nil, andFrom: vc)
                    
                case .password:
                    
                    ZNotiConfigration.postNotification(withName: NSNotification.Name(ZNotiGotoModifyPwd), andValue: nil, andFrom: vc)
                    
                case .logout:
                    
                    ZNotiConfigration.postNotification(withName: NSNotification.Name(ZNotiLogout), andValue: nil, andFrom: vc)
                    
                case .black:
                    
                    if ZAccountCache.default.isLogin() {
                        
                        ZNotiConfigration.postNotification(withName: NSNotification.Name(ZNotiUnLogin), andValue: nil, andFrom: vc)
                    } else {
                        
                        ZNotiConfigration.postNotification(withName: NSNotification.Name(ZNotiGotoBlack), andValue: nil, andFrom: vc)
                    }
                    
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
        vc
            .tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
    }
}
extension ZSettingBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return datasource[indexPath].cellHeight
    }
}
