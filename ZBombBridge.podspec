Pod::Spec.new do |spec|
  
  spec.name         = "ZBombBridge"
  spec.version      = "0.6.2"
  spec.summary      = "A Lib For bridge."
  spec.description  = <<-DESC
  ZBombBridge是oc swift 转换的封装呢
  DESC
  
  spec.homepage     = "https://github.com/StoneStoneStoneWang/ZStoreKit.git"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author             = { "StoneStoneStoneWang" => "yuanxingfu1314@163.com" }
  spec.platform     = :ios, "10.0"
  spec.ios.deployment_target = "10.0"
  
  spec.swift_version = '5.0'
  
  spec.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  
  spec.static_framework = true
  
  spec.frameworks = 'UIKit', 'Foundation' ,'AVFoundation'
  
  spec.source = { :git => "https://github.com/StoneStoneStoneWang/ZStoreKit.git", :tag => "#{spec.version}" }
  # 翻译
  spec.subspec 'Translate' do |translate|
    
    translate.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Translate/VM/*.{swift}"
      vm.dependency 'RxCocoa', '5.0.1'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ObjectMapper'
      vm.dependency 'ZApi'
      vm.dependency 'ZRealReq'
      vm.dependency 'WLBaseResult'
    end
    
    translate.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Translate/Bridge/*.{swift}"
      bridge.dependency 'ZBombBridge/Translate/VM'
      bridge.dependency 'ZTransition'
      bridge.dependency 'ZBridge/Base'
      bridge.dependency 'ZHud'
    end
  end
  
  spec.subspec 'Area' do |area|
    
    area.subspec 'Manager' do |manager|
      
      manager.source_files = "Code/ZBridge/Area/Manager/*.{swift}"
      manager.dependency 'RxCocoa', '5.0.1'
      manager.dependency 'WLBaseViewModel'
      manager.dependency 'ObjectMapper'
      manager.dependency 'ZApi'
      manager.dependency 'ZRealReq'
      manager.dependency 'WLBaseResult'
      manager.dependency 'ZYYCache'
      manager.dependency 'ZBean/Area'
    end
    area.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Area/VM/*.{swift}"
      vm.dependency 'RxCocoa', '5.0.1'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLBaseResult'
      vm.dependency 'ZBean/Area'
    end
    
    area.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Area/Bridge/*.{swift}"
      bridge.dependency 'ZBombBridge/Area/VM'
      bridge.dependency 'ZBombBridge/Area/Manager'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCollection'
      bridge.dependency 'ZBridge/Base'
      bridge.dependency 'ZCocoa/SM'
    end
  end
  
  spec.subspec 'Address' do |address|
    
    address.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Address/VM/*.{swift}"
      vm.dependency 'RxCocoa', '5.0.1'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ObjectMapper'
      vm.dependency 'ZApi'
      vm.dependency 'ZRealReq'
      vm.dependency 'WLBaseResult'
      vm.dependency 'ZBean/Area'
      vm.dependency 'ZBean/Address'
      vm.dependency 'WLToolsKit/String'
      
    end
    
    address.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Address/Bridge/*.{swift}"
      bridge.dependency 'ZBombBridge/Address/VM'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZBridge/Base'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZCocoa/ASM'
      bridge.dependency 'ZCocoa/SM'
      bridge.dependency 'ZCocoa/TableView'
    end
  end
  
  spec.subspec 'Evaluate' do |evaluate|
    
    evaluate.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Evaluate/VM/*.{swift}"
      vm.dependency 'RxCocoa', '5.0.1'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ObjectMapper'
      vm.dependency 'RxDataSources'
      vm.dependency 'ZApi'
      vm.dependency 'ZRealReq'
      vm.dependency 'WLBaseResult'
    end
    
    evaluate.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Evaluate/Bridge/*.{swift}"
      bridge.dependency 'ZBombBridge/Evaluate/VM'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCocoa/SM'
      bridge.dependency 'RxDataSources'
      bridge.dependency 'ZBridge/Base'
      bridge.dependency 'ZHud'
    end
  end
  spec.subspec 'Video' do |video|
    
    video.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Video/VM/*.{swift}"
      vm.dependency 'RxCocoa', '5.0.1'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZApi'
      vm.dependency 'ZRealReq'
      vm.dependency 'WLBaseResult'
    end
    
    video.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Video/Bridge/*.{swift}"
      bridge.dependency 'ZBombBridge/Video/VM'
      bridge.dependency 'ZTransition'
      bridge.dependency 'ZCache/Account'
      bridge.dependency 'ZBridge/Base'
      bridge.dependency 'ZHud'
    end
  end
  spec.subspec 'Order' do |order|
    
    order.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Order/VM/*.{swift}"
      vm.dependency 'RxCocoa', '5.0.1'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZRealReq'
      vm.dependency 'WLBaseResult'
      vm.dependency 'ZApi'
      vm.dependency 'ZBean/Circle'
    end
    
    order.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Order/Bridge/*.{swift}"
      bridge.dependency 'ZBombBridge/Order/VM'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZCollection'
      bridge.dependency 'ZCocoa/ASM'
      bridge.dependency 'ZCocoa/SM'
      bridge.dependency 'ZCocoa/TableView'
      bridge.dependency 'ZBridge/Base'
      bridge.dependency 'ZTable'
    end
  end
  
  spec.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }
  
end
