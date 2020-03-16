//
//  ZTListBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ZTable
import RxDataSources
import ZCocoa
import ZBean
import ZHud
import ZCache
import ZBridge
@objc(ZTListActionType)
public enum ZTListActionType: Int ,Codable {
    
    case myCircle = 0
    
    case circle = 1
    
    case comment = 2
    
    case watch = 3
    
    case report = 4
}

public typealias ZTListAction = (_ action: ZTListActionType ,_ vc: ZTableLoadingViewController ,_ circle: ZCircleBean ,_ ip: IndexPath) -> ()

@objc (ZTListBridge)
public final class ZTListBridge: ZBaseBridge {
    
    typealias Section = ZAnimationSetionModel<ZCircleBean>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: ZTListViewModel!
    
    weak var vc: ZTableLoadingViewController!
}
extension ZTListBridge {
    
    @objc public func createTList(_ vc: ZTableLoadingViewController ,isMy: Bool ,tag: String ,tAction: @escaping ZTListAction) {
        
        self.vc = vc
        
        let input = ZTListViewModel.WLInput(isMy: isMy,
                                            modelSelect: vc.tableView.rx.modelSelected(ZCircleBean.self),
                                            itemSelect: vc.tableView.rx.itemSelected,
                                            headerRefresh: vc.tableView.mj_header!.rx.refreshing.asDriver(),
                                            footerRefresh: vc.tableView.mj_footer!.rx.refreshing.asDriver(),
                                            tag: tag)
        
        viewModel = ZTListViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .left),
            decideViewTransition: { _,_,_  in return .reload },
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(item, for: ip)},
            canEditRowAtIndexPath: { _,_ in return isMy })
        
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
                
                tAction(isMy ? .myCircle : .circle,vc,type,ip)
                
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
    
    @objc func updateCircle(_ circle: ZCircleBean ,ip: IndexPath) {
        
        var values = viewModel.output.tableData.value
        
        values.replaceSubrange(ip.row..<ip.row+1, with: [circle])
        
        viewModel.output.tableData.accept(values)
    }
    
    @objc func insertCircle(_ circle: ZCircleBean) {
        
        var values = viewModel.output.tableData.value
        
        values.insert(circle, at: 0)
        
        if values.count == 1 {
            
            vc.tableViewEmptyHidden()
        }
        
        viewModel.output.tableData.accept(values)
    }
}

extension ZTListBridge: UITableViewDelegate {
    
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
                
                ZTListViewModel
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
extension ZTListBridge {
    
    @objc public func addBlack(_ OUsEncoded: String,targetEncoded: String ,content: String ,unLogin: @escaping (_ vc: ZBaseViewController) -> (),succ: @escaping () -> () ) {
        
        if !ZAccountCache.default.isLogin() {
            
            unLogin(vc)
            
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
                    
                    self.vc.tableView.mj_header!.beginRefreshing()
                    
                    ZHudUtil.showInfo(msg)
                case .failed(let msg):
                    
                    ZHudUtil.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
    @objc public func focus(_ uid: String ,encode: String ,isFocus: Bool ,unLogin: @escaping (_ vc: ZBaseViewController) -> (),succ: @escaping () -> () ) {
        
        if !ZAccountCache.default.isLogin() {
            
            unLogin(vc)
            
            return
        }
        
        ZHudUtil.show(withStatus: isFocus ? "取消关注中..." : "关注中...")
        
        ZTListViewModel
            .focus(uid, encode: encode)
            .drive(onNext: { (result) in
                
                ZHudUtil.pop()
                
                switch result {
                case .ok:
                    
                    var values = self.viewModel.output.tableData.value
                    
                    if let index = values.firstIndex(where: { $0.encoded == encode }) {
                        
                        let circle = values[index]
                        
                        circle.isattention = !circle.isattention
                        
                        self.viewModel.output.tableData.accept(values)
                    }
                    
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
    
    @objc public func like(_ encoded: String,isLike: Bool ,unLogin: @escaping (_ vc: ZBaseViewController) -> (),succ: @escaping () -> () ) {
        
        if !ZAccountCache.default.isLogin() {
            
            unLogin(vc)
            
            return
        }
        
        ZHudUtil.show(withStatus: isLike ? "取消点赞中..." : "点赞中...")
        
        ZTListViewModel
            .like(encoded, isLike: !isLike)
            .drive(onNext: { [unowned self] (result) in
                
                ZHudUtil.pop()
                
                switch result {
                case .ok(let msg):
                    
                    var values = self.viewModel.output.tableData.value
                    
                    if let index = values.firstIndex(where: { $0.encoded == encoded }) {
                        
                        let circle = values[index]
                        
                        circle.isLaud = !circle.isLaud
                        
                        if isLike { circle.countLaud -= 1 }
                        else { circle.countLaud += 1}
                        
                        self.viewModel.output.tableData.accept(values)
                    }
                    
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
        
        ZTListViewModel.removeMyCircle(encoded)
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
