//
//  ZEquipBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2020/3/4.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import ZTable
import ZHud
import ZBean
import RxCocoa
import ZCache
import RxSwift
import RxDataSources
import ZNoti
import ZCocoa

public typealias ZEquipSucc = (_ equips: String) -> ()

@objc (ZEquipBridge)
public final class ZEquipBridge: ZBaseBridge {
    
    typealias Section = ZSectionModel<(), ZEquipBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: ZEquipViewModel!
    
    var vc: ZTableNoLoadingViewConntroller!
}

extension ZEquipBridge {
    
    @objc public func createEquip(_ vc: ZTableNoLoadingViewConntroller ,equips: String ,succ: @escaping ZEquipSucc) {
        
        if let completeItem = vc.navigationItem.rightBarButtonItem?.customView as? UIButton {
            
            self.vc = vc
            
            let input = ZEquipViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(ZEquipBean.self),
                                                itemSelect: vc.tableView.rx.itemSelected)
            
            viewModel = ZEquipViewModel(input, disposed: disposed)
            
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
            
            completeItem
                .rx
                .tap
                .subscribe(onNext: { [unowned self](_) in
                    
                    let values = self.viewModel.output.tableData.value
                    
                    var flag = true
                    
                    var unSelected: ZEquipBean!
                    
                    for item in values {
                        
                        if item.level == .none {
                            
                            flag = false
                            
                            unSelected = item
                            
                            break
                        }
                    }
                    
                    if !flag {
                        
                        ZHudUtil.showInfo(unSelected.type.errorInfo)
                    } else {
                        
                        succ("equip=head:\(values[1].subtitle),shoulder:\(values[2].subtitle),breastplate:\(values[3].subtitle),artifice:\(values[4].subtitle),hand:\(values[5].subtitle),waistband:\(values[6].subtitle),pants:\(values[7].subtitle),foot:\(values[8].subtitle)")
                        
                        vc.navigationController?.popViewController(animated: true)
                    }
                    
                })
                .disposed(by: disposed)
            
            if !equips.isEmpty {
                
                let mutables = equips.components(separatedBy: ",")
                
                var values = viewModel.output.tableData.value
                
                for sub in mutables {
                    
                    let oomp = sub.components(separatedBy: ":")
                    
                    let first = oomp.first!
                    
                    let last = oomp.last!
                    
                    let type = ZEquipType(first)
                    
                    switch type {
                    case .head:
                        
                        let head = values[1]
                        
                        head.level = ZEquipLevel(last)
                        
                    case .shoulder:
                        
                        let shoulder = values[2]
                        
                        shoulder.level = ZEquipLevel(last)
                    case .breastplate:
                        
                        let breastplate = values[3]
                        
                        breastplate.level = ZEquipLevel(last)
                    case .artifice:
                        
                        let artifice = values[4]
                        
                        artifice.level = ZEquipLevel(last)
                        
                    case .hand:
                        
                        let hand = values[5]
                        
                        hand.level = ZEquipLevel(last)
                        
                    case .waistband:
                        
                        let waistband = values[6]
                        
                        waistband.level = ZEquipLevel(last)
                        
                    case .pants:
                        
                        let pants = values[7]
                        
                        pants.level = ZEquipLevel(last)
                        
                    case .foot:
                        let foot = values[8]
                        
                        foot.level = ZEquipLevel(last)
                    default:
                        break
                    }
                    
                }
                
            }
        }
        
    }
    
    @objc public func updateEquip(type: ZEquipType,level: ZEquipLevel) {
        
        let values = viewModel.output.tableData.value
        
        if let idx = values.firstIndex(where: { $0.type == type }) {
            
            let edit = values[idx]
            
            edit.level = level
            
            vc.tableView.reloadData()
        }
        
    }
}
extension ZEquipBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0 }
        
        return datasource[indexPath].type.cellHeight
    }
}
