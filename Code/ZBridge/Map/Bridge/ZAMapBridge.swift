//
//  ZAMapBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ZBean
import ZCocoa
import RxDataSources
import ZTable
import ZHud
import RxCocoa
import RxSwift
import CoreLocation
import ZNoti
import ZCache

@objc (ZAMapBridge)
public final class ZAMapBridge: ZBaseBridge {
    
    typealias Section = ZSectionModel<(), ZKeyValueBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: ZAMapViewModel!
    
    var location: BehaviorRelay<CLLocation> = BehaviorRelay<CLLocation>(value: CLLocation(latitude: 39, longitude: 106))
    
    var locAddress: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
}

extension ZAMapBridge {
    
    @objc public func createUserInfo(_ vc: ZTableNoLoadingViewConntroller, forms: [[String: String]] ,tag: String ,succ: @escaping () -> ()) {
        
        if let completeItem = vc.tableView.tableFooterView?.viewWithTag(301) as? UIButton {
            
            let input = ZAMapViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(ZKeyValueBean.self),
                                               itemSelect: vc.tableView.rx.itemSelected,
                                               completeTaps: completeItem.rx.tap.asSignal(),
                                               tag: tag,
                                               forms: forms,
                                               location: location,
                                               locAddress: locAddress)
            
            viewModel = ZAMapViewModel(input)
            
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
                .subscribe(onNext: {(type,ip) in
                    
                    vc.tableView.deselectRow(at: ip, animated: true)
                    
                    vc.tableViewSelectData(type, for: ip)
                    
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .completing
                .drive(onNext: { (result) in
                    
                    ZHudUtil.show(withStatus: "发布订单中.....")
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .completed
                .drive(onNext: { [weak self](result) in
                    
                    guard let `self` = self else { return }
                    ZHudUtil.pop()
                    
                    switch result {
                    case .operation(let circle):
                        
                        ZHudUtil.showInfo("发布成功!")
                        
                        self.viewModel.clearJson()
                        
                        ZNotiConfigration.postNotification(withName: NSNotification.Name(rawValue: ZNotiCirclePublishSucc), andValue: circle.toJSON(), andFrom: vc)
                        
                    case .failed(let msg):
                        
                        ZHudUtil.showInfo(msg)
                        
                    case .empty:
                        
                        ZNotiConfigration.postNotification(withName: NSNotification.Name(rawValue: ZNotiUnLogin), andValue: nil, andFrom: vc)
                    default: break
                        
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
}

extension ZAMapBridge: UITableViewDelegate {
    
    @objc public func updateLocation(_ location: CLLocation) {
        
        self.location.accept(location)
    }
    
    @objc public func updateLocationAddress(_ address: String) {
        
        self.locAddress.accept(address)
    }
    
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let _ = dataSource else { return 0}
        
        return 44
    }
}
