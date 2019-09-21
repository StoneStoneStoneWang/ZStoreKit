//
//  ZPublishBridge.swift
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

@objc (ZPublishBridge)
public final class ZPublishBridge: ZBaseBridge {
    
    typealias Section = ZSectionModel<(), ZKeyValueBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: ZPublishViewModel!
    
    weak var vc: ZTableNoLoadingViewConntroller!
}

extension ZPublishBridge {
    
    @objc public func createPublish(_ vc: ZTableNoLoadingViewConntroller ,type: ZPublishType,pTag: String,tf: UITextField ,textItem: UIButton ,imageItem: UIButton ,videoItem: UIButton) {
        
        if let completeItem = vc.navigationItem.rightBarButtonItem?.customView as? UIButton {
            
            self.vc = vc
            
            let input = ZPublishViewModel.WLInput(tag: pTag,
                                                  title: tf.rx.text.orEmpty.asDriver(),
                                                  modelSelect: vc.tableView.rx.modelSelected(ZKeyValueBean.self),
                                                  itemSelect: vc.tableView.rx.itemSelected,
                                                  completeTaps: completeItem.rx.tap.asSignal(),
                                                  textTaps: textItem.rx.tap.asSignal(),
                                                  imageTaps: imageItem.rx.tap.asSignal(),
                                                  videoTaps: videoItem.rx.tap.asSignal())
            
            viewModel = ZPublishViewModel(input, type: type)
            
            let dataSource = RxTableViewSectionedReloadDataSource<Section>(
                configureCell: { ds, tv, ip, item in return vc.configTableViewCell(item, for: ip)  },
                canEditRowAtIndexPath: { _,_ in return true })
            
            viewModel
                .input
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
                    
                    vc.tableViewSelectData(type, for: ip)
                })
                .disposed(by: disposed)
            
            vc
                .tableView
                .rx
                .setDelegate(self)
                .disposed(by: disposed)
            
        }
    }
    
    @objc public func removeContent(_ keyValue: ZKeyValueBean) {
        
        var value = viewModel.input.tableData.value
        
        if let idx = value.firstIndex(of: keyValue) {
            
            value.remove(at: idx)
        }
        
        viewModel.input.tableData.accept(value)
    }
    
    @objc public func addContent(_ keyValue: ZKeyValueBean) {
        
        var value = viewModel.input.tableData.value
        
        value += [keyValue]
        
        viewModel.input.tableData.accept(value)
    }
    @objc public func replaceContent(_ keyValue: ZKeyValueBean) {
        
        vc.tableView.reloadData()
    }
}

extension ZPublishBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return vc.caculate(forCell: datasource[indexPath], for: indexPath)
    }
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "删除") { [weak self] (a, ip) in
            
            guard let `self` = self else { return }
            
            let type = self.dataSource[ip]
            
            let alert = UIAlertController(title: "删除内容", message: "是否删除当前内容？", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "取消", style: .cancel) { (a) in }
            
            let confirm = UIAlertAction(title: "确定", style: .default) { [weak self] (a) in
                
                guard let `self` = self else { return }
                
                self.removeContent(type)
            }
            
            alert.addAction(cancel)
            
            alert.addAction(confirm)
            
            self.vc.present(alert, animated: true, completion: nil)
            
        }
        
        return [delete]
    }
}
