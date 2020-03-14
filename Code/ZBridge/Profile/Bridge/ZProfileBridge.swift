//
//  ZProfileBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//  

import Foundation
import ZTable
import RxDataSources
import ZCocoa
import ZCache
import ZHud
import RxCocoa
import RxSwift
import ZBean
import RxGesture

@objc(ZProfileActionType)
public enum ZProfileActionType: Int ,Codable {
    
    case about
    
    case userInfo
    
    case setting
    
    case contactUS
    
    case privacy
    
    case focus
    
    case space
    
    case myCircle
    
    case order
    
    case address
    
    case characters
    
    case unLogin
}

public typealias ZProfileAction = (_ action: ZProfileActionType ,_ vc: ZBaseViewController) -> ()

private var key: Void?

extension ZTableHeaderView {
    
    @objc public var user: ZUserBean? {
        get {
            return objc_getAssociatedObject(self, &key) as? ZUserBean
        }
        set{
            objc_setAssociatedObject(self, &key,newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension Reactive where Base: ZTableHeaderView {
    
    var user: Binder<ZUserBean?> {
        
        return Binder(base) { view, user in
            
            view.user = user
        }
    }
}

@objc (ZProfileBridge)
public final class ZProfileBridge: ZBaseBridge {
    
    typealias Section = ZSectionModel<(), ZProfileType>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: ZProfileViewModel!
    
    weak var vc: ZTableNoLoadingViewConntroller!
}

extension ZProfileBridge {
    
    @objc public func createProfile(_ vc: ZTableNoLoadingViewConntroller,profileAction:@escaping ZProfileAction) {
        
        let input = ZProfileViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(ZProfileType.self),
                                              itemSelect: vc.tableView.rx.itemSelected)
        
        viewModel = ZProfileViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(ZProfileBean.createProfile(item, title: item.title), for: ip)  })
        
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
            .userInfo
            .bind(to: vc.headerView.rx.user)
            .disposed(by: disposed)
        
        viewModel
            .output
            .zip
            .subscribe(onNext: {(type,ip) in
                
                vc.tableView.deselectRow(at: ip, animated: true)
                
                let isLogin = ZAccountCache.default.isLogin()
                
                switch type {
                case .setting: profileAction(.setting,vc)
                    
                case .privacy: profileAction(.privacy,vc)
                case .about: profileAction(.about,vc)
                    
                case .userInfo: profileAction(isLogin ? .userInfo : .unLogin,vc)
                case .address: profileAction(isLogin ? .address : .unLogin,vc)
                case .order: profileAction(isLogin ? .order : .unLogin,vc)
                case .focus: profileAction(isLogin ? .focus : .unLogin,vc)
                case .characters: profileAction(isLogin ? .characters : .unLogin,vc)
                case .myCircle: profileAction(isLogin ? .myCircle : .unLogin,vc)
                    
                case .contactUS:
                    
                    vc.tableViewSelectData(type, for: ip)
                    
                default:
                    break
                }
            })
            .disposed(by: disposed)
        vc
            .tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
        
        vc
            .headerView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { (_) in
                
                let isLogin = ZAccountCache.default.isLogin()
                
                profileAction(isLogin ? .userInfo : .unLogin,vc)
            
            })
            .disposed(by: disposed)
    }
}
extension ZProfileBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return datasource[indexPath].cellHeight
    }
}
