//
//  ZContentBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/9/19.
//  Copyright © 2019 three stone 王. All rights reserved.
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

@objc (ZContentBridge)
public final class ZContentBridge: ZBaseBridge {
    
    typealias Section = ZSectionModel<(), ZKeyValueBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: ZContentViewModel!
    
    weak var vc: ZTableNoLoadingViewConntroller!
}
extension ZContentBridge {
    
    @objc public func createContent(_ vc: ZTableNoLoadingViewConntroller ,circleBean: ZCircleBean ,type: ZContentType) {
        
        self.vc = vc
        
        let input = ZContentViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(ZKeyValueBean.self),
                                              itemSelect: vc.tableView.rx.itemSelected,
                                              type: type,
                                              circle: circleBean)
        
        viewModel = ZContentViewModel(input)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(item, for: ip)  })
        
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
            .zip
            .subscribe(onNext: { (type,ip) in
                
                ZNotiConfigration.postNotification(withName: NSNotification.Name(ZNotiCircleImageClick), andValue: circleBean, andFrom: vc)
            })
            .disposed(by: disposed)
        
        vc
            .tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
        
    }
}
extension ZContentBridge: UITableViewDelegate {
    
    @objc public func converToCircle(_ circleJson: [String : Any]) -> ZCircleBean {
        
        return ZCircleBean(JSON: circleJson)!
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return vc.caculate(forCell: datasource[indexPath], for: indexPath)
    }
    @objc public func addBlack(_ OUsEncoded: String,targetEncoded: String ,content: String ,succ: @escaping () -> () ) {
        
        if !ZAccountCache.default.isLogin() {
            
            ZNotiConfigration.postNotification(withName: NSNotification.Name(rawValue: ZNotiUnLogin), andValue: nil, andFrom: vc)
            
            return
        }
        
        ZHudUtil.show(withStatus: "添加黑名单中...")
        
        ZTListViewModel
            .addBlack(OUsEncoded, targetEncoded: targetEncoded, content: content)
            .drive(onNext: { (result) in
                
                ZHudUtil.pop()
                
                switch result {
                case .ok(let msg):
                    
                    succ()
                    
                    self.vc.tableView.mj_header?.beginRefreshing()
                    
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
        
        if !ZAccountCache.default.isLogin() {
            
            ZNotiConfigration.postNotification(withName: NSNotification.Name(rawValue: ZNotiUnLogin), andValue: nil, andFrom: vc)
            
            return
        }
        
        ZHudUtil.show(withStatus: isFocus ? "取消关注中..." : "关注中...")
        
        ZTListViewModel
            .focus(uid, encode: encode)
            .drive(onNext: { (result) in
                
                ZHudUtil.pop()
                
                switch result {
                case .ok:
                    
                    succ()
                    
                    ZHudUtil.showInfo(isFocus ? "取消关注成功" : "关注成功")
                    
                case .failed(let msg):
                    
                    ZHudUtil.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
    }
    
    @objc public func converToJson(_ circle: ZCircleBean) -> [String: Any] {
        
        return circle.toJSON()
    }
    
    @objc public func like(_ encoded: String,isLike: Bool ,succ: @escaping () -> () ) {
        
        if !ZAccountCache.default.isLogin() {
            
            ZNotiConfigration.postNotification(withName: NSNotification.Name(rawValue: ZNotiUnLogin), andValue: nil, andFrom: vc)
            
            return
        }
        
        ZHudUtil.show(withStatus: isLike ? "取消点赞中..." : "点赞中...")
        
        ZTListViewModel
            .like(encoded, isLike: !isLike)
            .drive(onNext: { [unowned self] (result) in
                
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
