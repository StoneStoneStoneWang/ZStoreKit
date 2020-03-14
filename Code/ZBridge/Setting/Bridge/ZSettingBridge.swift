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
import ZCocoa
import ZCache

@objc(ZSettingActionType)
public enum ZSettingActionType: Int ,Codable {
    
    case gotoFindPwd = 0
    
    case gotoModifyPwd = 1
    
    case logout = 2
    
    case unlogin = 3
    
    case black = 4
}

public typealias ZSettingAction = (_ action: ZSettingActionType ,_ vc: ZBaseViewController) -> ()


@objc (ZSettingBridge)
public final class ZSettingBridge: ZBaseBridge {
    
    typealias Section = ZSectionModel<(), ZSettingType>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: ZSettingViewModel!
    
    weak var vc: ZTableNoLoadingViewConntroller!
}
extension ZSettingBridge {
    
    @objc public func createSetting(_ vc: ZTableNoLoadingViewConntroller ,settingAction: @escaping ZSettingAction) {
        
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
                    
                    settingAction(.gotoFindPwd,vc)
                case .password:
                    
                    settingAction(.gotoModifyPwd,vc)
                    
                case .logout:
                    settingAction(.logout,vc)
                    
                case .black:
                    
                    if ZAccountCache.default.isLogin() {
                        
                        settingAction(.black,vc)
                        
                    } else {
                        
                        settingAction(.unlogin,vc)

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
