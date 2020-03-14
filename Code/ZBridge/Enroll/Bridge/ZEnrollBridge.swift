//
//  ZEnrollBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2020/3/11.
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
import WLToolsKit
import ZBridge
public typealias ZEnrollssEditSucc = (_ character: ZCircleBean?) -> ()

@objc (ZEnrollBridge)
public final class ZEnrollBridge: ZBaseBridge {
    
    typealias Section = ZSectionModel<(), ZEnrollBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: ZEnrollViewModel!
    
    var vc: ZTableNoLoadingViewConntroller!
    
    let character: BehaviorRelay<ZCircleBean?> = BehaviorRelay<ZCircleBean?>(value: nil)
    
    let time: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    let team: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
}

extension ZEnrollBridge {
    
    @objc public func createEnrollEdit(_ vc: ZTableNoLoadingViewConntroller,tag: String,succ: @escaping ZEnrollssEditSucc) {
        
        if let completeItem = vc.navigationItem.rightBarButtonItem?.customView as? UIButton {
            
            self.vc = vc
            
            let input = ZEnrollViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(ZEnrollBean.self),
                                                         itemSelect: vc.tableView.rx.itemSelected,
                                                         enrollItemTapped: completeItem.rx.tap.asSignal(),
                                                         charater: character.asDriver(),
                                                         time: time.asDriver(),
                                                         team: team.asDriver(),
                                                         tag: tag)
            
            viewModel = ZEnrollViewModel(input, disposed: disposed)
            
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
            
            
            viewModel
                .output
                .enrolling
                .drive(onNext: { _ in
                    
                    vc.view.endEditing(true)
                    
                    ZHudUtil.show(withStatus: "团本信息报名中...")
                    
                })
                .disposed(by: disposed)
            
            // MARK: 登录事件返回序列
            viewModel
                .output
                .enrolled
                .drive(onNext: {
                    
                    ZHudUtil.pop()
                    
                    switch $0 {
                        
                    case let .failed(msg): ZHudUtil.showInfo(msg)
                        
                    case let .operation(obj):
                        
                        ZHudUtil.showInfo("团本信息报名成功")
                        
                        succ(obj as? ZCircleBean)
                        
                        vc.dismiss(animated: true, completion: nil)
                        
                    default: break
                    }
                })
                .disposed(by: disposed)
            
        }
    }
    
    @objc public func updateCharactersEdit(type: ZEnrollType,value: String) {
        
        var values = viewModel.output.tableData.value
        
        if let idx = values.firstIndex(where: { $0.type == type }) {
            
            let edit = values[idx]
            
            edit.subtitle = value
            
            if type == .character {
            
                character.accept(ZCircleBean(JSON: WLJsonCast.cast(argu: value) as! [String : Any]))
                
            } else if type == .time {
                
                time.accept(value)
            } else if type == .team {
                
                team.accept(value)
            }
            
            vc.tableView.reloadRows(at: [IndexPath(item: idx, section: 0)], with: .fade)
        }
    }
}
extension ZEnrollBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0 }
        
        return datasource[indexPath].type.cellHeight
    }
}
