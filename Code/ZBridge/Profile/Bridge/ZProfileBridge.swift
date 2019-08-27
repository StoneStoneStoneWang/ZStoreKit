//
//  ZProfileBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ZTable
import RxDataSources
import WLBaseTableView
import ZNoti
import ZCache
import WLToolsKit
import ZHud


@objc (ZProfileBridge)
public final class ZProfileBridge: ZBaseBridge {
    
    typealias Section = WLSectionModel<(), ZProfileType>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: ZProfileViewModel!
    
    weak var vc: ZTableNoLoadingViewConntroller!
}

extension ZProfileBridge {
    
    @objc public func createProfile(_ vc: ZTableNoLoadingViewConntroller) {
        
        let input = ZProfileViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(ZProfileType.self),
                                              itemSelect: vc.tableView.rx.itemSelected)
        
        viewModel = ZProfileViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(ZProfileBean.createProfile(item, title: item.title), for: ip)  })
        
        viewModel
            .output
            .tableData
            .asDriver()
            .map({ [Section(model: (), items: $0)]  })
            .drive(vc.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        self.dataSource = dataSource
        
        //        viewModel
        //            .output
        //            .userInfo
        //            .bind(to: profileHeader.rx.user)
        //            .disposed(by: disposed)
        
        viewModel
            .output
            .zip
            .subscribe(onNext: {(type,ip) in
                
                vc.tableView.deselectRow(at: ip, animated: true)
                
                switch type {
                case .setting: fallthrough
                case .pravicy: fallthrough
                case .about:
                    
                    ZNotiConfigration.postNotification(withName: type.notificationName, andValue: nil, andFrom: self)
                    
                case .userInfo:fallthrough
                case .address: fallthrough
                case .order: fallthrough
                case .focus: fallthrough
                case .myCircle:
                    
                    if ZAccountCache.default.isLogin() {
                        
                        ZNotiConfigration.postNotification(withName: type.notificationName, andValue: nil, andFrom: self)
                    } else {
                        
                        ZNotiConfigration.postNotification(withName: type.notificationName, andValue: nil, andFrom: self)
                    }
                    
                case .contactUS:
                    
                    if !type.subTitle.isEmpty && WLDeviceInfo.wl_device_hasSIM()  {
                        
                        WLOpenUrl.openUrl(urlString: "telprompt://\(type.subTitle)")
                        
                    } else {
                        
                        ZHudUtil.showInfo("请确认使用的是iPhone，切装有手机卡")
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
extension ZProfileBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return datasource[indexPath].cellHeight
    }
}