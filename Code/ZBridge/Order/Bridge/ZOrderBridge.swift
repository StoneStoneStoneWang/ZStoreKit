//
//  ZOrderBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/12/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ZTable
import RxDataSources
import ZCocoa
import ZBean
import ZHud
import ZNoti
import ZCache

@objc (ZOrderBridge)
public final class ZOrderBridge: ZBaseBridge {
    
    typealias Section = ZAnimationSetionModel<ZCircleBean>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: ZOrderViewModel!
    
    weak var vc: ZTableLoadingViewController!
}
extension ZOrderBridge {
    
    @objc public func createTList(_ vc: ZTableLoadingViewController ,tag: String) {
        
        self.vc = vc
        
        let input = ZOrderViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(ZCircleBean.self),
                                            itemSelect: vc.tableView.rx.itemSelected,
                                            headerRefresh: vc.tableView.mj_header!.rx.refreshing.asDriver(),
                                            footerRefresh: vc.tableView.mj_footer!.rx.refreshing.asDriver(),
                                            tag: tag)
        
        viewModel = ZOrderViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .left),
            decideViewTransition: { _,_,_  in return .reload },
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(item, for: ip)})
        
        viewModel
            .output
            .tableData
            .asDriver()
            .map({ $0.map({ Section(header: $0.encoded, items: [$0]) }) })
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
        
        let endFooterRefreshing = viewModel.output.endFooterRefreshing
        
        endFooterRefreshing
            .map({ _ in return true })
            .drive(vc.tableView.mj_footer!.rx.endRefreshing)
            .disposed(by: disposed)
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { (type,ip) in
                
                ZNotiConfigration.postNotification(withName: NSNotification.Name(rawValue: ZNotiMyCircleItemClick), andValue: type, andFrom: vc)
                
            })
            .disposed(by: disposed)
        
        viewModel
            .output
            .footerHidden
            .bind(to: vc.tableView.mj_footer!.rx.isHidden)
            .disposed(by: disposed)
        
        vc
            .tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
    }
}

extension ZOrderBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return vc.caculate(forCell: datasource[indexPath], for: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "删除") { [weak self] (a, ip) in
            
            guard let `self` = self else { return }
            
            let type = self.dataSource[ip]
            
            let alert = UIAlertController(title: "我的圈子", message: "是否删除当前内容？", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "取消", style: .cancel) { (a) in }
            
            let confirm = UIAlertAction(title: "确定", style: .default) { [weak self] (a) in
                
                guard let `self` = self else { return }
                
                ZHudUtil.show(withStatus: "移除当前内容中...")
                
                ZOrderViewModel
                    .removeMyCircle(type.encoded)
                    
                    .drive(onNext: { [weak self] (result) in
                        
                        guard let `self` = self else { return }
                        switch result {
                        case .ok:
                            
                            ZHudUtil.pop()
                            
                            ZHudUtil.showInfo("移除当前内容成功")
                            
                            var value = self.viewModel.output.tableData.value
                            
                            value.remove(at: ip.section)
                            
                            self.viewModel.output.tableData.accept(value)
                            
                            if value.isEmpty {
                                
                                self.vc.tableViewEmptyShow()
                            }
                            
                        case .failed:
                            
                            ZHudUtil.pop()
                            
                            ZHudUtil.showInfo("移除当前内容失败")
                            
                        default: break
                            
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
extension ZOrderBridge {
    
    @objc public func converToJson(_ circle: ZCircleBean) -> [String: Any] {
        
        return circle.toJSON()
    }
    
    @objc public func deleteCircle(_ circle: ZCircleBean) {
        
        var values = self.viewModel.output.tableData.value
        
        if let index = values.firstIndex(where: { $0.encoded == circle.encoded }) {
            
            values.remove(at: index)
        }
        
        self.viewModel.output.tableData.accept(values)
    }
    
    @objc public func addCircle(_ circle: ZCircleBean) {
        
        var values = self.viewModel.output.tableData.value
        
        values.insert(circle, at: 0)
        
        self.viewModel.output.tableData.accept(values)
    }
    
    @objc public func updateCircle(_ tag: String,content: String,encode: String ,opera: String,succ: @escaping () -> () ) {
        
        ZHudUtil.show(withStatus: opera)
        
        ZOrderViewModel
            .updateCircle(tag, content: content, encode: encode)
            .drive(onNext: { (result) in
                
                ZHudUtil.pop()
                
                switch result {
                case .ok(let msg):
                    
                    succ()
                    
                    ZHudUtil.showInfo(msg)
                case .failed(let msg):
                    
                    ZHudUtil.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
    }
    
    @objc public func removeMyCircle(_ encoded: String ,succ: @escaping () -> () )  {
        
        ZHudUtil.show(withStatus: "移除内容中...")
        
        ZOrderViewModel.removeMyCircle(encoded)
            .drive(onNext: { (result) in
                
                ZHudUtil.pop()
                
                switch result {
                case .ok(let msg):
                    
                    succ()
                    
                    ZHudUtil.showInfo(msg)
                case .failed(let msg):
                    
                    ZHudUtil.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
}
