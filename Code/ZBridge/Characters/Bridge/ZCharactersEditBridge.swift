//
//  ZCharactersEditBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2020/3/5.
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
import ZCocoa
import ZRealReq

public typealias ZCharactersEditSucc = (_ character: ZCircleBean?) -> ()

@objc (ZCharactersEditBridge)
public final class ZCharactersEditBridge: ZBaseBridge {
    
    typealias Section = ZSectionModel<(), ZCharactersEditBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: ZCharactersEditViewModel!
    
    var vc: ZTableNoLoadingViewConntroller!
    
    let title: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    let sex: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    let equips: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    let name: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
}

extension ZCharactersEditBridge {
    
    @objc public func createCharactersEdit(_ vc: ZTableNoLoadingViewConntroller,temp: ZCircleBean? ,succ: @escaping ZCharactersEditSucc) {
        
        if let completeItem = vc.navigationItem.rightBarButtonItem?.customView as? UIButton {
            
            self.vc = vc
            
            let input = ZCharactersEditViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(ZCharactersEditBean.self),
                                                         itemSelect: vc.tableView.rx.itemSelected,
                                                         completeTaps: completeItem.rx.tap.asSignal(),
                                                         isEdit: temp != nil,
                                                         title: title.asDriver(),
                                                         sex: sex.asDriver(),
                                                         equips: equips.asDriver(),
                                                         name: name.asDriver(),
                                                         encode: temp == nil ? "" : temp!.encoded)
            
            viewModel = ZCharactersEditViewModel(input, disposed: disposed)
            
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
            
            let values = viewModel.output.tableData.value
            
            if let temp = temp {
                
                for char in temp.contentMap {
                    
                    if char.type == "title" {
                        
                        if let idx = values.firstIndex(where: { $0.type == .character }) {
                            
                            let character = values[idx]
                            
                            character.subtitle = char.value
                            
                            title.accept(char.value)
                        }
                        
                    } else if char.type == "txt" {
                        
                        if char.value.hasPrefix("cName=") {
                            
                            if let idx = values.firstIndex(where: { $0.type == .name }) {
                                
                                let name = values[idx]
                                
                                name.subtitle = char.value.components(separatedBy: "=").last!
                                
                                self.name.accept(name.subtitle)
                            }
                            
                        } else if char.value.hasPrefix("equip=") {
                            
                            if let idx = values.firstIndex(where: { $0.type == .name }) {
                                
                                let equip = values[idx]
                                
                                let equipStr = char.value.components(separatedBy: "=").last!
                                
                                let equips = equipStr.components(separatedBy: ",")
                                
                                var t0: Int = 0
                                
                                var t1: Int = 0
                                
                                var t2: Int = 0
                                
                                for item in equips {
                                    
                                    let last = item.components(separatedBy: ":").last!
                                    
                                    if last == "T0" {
                                        
                                        t0 += 1
                                    } else if last == "T1" {
                                        
                                        t1 += 1
                                    } else if last == "T2" {
                                        
                                        t2 += 1
                                    } else {
                                        
                                        
                                    }
                                }
                                
                                if t0 == 0 {
                                    
                                    if t1 == 0 {
                                        
                                        equip.subtitle = "8T2"
                                    } else {
                                        
                                        equip.subtitle = "\(t1)T1 \(t2)T2"
                                    }
                                } else {
                                    
                                    if t1 == 0 {
                                        
                                        equip.subtitle = "\(t0)T0 \(t2)T2"
                                    } else {
                                        
                                        equip.subtitle = "\(t0)T0 \(t1)T1 \(t2)T2"
                                    }
                                }
                                self.equips.accept(equip.subtitle)
                            }
                            
                        } else if char.value.hasPrefix("sex=") {
                            
                            if let idx = values.firstIndex(where: { $0.type == .name }) {
                                
                                let sex = values[idx]
                                
                                sex.subtitle = char.value.components(separatedBy: "=").last!
                                
                                self.equips.accept(sex.subtitle)
                            }
                            
                        }
                        
                    }
                    
                }
                
                vc.tableView.reloadData()
            }
            
        }
    }
    
    @objc public func updateCharactersEdit(type: ZCharactersEditType,value: String) {
        
        var values = viewModel.output.tableData.value
        
        if let idx = values.firstIndex(where: { $0.type == type }) {
            
            let edit = values[idx]
            
            edit.subtitle = value
            
            vc.tableView.reloadData()
            
            if type == .character {
                
                title.accept(value)
            } else if type == .name {
                
                name.accept(value)
            } else if type == .equip {
                
                equips.accept(value)
            } else if type == .sex {
                
                equips.accept(value)
            }
        }
        
    }
}
extension ZCharactersEditBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0 }
        
        return datasource[indexPath].type.cellHeight
    }
}
