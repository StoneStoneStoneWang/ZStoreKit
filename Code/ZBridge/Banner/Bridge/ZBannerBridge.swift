//
//  ZBannerBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/9/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ZCollection
import RxCocoa
import RxSwift
import RxDataSources
import ZCocoa
import WLToolsKit
import ZCocoa
import ZNoti
import ZBean
import ZHud

@objc (ZBannerBridge)
public final class ZBannerBridge: ZBaseBridge {
    
    var viewModel: ZBannerViewModel!
    
    typealias Section = ZSectionModel<(), ZCircleBean>
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<Section>!
    
    var vc: ZCollectionLoadingViewController!
    
    var style: ZBannerStyle = .one
}
// MARK: skip item 101 pagecontrol 102
extension ZBannerBridge {
    
    @objc public func createBanner(_ vc: ZCollectionLoadingViewController ,canPageHidden: Bool ,style: ZBannerStyle) {
        
        if let pageControl = vc.view.viewWithTag(102) as? UIPageControl {
            
            self.vc = vc
            
            self.style = style
            
            let input = ZBannerViewModel.WLInput(contentoffSetX: vc.collectionView.rx.contentOffset.map({ $0.x }),
                                                 modelSelect: vc.collectionView.rx.modelSelected(ZCircleBean.self),
                                                 itemSelect: vc.collectionView.rx.itemSelected,
                                                 currentPage: BehaviorRelay<Int>(value: 0),
                                                 style: style)
            
            viewModel = ZBannerViewModel(input, disposed: disposed)
            
            ZBannerViewModel
                .fetchBanners()
                .drive(onNext: { [unowned self] (result) in
                    
                    switch result {
                    case .fetchList(let list):
                        
                        var mutable: [ZCircleBean] = []
                        
                        if list.count > 7 {
                            
                            let temp = list as! [ZCircleBean]
                            
                            for _ in 0..<999 {
                                
                                mutable += [temp[4]]
                                
                                mutable += [temp[5]]
                                
                                mutable += [temp[6]]
                                
                                mutable += [temp[7]]
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                                
                                vc.collectionView.selectItem(at: IndexPath(item: mutable.count / 5, section:0), animated: false, scrollPosition: .centeredHorizontally)
                            }
                        }
                        
                        vc.loadingStatus = .succ
                        
                        self.viewModel.output.tableData.accept(mutable)
                    case .failed(let msg):
                        
                         vc.loadingStatus = .fail
                        
                        ZHudUtil.showInfo(msg)
                    default: break
                        
                    }
                })
                .disposed(by: disposed)
            
            let dataSource = RxCollectionViewSectionedReloadDataSource<Section>(
                configureCell: { ds, cv, ip, item in return vc.configCollectionViewCell(item, for: ip)})
            
            self.dataSource = dataSource
            
            viewModel
                .output
                .tableData
                .asObservable()
                .map({ [Section(model: (), items: $0)] })
                .bind(to: vc.collectionView.rx.items(dataSource: dataSource))
                .disposed(by: disposed)
            
            viewModel
                .output
                .zip
                .subscribe(onNext: { (banner,ip) in
                    
                    ZNotiConfigration.postNotification(withName: NSNotification.Name(ZNotiBannerClick), andValue: banner, andFrom: vc)
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .timered
                .subscribe(onNext: { [unowned self] (index) in
                    
                    if !self.viewModel.output.tableData.value.isEmpty {
                        
                        vc.collectionView.selectItem(at: IndexPath(item: index, section:0), animated: true, scrollPosition: .centeredHorizontally)
                    }
                    
                })
                .disposed(by: disposed)
            
            viewModel.output.currentPage.bind(to: pageControl.rx.currentPage).disposed(by: disposed)
            
            vc.collectionView.rx.setDelegate(self).disposed(by: disposed)
        }
    }
}
extension ZBannerBridge: UICollectionViewDelegate {
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        DispatchQueue.main.async {
            
            let width = self.style == .one ? WL_SCREEN_WIDTH : (WL_SCREEN_WIDTH - 60 )
            
            let floatx = scrollView.contentOffset.x / width
            
            let intx = floor(floatx)
            
            if floatx + 0.5 >= intx {
                
                self.vc.collectionView.selectItem(at: IndexPath(item: Int(scrollView.contentOffset.x / width) + 1, section:0), animated: true, scrollPosition: .centeredHorizontally)
            } else {
                
                self.vc.collectionView.selectItem(at: IndexPath(item: Int(scrollView.contentOffset.x / width), section:0), animated: true, scrollPosition: .centeredHorizontally)
            }
        }
    }
}
