Pod::Spec.new do |spec|
  
  spec.name         = "ZBridge"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For bridge."
  spec.description  = <<-DESC
  ZBridge是oc swift 转换的封装呢
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
  
  spec.subspec 'Base' do |base|
    base.source_files = "Code/ZBridge/Base/*.{swift}"
    base.dependency 'RxCocoa'
  end
  
  # 欢迎界面碎片
  spec.subspec 'Welcome' do |welcome|
    
    welcome.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Welcome/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLToolsKit/Common'
      vm.dependency 'WLBaseViewModel'
    end
    
    welcome.subspec 'Bridge' do |vm|
      vm.source_files = "Code/ZBridge/Welcome/Bridge/*.{swift}"
      vm.dependency 'ZBridge/Welcome/VM'
      vm.dependency 'ZCollection'
      vm.dependency 'ZNoti'
      vm.dependency 'ZCocoa'
      vm.dependency 'WLBaseTableView/SM'
      vm.dependency 'ZBridge/Base'
      vm.dependency 'WLToolsKit/Color'
    end
  end
  # 协议
  spec.subspec 'Privacy' do |privacy|
    
    privacy.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Privacy/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZSign'
    end
    
    privacy.subspec 'Bridge' do |vm|
      vm.source_files = "Code/ZBridge/Privacy/Bridge/*.{swift}"
      vm.dependency 'ZBridge/Privacy/VM'
      vm.dependency 'ZCollection'
      vm.dependency 'ZInner'
    end
  end
  
end
