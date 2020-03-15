Pod::Spec.new do |spec|
  
  spec.name         = "ZActionBridge"
  spec.version      = "0.3.2"
  spec.summary      = "A Lib For bridge."
  spec.description  = <<-DESC
  ZActionBridge是oc swift 转换的封装呢
  DESC
  
  spec.homepage     = "https://github.com/StoneStoneStoneWang/ZStoreKit.git"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author             = { "StoneStoneStoneWang" => "yuanxingfu1314@163.com" }
  spec.platform     = :ios, "10.0"
  spec.ios.deployment_target = "10.0"
  
  spec.swift_version = '5.0'
  
  spec.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  
  spec.static_framework = true
  
  spec.frameworks = 'UIKit', 'Foundation'
  
  spec.source = { :git => "https://github.com/StoneStoneStoneWang/ZStoreKit.git", :tag => "#{spec.version}" }
  # 举报
  spec.subspec 'Report' do |report|
    
    report.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Report/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ObjectMapper'
      vm.dependency 'RxDataSources'
      vm.dependency 'ZApi'
      vm.dependency 'ZRealReq'
      vm.dependency 'WLBaseResult'
    end
    
    report.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Report/Bridge/*.{swift}"
      bridge.dependency 'ZActionBridge/Report/VM'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCocoa/SM'
      bridge.dependency 'RxDataSources'
      bridge.dependency 'ZBridge/Base'
      bridge.dependency 'ZHud'
    end
  end
  
  #  # 举报
  #  spec.subspec 'Evaluate' do |evaluate|
  #
  #    evaluate.subspec 'VM' do |vm|
  #
  #      vm.source_files = "Code/ZBridge/Evaluate/VM/*.{swift}"
  #      vm.dependency 'RxCocoa'
  #      vm.dependency 'WLBaseViewModel'
  #      vm.dependency 'ObjectMapper'
  #      vm.dependency 'RxDataSources'
  #      vm.dependency 'ZApi'
  #      vm.dependency 'ZRealReq'
  #      vm.dependency 'WLBaseResult'
  #    end
  #
  #    evaluate.subspec 'Bridge' do |bridge|
  #      bridge.source_files = "Code/ZBridge/Evaluate/Bridge/*.{swift}"
  #      bridge.dependency 'ZActionBridge/Evaluate/VM'
  #      bridge.dependency 'ZTable'
  #      bridge.dependency 'ZCocoa/SM'
  #      bridge.dependency 'RxDataSources'
  #      bridge.dependency 'ZBridge/Base'
  #      bridge.dependency 'ZHud'
  #    end
  #  end
  #
  # 黑名单
  spec.subspec 'Black' do |black|
    
    black.subspec 'VM' do |vm|
      vm.source_files = "Code/ZBridge/Black/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZBean/Black'
      vm.dependency 'ZRealReq'
      vm.dependency 'ZApi'
      vm.dependency 'WLBaseResult'
    end
    
    black.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Black/Bridge/*.{swift}"
      bridge.dependency 'ZActionBridge/Black/VM'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZNoti'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCocoa/ASM'
      bridge.dependency 'ZCocoa/TableView'
      bridge.dependency 'ZBridge/Base'
    end
  end
  # 我的关注
  spec.subspec 'Focus' do |focus|
    
    focus.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Focus/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZBean/Focus'
      vm.dependency 'ZRealReq'
      vm.dependency 'ZApi'
      vm.dependency 'WLBaseResult'
    end
    
    focus.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Focus/Bridge/*.{swift}"
      bridge.dependency 'ZActionBridge/Focus/VM'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZNoti'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCocoa/ASM'
      bridge.dependency 'ZCocoa/TableView'
      bridge.dependency 'ZBridge/Base'
    end
  end
  #
  # 列表
  spec.subspec 'Comment' do |comment|
    
    comment.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Comment/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZRealReq'
      vm.dependency 'WLBaseResult'
      vm.dependency 'ZApi'
      vm.dependency 'ZBean/Comment'
    end
    
    comment.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Comment/Bridge/*.{swift}"
      bridge.dependency 'ZActionBridge/Comment/VM'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCocoa/ASM'
      bridge.dependency 'ZBridge/Base'
      bridge.dependency 'ZCocoa/TableView'
    end
  end
  # 列表
  spec.subspec 'Content' do |content|
    
    content.subspec 'VM' do |vm|
      vm.source_files = "Code/ZBridge/Content/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZBean/KeyValue'
      vm.dependency 'ZBean/Circle'
      vm.dependency 'WLBaseResult'
    end
    
    content.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Content/Bridge/*.{swift}"
      bridge.dependency 'ZActionBridge/Content/VM'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCocoa/SM'
      bridge.dependency 'ZCocoa/TableView'
      bridge.dependency 'ZBridge/Base'
    end
  end
  spec.subspec 'TextEdit' do |textEdit|
    
    textEdit.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/TextEdit/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLBaseResult'
      vm.dependency 'WLToolsKit/String'
    end
    
    textEdit.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/TextEdit/Bridge/*.{swift}"
      bridge.dependency 'ZActionBridge/TextEdit/VM'
      bridge.dependency 'ZBase'
      bridge.dependency 'ZBridge/Base'
    end
  end
  # 列表
  spec.subspec 'Publish' do |publish|
    
    publish.subspec 'VM' do |vm|
      vm.source_files = "Code/ZBridge/Publish/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZBean/Circle'
      vm.dependency 'WLBaseResult'
      vm.dependency 'ZApi'
      vm.dependency 'ZRealReq'
    end
    
    publish.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Publish/Bridge/*.{swift}"
      bridge.dependency 'ZActionBridge/Publish/VM'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCocoa/SM'
      bridge.dependency 'ZRealReq'
      bridge.dependency 'ZBridge/Base'
    end
  end
  # 列表
  spec.subspec 'Banner' do |banner|
    
    banner.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Banner/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZRealReq'
      vm.dependency 'WLBaseResult'
      vm.dependency 'ZApi'
      vm.dependency 'ZBean/Circle'
    end
    
    banner.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Banner/Bridge/*.{swift}"
      bridge.dependency 'ZActionBridge/Banner/VM'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZCollection'
      bridge.dependency 'ZCocoa/SM'
      bridge.dependency 'ZBridge/Base'
    end
  end
  # 列表
  spec.subspec 'Carousel' do |carousel|
    
    carousel.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Carousel/VM/*.{swift}"
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLBaseResult'
      vm.dependency 'RxCocoa'
      vm.dependency 'WLToolsKit/Common'
    end
    
    carousel.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Carousel/Bridge/*.{swift}"
      bridge.dependency 'ZActionBridge/Carousel/VM'
      bridge.dependency 'ZCollection'
      bridge.dependency 'ZCocoa/SM'
      bridge.dependency 'ZBridge/Base'
      bridge.dependency 'WLToolsKit/Common'
    end
  end
  # 列表
  #  spec.subspec 'Handle' do |handle|
  #
  #    handle.subspec 'VM' do |vm|
  #
  #      vm.source_files = "Code/ZBridge/Handle/VM/*.{swift}"
  #      vm.dependency 'RxCocoa'
  #      vm.dependency 'WLBaseViewModel'
  #      vm.dependency 'ZCache'
  #      vm.frameworks = 'UIKit', 'Foundation' ,'CoreLocation'
  #    end
  #
  #    handle.subspec 'Bridge' do |bridge|
  #      bridge.source_files = "Code/ZBridge/Handle/Bridge/*.{swift}"
  #      bridge.dependency 'ZActionBridge/Handle/VM'
  #      bridge.dependency 'ZCollection'
  #      bridge.dependency 'ZBridge/Base'
  #    end
  #  end
  # 列表
  #  spec.subspec 'Handler' do |handler|
  #
  #    handler.subspec 'VM' do |vm|
  #      vm.source_files = "Code/ZBridge/Handler/VM/*.{swift}"
  #      vm.dependency 'RxCocoa'
  #      vm.dependency 'WLBaseViewModel'
  #      vm.dependency 'ZRealReq'
  #      vm.dependency 'WLBaseResult'
  #      vm.dependency 'ZApi'
  #      vm.dependency 'ZBean/Circle'
  #      vm.dependency 'ZActionBridge/ZAMap/VM'
  #    end
  #
  #    handler.subspec 'Bridge' do |bridge|
  #      bridge.source_files = "Code/ZBridge/Handler/Bridge/*.{swift}"
  #      bridge.dependency 'ZActionBridge/Handler/VM'
  #      bridge.dependency 'ZHud'
  #      bridge.dependency 'ZNoti'
  #      bridge.dependency 'ZCollection'
  #      bridge.dependency 'ZCocoa/SM'
  #      bridge.dependency 'ZBridge/Base'
  #    end
  #  end
  
  #  # 列表
  #  spec.subspec 'Order' do |order|
  #
  #    order.subspec 'VM' do |vm|
  #
  #      vm.source_files = "Code/ZBridge/Order/VM/*.{swift}"
  #      vm.dependency 'RxCocoa'
  #      vm.dependency 'WLBaseViewModel'
  #      vm.dependency 'ZRealReq'
  #      vm.dependency 'WLBaseResult'
  #      vm.dependency 'ZApi'
  #      vm.dependency 'ZBean/Circle'
  #    end
  #
  #    order.subspec 'Bridge' do |bridge|
  #      bridge.source_files = "Code/ZBridge/Order/Bridge/*.{swift}"
  #      bridge.dependency 'ZActionBridge/Order/VM'
  #      bridge.dependency 'ZHud'
  #      bridge.dependency 'ZNoti'
  #      bridge.dependency 'ZCollection'
  #      bridge.dependency 'ZCocoa/ASM'
  #      bridge.dependency 'ZCocoa/SM'
  #      bridge.dependency 'ZCocoa/TableView'
  #      bridge.dependency 'ZBridge/Base'
  #      bridge.dependency 'ZTable'
  #    end
  #  end
  #  列表
  spec.subspec 'Characters' do |character|
    
    character.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Characters/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZRealReq'
      vm.dependency 'WLBaseResult'
      vm.dependency 'ZApi'
      vm.dependency 'ZBean/Circle'
    end
    
    character.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Characters/Bridge/*.{swift}"
      bridge.dependency 'ZActionBridge/Characters/VM'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCocoa/ASM'
      bridge.dependency 'ZCocoa/SM'
      bridge.dependency 'ZBridge/Base'
      bridge.dependency 'ZCocoa/TableView'
    end
  end
  
  # 列表
  spec.subspec 'Enroll' do |enrolls|
    
    enrolls.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Enroll/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZRealReq'
      vm.dependency 'WLBaseResult'
      vm.dependency 'ZApi'
      vm.dependency 'ZBean/Circle'
      vm.dependency 'WLToolsKit/Date'
    end
    
    enrolls.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Enroll/Bridge/*.{swift}"
      bridge.dependency 'ZActionBridge/Enroll/VM'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCocoa/ASM'
      bridge.dependency 'ZCocoa/SM'
      bridge.dependency 'ZBridge/Base'
      bridge.dependency 'ZCocoa/TableView'
    end
  end
  
  #  # 列表
  spec.subspec 'TList' do |tList|
    
    tList.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/TList/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZRealReq'
      vm.dependency 'WLBaseResult'
      vm.dependency 'ZApi'
      vm.dependency 'ZBean/Circle'
    end
    
    tList.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/TList/Bridge/*.{swift}"
      bridge.dependency 'ZActionBridge/TList/VM'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCocoa/ASM'
      bridge.dependency 'ZCocoa/TableView'
      bridge.dependency 'ZBridge/Base'
    end
  end
  #
  #  # 列表
  #  spec.subspec 'CList' do |cList|
  #
  #    cList.subspec 'VM' do |vm|
  #
  #      vm.source_files = "Code/ZBridge/CList/VM/*.{swift}"
  #      vm.dependency 'RxCocoa'
  #      vm.dependency 'WLBaseViewModel'
  #      vm.dependency 'ZRealReq'
  #      vm.dependency 'WLBaseResult'
  #      vm.dependency 'ZApi'
  #      vm.dependency 'ZBean/Commodity'
  #    end
  #
  #    cList.subspec 'Bridge' do |bridge|
  #      bridge.source_files = "Code/ZBridge/CList/Bridge/*.{swift}"
  #      bridge.dependency 'ZActionBridge/CList/VM'
  #      bridge.dependency 'ZHud'
  #      bridge.dependency 'ZNoti'
  #      bridge.dependency 'ZCollection'
  #      bridge.dependency 'ZCocoa/ASM'
  #      bridge.dependency 'ZCocoa/TableView'
  #      bridge.dependency 'ZBridge/Base'
  #    end
  #  end
  
  
end
