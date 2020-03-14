//
//  ZCarouselBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2020/3/12.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import ZCollection
import RxCocoa
import RxSwift
import RxDataSources
import ZCocoa
import WLToolsKit
import ZCocoa
import ZBridge
public typealias ZCarouselAction = (_ banner: String ,_ vc: ZBaseViewController) -> ()

@objc (ZCarouselBridge)
public final class ZCarouselBridge: ZBaseBridge {
    
    var viewModel: ZCarouselViewModel!
    
    typealias Section = ZSectionModel<(), String>
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<Section>!
    
    var vc: ZCollectionLoadingViewController!
    
    var style: ZCarouselStyle = .one
}

// MARK: skip item 101 pagecontrol 102
extension ZCarouselBridge {
    
    @objc public func createCarousel(_ vc: ZCollectionLoadingViewController ,canPageHidden: Bool ,images: [String],style: ZCarouselStyle ,bannerAction: @escaping ZCarouselAction) {
        
        if let pageControl = vc.view.viewWithTag(102) as? UIPageControl {
            
            self.vc = vc
            
            self.style = style
            
            let input = ZCarouselViewModel.WLInput(contentoffSetX: vc.collectionView.rx.contentOffset.map({ $0.x }),
                                                 modelSelect: vc.collectionView.rx.modelSelected(String.self),
                                                 itemSelect: vc.collectionView.rx.itemSelected,
                                                 currentPage: BehaviorRelay<Int>(value: 0),
                                                 style: style)
            
            viewModel = ZCarouselViewModel(input, disposed: disposed)
            
            viewModel.output.tableData.accept(images)
            
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
                    
                    bannerAction(banner,vc)

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
            
            var mutable: [String] = []
            
            for _ in 0..<999 {
                
                mutable += images
            }
            
            viewModel.output.tableData.accept(mutable)
            
            vc.collectionView.rx.setDelegate(self).disposed(by: disposed)
        }
        
        
    }
}
extension ZCarouselBridge: UICollectionViewDelegate {
    
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
