//
//  ZEnrollsBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2020/3/11.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import ZTable
import RxDataSources
import ZCocoa
import ZHud
import RxCocoa
import RxSwift
import ZBean
import ZNoti
import ZCache

public typealias ZEnrollsLoadingStatus = (_ status: Int) -> ()

public typealias ZEnrollsInsertStatus = (_ status: Int) -> ()

@objc (ZEnrollsBridge)
public final class ZEnrollsBridge: ZBaseBridge {
    
    typealias Section = ZAnimationSetionModel<ZCircleBean>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: ZEnrollsViewModel!
    
    weak var vc: ZTableLoadingViewController!
}

extension ZEnrollsBridge {
    
    @objc public func createEnrolls(_ vc: ZTableLoadingViewController ,status: @escaping ZEnrollsLoadingStatus) {
        
        if let addItem = vc.view.viewWithTag(301) as? UIButton {
            
            self.vc = vc
            
            let input = ZEnrollsViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(ZCircleBean.self),
                                                     itemSelect: vc.tableView.rx.itemSelected,
                                                     headerRefresh: vc.tableView.mj_header!.rx.refreshing.asDriver(),
                                                     footerRefresh: vc.tableView.mj_footer!.rx.refreshing.asDriver(),
                                                     addItemTapped: addItem.rx.tap.asSignal())
            
            viewModel = ZEnrollsViewModel(input, disposed: disposed)
            
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
            
            self.dataSource = dataSource
            
            viewModel
                .output
                .zip
                .subscribe(onNext: { (type,ip) in
                    
                    vc.tableViewSelectData(type, for: ip)
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .added
                .drive(onNext: { (_) in
                    
                    ZNotiConfigration.postNotification(withName: NSNotification.Name(ZNotiCharacterAddClick), andValue: nil, andFrom: vc)
                })
                .disposed(by: disposed)
            
            vc
                .tableView
                .rx
                .setDelegate(self)
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
                        
                        status(0)
                    case let .failed(msg):
                        ZHudUtil.showInfo(msg)
                        vc.loadingStatus = .fail
                        status(-1)
                    case .empty:
                        vc.loadingStatus = .succ
                        
                        vc.tableViewEmptyShow()
                        status(1);
                        
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
            
            viewModel
                .output
                .footerHidden
                .bind(to: vc.tableView.mj_footer!.rx.isHidden)
                .disposed(by: disposed)
            
        }
    }
    
    @objc public func insertEnrolls(_ enrolls: ZCircleBean ,status: @escaping ZEnrollsInsertStatus ) {
        
        var values = viewModel.output.tableData.value
        
        values.insert(enrolls, at: 0)
        
        viewModel.output.tableData.accept(values)
        
        if values.isEmpty {
            
            status(0)
            
            self.vc.tableViewEmptyHidden()
        } else {
            
            status(1)
        }
    }
    @objc public func updateEnrolls(_ characters: ZCircleBean ,ip: IndexPath) {
        
        var values = viewModel.output.tableData.value
        
        values.replaceSubrange(ip.row..<ip.row+1, with: [characters])
        
        viewModel.output.tableData.accept(values)
        
    }
    
}
extension ZEnrollsBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return vc.caculate(forCell: datasource[indexPath], for: indexPath)
    }
}
