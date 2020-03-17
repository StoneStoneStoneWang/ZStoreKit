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
import RxCocoa
import RxSwift
import ZBean
import ZBridge
import ZCache
import ZHud

@objc(ZContentActionType)
public enum ZContentActionType: Int ,Codable {
    
    case content = 1
    
    case comment = 2
    
    case report = 4
    
    case unLogin = 5
    
    case like = 6
    
    case focus = 7
    
    case black = 8
    
    case remove = 9
    
    case share = 10

}

public typealias ZContentAction = (_ type: ZContentActionType,_ from: ZTableNoLoadingViewConntroller,_ keyValue: ZKeyValueBean?,_ circle: ZCircleBean?) -> ()

@objc (ZContentBridge)
public final class ZContentBridge: ZBaseBridge {
    
    typealias Section = ZSectionModel<(), ZKeyValueBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: ZContentViewModel!
    
    weak var vc: ZTableNoLoadingViewConntroller!
    
    var circleBean: ZCircleBean!
}

extension ZContentBridge {
    
    @objc public func createContent(_ vc: ZTableNoLoadingViewConntroller ,circleBean: ZCircleBean ,contentAction: @escaping ZContentAction) {
        
        self.vc = vc
        
        self.circleBean = circleBean;
        
        let input = ZContentViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(ZKeyValueBean.self),
                                              itemSelect: vc.tableView.rx.itemSelected,
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
                
                contentAction(.content,vc,type,circleBean)
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
}
extension ZContentBridge {
    
    @objc public func addBlack(_ OUsEncoded: String,targetEncoded: String ,content: String ,action: @escaping ZContentAction) {
        
        if !ZAccountCache.default.isLogin() {
            
            action(.unLogin,self.vc, nil,nil)
            
            return
        }
        
        ZHudUtil.show(withStatus: "添加黑名单中...")
        
        ZContentViewModel
            .addBlack(OUsEncoded, targetEncoded: targetEncoded, content: content)
            .drive(onNext: { (result) in
                
                ZHudUtil.pop()
                
                switch result {
                case .ok(let msg):

                    ZHudUtil.showInfo(msg)
                    
                    action(.black,self.vc, nil,nil)
                    
                case .failed(let msg):
                    
                    ZHudUtil.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
    @objc public func focus(_ uid: String ,encode: String ,isFocus: Bool,action: @escaping ZContentAction) {
        
        if !ZAccountCache.default.isLogin() {
            
            action(.unLogin,self.vc, nil,nil)
            
            return
        }
        
        ZHudUtil.show(withStatus: isFocus ? "取消关注中..." : "关注中...")
        
        ZContentViewModel
            .focus(uid, encode: encode)
            .drive(onNext: { (result) in
                
                ZHudUtil.pop()
                
                switch result {
                case .ok:
                    
                    self.circleBean.isattention = !self.circleBean.isattention
                    
                    action(.focus,self.vc, nil,self.circleBean)
                    
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
    
    @objc public func like(_ encoded: String,isLike: Bool,action: @escaping ZContentAction) {
        
        if !ZAccountCache.default.isLogin() {
            
            action(.unLogin,self.vc, nil,nil)
            
            return
        }
        
        ZHudUtil.show(withStatus: isLike ? "取消点赞中..." : "点赞中...")
        
        ZContentViewModel
            .like(encoded, isLike: !isLike)
            .drive(onNext: { [unowned self] (result) in
                
                ZHudUtil.pop()
                
                switch result {
                case .ok(let msg):

                    self.circleBean.isLaud = !self.circleBean.isLaud
                    
                    if isLike { self.circleBean.countLaud -= 1 }
                    else { self.circleBean.countLaud += 1}
                    
                    action(.like,self.vc, nil,self.circleBean)
                    
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
