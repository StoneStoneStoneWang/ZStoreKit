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
                                            headerRefresh: vc.collectionView.mj_header!.rx.refreshing.asDriver(),
                                            footerRefresh: vc.collectionView.mj_footer!.rx.refreshing.asDriver(),
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
            .drive(vc.collectionView.mj_header!.rx.endRefreshing)
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
            .drive(vc.collectionView.mj_footer!.rx.endRefreshing)
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
            .bind(to: vc.collectionView.mj_footer!.rx.isHidden)
            .disposed(by: disposed)
    }
}
extension ZCListBridge {
    
    @objc public func addBlack(_ OUsEncoded: String,targetEncoded: String ,content: String ,succ: @escaping () -> () ) {
        
        ZHudUtil.show(withStatus: "添加黑名单中...")
        
        ZCListViewModel
            .addBlack(OUsEncoded, targetEncoded: targetEncoded, content: content)
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
    @objc public func focus(_ uid: String ,encode: String ,isFocus: Bool ,succ: @escaping () -> () ) {
        
        ZHudUtil.show(withStatus: isFocus ? "取消关注中..." : "关注中...")
        
        ZCListViewModel
            .focus(uid, encode: encode)
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
    
    @objc public func operation(_ encoded: String ,isLike: Bool ,status: String ,aMsg: String,succ: @escaping () -> () ) {
        
        ZHudUtil.show(withStatus: status)
        
        ZCListViewModel
            .like(encoded, isLike: isLike)
            .drive(onNext: { (result) in
                
                ZHudUtil.pop()
                
                switch result {
                case .ok(_):
                    
                    succ()
                    
                    ZHudUtil.showInfo(aMsg)
                case .failed(let msg):
                    
                    ZHudUtil.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
    
    @objc public func like(_ encoded: String ,isLike: Bool ,succ: @escaping () -> () ) {
        
        ZHudUtil.show(withStatus: isLike ? "取消点赞中..." : "点赞中...")
        
        ZCListViewModel
            .like(encoded, isLike: isLike)
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
        
        ZCListViewModel
            .removeMyCircle(encoded)
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

