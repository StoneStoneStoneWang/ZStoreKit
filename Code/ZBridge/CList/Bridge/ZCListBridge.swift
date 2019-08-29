//
//  ZCListBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ZCollection
import RxDataSources
import ZCocoa
import ZBean
import ZHud
import ZNoti

@objc (ZCListBridge)
public final class ZCListBridge: ZBaseBridge {
    
    typealias Section = ZAnimationSetionModel<ZCommodityBean>
    
    var dataSource: RxCollectionViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: ZCListViewModel!
    
    weak var vc: ZCollectionLoadingViewController!
}
extension ZCListBridge {
    
    @objc public func createFocus(_ vc: ZCollectionLoadingViewController ,isMy: Bool ,tag: String) {
        
        self.vc = vc
        
        let input = ZCListViewModel.WLInput(isMy: isMy,
                                            modelSelect: vc.collectionView.rx.modelSelected(ZCommodityBean.self),
                                            itemSelect: vc.collectionView.rx.itemSelected,
                                            headerRefresh: vc.collectionView.mj_header.rx.refreshing.asDriver(),
                                            footerRefresh: vc.collectionView.mj_footer.rx.refreshing.asDriver(),
                                            tag: tag)
        
        viewModel = ZCListViewModel(input, disposed: disposed)
        
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .left),
            decideViewTransition: { _,_,_  in return .reload },
            configureCell: { ds, tv, ip, item in return vc.configCollectionViewCell(item, for: ip) })
        
        viewModel
            .output
            .tableData
            .asDriver()
            .map({ $0.map({ Section(header: $0.encoded, items: [$0]) }) })
            .drive(vc.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        let endHeaderRefreshing = viewModel.output.endHeaderRefreshing
        
        endHeaderRefreshing
            .map({ _ in return true })
            .drive(vc.collectionView.mj_header.rx.endRefreshing)
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
                    
                    vc.collectionEmptyShow()
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
        let endFooterRefreshing = viewModel.output.endFooterRefreshing
        
        endFooterRefreshing
            .map({ _ in return true })
            .drive(vc.collectionView.mj_footer.rx.endRefreshing)
            .disposed(by: disposed)
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { (type,ip) in
                
                ZNotiConfigration.postNotification(withName: NSNotification.Name(rawValue: isMy ? ZNotiCircleItemClick : ZNotiMyCircleItemClick), andValue: type.toJSON(), andFrom: vc)
                
            })
            .disposed(by: disposed)
        
        viewModel
            .output
            .footerHidden
            .bind(to: vc.collectionView.mj_footer.rx.isHidden)
            .disposed(by: disposed)
    }
}
