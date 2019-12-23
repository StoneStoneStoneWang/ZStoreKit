//
//  ZFocusBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/8/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ZTable
import RxDataSources
import ZCocoa
import ZBean
import ZHud
import ZNoti

@objc (ZFocusBridge)
public final class ZFocusBridge: ZBaseBridge {
    
    typealias Section = ZAnimationSetionModel<ZFocusBean>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    
    public var viewModel: ZFocusViewModel!
    
    weak var vc: ZTableLoadingViewController!
}
extension ZFocusBridge {
    
    @objc public func createFocus(_ vc: ZTableLoadingViewController) {
        
        self.vc = vc
        
        vc.tableView.mj_footer!.isHidden = true
        
        let input = ZFocusViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(ZFocusBean.self),
                                            itemSelect: vc.tableView.rx.itemSelected,
                                            headerRefresh: vc.tableView.mj_header!.rx.refreshing.asDriver())
        
        viewModel = ZFocusViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .top, reloadAnimation: .fade, deleteAnimation: .left),
            decideViewTransition: { _,_,_  in return .reload },
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(item, for: ip) }
            ,canEditRowAtIndexPath: { _,_ in return true })
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .tableData
            .asDriver()
            .map({ $0.map({ Section(header: $0.identity, items: [$0]) }) })
            .drive(vc.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        let endHeaderRefreshing = viewModel.output.endHeaderRefreshing
        
        endHeaderRefreshing
            .map({ _ in return true })
            .drive(vc.tableView.mj_header!.rx.endRefreshing)
            .disposed(by: disposed)
        
        endHeaderRefreshing
            .drive(onNext: { (res) in
                switch res {
                case .fetchList:
                    vc.loadingStatus = .succ
                case let .failed(msg):
                    ZHudUtil.showInfo(msg)
                    vc.loadingStatus = .fail
                    
                case .empty:
                    vc.loadingStatus = .succ
                    
                    vc.tableViewEmptyShow()
                    
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { (type,ip) in })
            .disposed(by: disposed)
        
        vc.tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
    }
}
extension ZFocusBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return vc.caculate(forCell: datasource[indexPath], for: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "删除") { [weak self] (a, ip) in
            
            guard let `self` = self else { return }
            
            let type = self.dataSource[ip]
            
            let alert = UIAlertController(title: "关注信息", message: "是否取消\(type.users.nickname)关注？", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "取消", style: .cancel) { (a) in }
            
            let confirm = UIAlertAction(title: "确定", style: .default) { [weak self] (a) in
                
                guard let `self` = self else { return }
                
                ZHudUtil.show(withStatus: "移除\(type.users.nickname)中...")
                
                ZFocusViewModel
                    .removeFocus(type.users.encoded, encode: type.encoded)
                    .drive(onNext: { [weak self] (result) in
                        
                        guard let `self` = self else { return }
                        switch result {
                        case .ok:
                            
                            ZHudUtil.pop()
                            
                            ZHudUtil.showInfo("移除\(type.users.nickname)成功")
                            
                            var value = self.viewModel.output.tableData.value
                            
                            value.remove(at: ip.section)
                            
                            self.viewModel.output.tableData.accept(value)
                            
                            if value.isEmpty {
                                
                                self.vc.tableViewEmptyShow()
                            }
                            
                            ZNotiConfigration.postNotification(withName: NSNotification.Name(rawValue: ZNotiRemoveFocus), andValue: nil, andFrom: self.vc)
                            
                        case .failed:
                            
                            ZHudUtil.pop()
                            
                            ZHudUtil.showInfo("移除\(type.users.nickname)失败")
                        default: break;
                            
                        }
                    })
                    .disposed(by: self.disposed)
            }
            
            alert.addAction(cancel)
            
            alert.addAction(confirm)
            
            self.vc.present(alert, animated: true, completion: nil)
            
        }
        
        return [delete]
    }
}
