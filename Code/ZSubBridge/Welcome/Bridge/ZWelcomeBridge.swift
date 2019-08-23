//
//  ZWelcomeBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/8/23.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ZContainer
import RxCocoa
import RxSwift
import RxDataSources
import WLBaseTableView
import ZBridge
import WLToolsKit
import ZCocoa
import ZNoti
import SnapKit

@objc (WLWelComeConfig)
public protocol WLWelComeConfig {
    
    var welcomeImgs: [String] { get }
    
    var itemColor: String { get }
}

@objc (ZWelcomeBridge)
public final class ZWelcomeBridge: ZBaseBridge {
    
    public var viewModel: ZWelcomViewModel!
    
    typealias Section = WLSectionModel<(), String>
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<Section>!
    
    public final let skipItem: UIButton = UIButton(type: .custom)
    
    public final let pageControl: UIPageControl = UIPageControl(frame: .zero).then {
        
        $0.currentPage = 0
    }
}

extension ZWelcomeBridge {
    
    @objc public func configViewModel(_ vc: ZCollectNoLoadingViewController ,config: WLWelComeConfig ,isPageHidden: Bool) {
        
        vc.view.addSubview(skipItem)
        
        vc.view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { (make) in
            
            make.left.right.equalToSuperview()
            
            make.height.equalTo(20)
            
            make.bottom.equalTo(-60)
        }
        
        pageControl.pageIndicatorTintColor = WLHEXCOLOR_ALPHA(hexColor: "\(config.itemColor)50")
        
        pageControl.currentPageIndicatorTintColor = WLHEXCOLOR(hexColor: config.itemColor)
        
        let input = ZWelcomViewModel.WLInput(contentoffSetX: vc.collectionView.rx.contentOffset.map({ $0.x }),
                                             skipTap: skipItem.rx.tap.asSignal(),
                                             welcomeImgs:config.welcomeImgs )
        
        viewModel = ZWelcomViewModel(input, disposed: disposed)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<Section>(
            configureCell: { ds, cv, ip, item in return vc.configCollectionViewCell(item, for: ip) })
        
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
            .currentpage
            .bind(to: pageControl.rx.currentPage)
            .disposed(by: disposed)
        
        viewModel
            .output
            .numofpage
            .bind(to: pageControl.rx.numberOfPages)
            .disposed(by: disposed)
        
        viewModel
            .output
            .skipHidden
            .asObservable()
            .bind(to: skipItem.rx.isHidden)
            .disposed(by: disposed)
        
        if isPageHidden {
            
            viewModel
                .output
                .pageHidden
                .bind(to: pageControl.rx.isHidden)
                .disposed(by: disposed)
        } else {
            
            viewModel
                .output
                .timered
                .bind(to: skipItem.rx.skipTitle)
                .disposed(by: disposed)
        }
        
        viewModel
            .output
            .skiped
            .drive(onNext: { (_) in
                
                ZNotiConfigration.postNotification(withName: NSNotification.Name(rawValue: ZNotiWelcomeSkip), andValue: nil, andFrom: vc)
            })
            .disposed(by: disposed)
    }
}
