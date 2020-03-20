//
//  ZAreaBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2020/3/13.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import ZBridge
import ZCocoa
import RxDataSources
import ZTable
import ZBean

@objc (ZAreaType)
public enum ZAreaType: Int {
    
    case province
    
    case city
    
    case region
}

public typealias ZAreaAction = (_ from: ZBaseViewController ,_ selectedArea: ZAreaBean ,_ type: ZAreaType ,_ hasNext: Bool) -> ()

@objc (ZAreaBridge)
public final class ZAreaBridge: ZBaseBridge {
    
    var viewModel: ZAreaViewModel!
    
    typealias Section = ZSectionModel<(), ZAreaBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var type: ZAreaType = .province
    
    var areas: [ZAreaBean] = []
    
    var selectedArea: ZAreaBean!
}

extension ZAreaBridge {
    
    @objc public func createArea(_ vc: ZTableNoLoadingViewConntroller ,type: ZAreaType,areaAction: @escaping ZAreaAction) {
        
        self.type = type
        
        let input = ZAreaViewModel.WLInput(areas: areas,
                                           modelSelect: vc.tableView.rx.modelSelected(ZAreaBean.self),
                                           itemSelect: vc.tableView.rx.itemSelected)
        
        viewModel = ZAreaViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(item, for: ip)})
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .tableData
            .asDriver()
            .map({ [Section(model: (), items: $0)]  })
            .drive(vc.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { [unowned self](area,ip) in
                
                vc.tableView.deselectRow(at: ip, animated: true)
                
                let values = self.viewModel.output.tableData.value
                
                _ = values.map({ $0.isSelected = false })
                
                area.isSelected = true
                
                self.viewModel.output.tableData.accept(values)
                
                switch type {
                case .province: fallthrough
                case .region:
                    areaAction(vc,area,type, true)
                case .city:
                    
                    areaAction(vc,area,type, self.fetchRegions(area.id).count > 0)
                default:
                    break;
                }
            })
            .disposed(by: disposed)
        vc
            .tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
        
        ZAreaManager
            .default
            .fetchAreas()
            .drive(onNext: { [unowned self ](result) in
                
                switch result {
                case .fetchList(let list):
                    
                    var mutable: [ZAreaBean] = []
                    
                    switch type {
                    case .province:
                        
                        mutable += self.fetchProvices(list as! [ZAreaBean])
                    case .city:
                        
                        //                        mutable += self.fetchCitys(<#T##id: Int##Int#>)
                        break
                    case .region:
                        break
                        
                    }
                    
                    self.viewModel.output.tableData.accept(mutable)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
    
    @objc public func updateDatas(_ id: Int ,areas: [ZAreaBean]) {
        
        switch type {
        case .city:
            
            self.viewModel.output.tableData.accept(self.fetchCitys(id))
            
        case .region:
            
            self.viewModel.output.tableData.accept(self.fetchRegions(id))
        case .province:
            
            self.viewModel.output.tableData.accept(self.fetchProvices(areas))
        }
    }
    @objc public func fetchProvice(pName: String) -> ZAreaBean {
        
        let values = self.viewModel.output.tableData.value
        
        let idx = values.firstIndex(where: {  $0.name == pName })!
        
        return values[idx]
        
    }
    
    @objc public func fetchArea(id: Int) -> ZAreaBean {
        
        return ZAreaManager.default.fetchSomeArea(id)
        
    }
    @objc public func fetchIp(id: Int) -> IndexPath {
        
        let values = self.viewModel.output.tableData.value
        
        let idx = values.firstIndex(where: {  $0.id == id })!
        
        return IndexPath(row: idx, section: 0)
    }
    @objc public func fetchProvices(_ areas: [ZAreaBean]) -> [ZAreaBean] {
        
        var result: [ZAreaBean] = []
        
        for item in areas {
            
            if item.arealevel == 1 {
                
                result += [item]
            }
        }
        return result
    }
    
    @objc public func fetchCitys(_ id: Int) -> [ZAreaBean] {
        
        var result: [ZAreaBean] = []
        
        for item in ZAreaManager.default.allAreas {
            
            if item.arealevel == 2 {
                
                if item.pid == id {
                    
                    result += [item]
                }
            }
        }
        return result
    }
    
    @objc public func fetchRegions(_ id: Int) -> [ZAreaBean] {
        
        var result: [ZAreaBean] = []
        
        for item in ZAreaManager.default.allAreas {
            
            if item.arealevel == 3 {
                
                if item.pid == id {
                    
                    result += [item]
                }
            }
        }
        return result
    }
}

extension ZAreaBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
    }
}
