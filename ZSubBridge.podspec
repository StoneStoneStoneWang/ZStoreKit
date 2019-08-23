Pod::Spec.new do |spec|
  
  spec.name         = "ZSubBridge"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For bridge."
  spec.description  = <<-DESC
  ZSubBridge是oc swift 转换的封装呢
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
  # 欢迎界面碎片
  spec.subspec 'Welcome' do |welcome|
    
    welcome.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZSubBridge/Welcome/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLToolsKit/Common'
      vm.dependency 'WLBaseViewModel'
    end
    
    welcome.subspec 'Bridge' do |vm|
      vm.source_files = "Code/ZSubBridge/Welcome/Bridge/*.{swift}"
      vm.dependency 'ZSubBridge/Welcome/VM'
      vm.dependency 'ZContainer/Collection'
      vm.dependency 'ZNoti'
      vm.dependency 'ZCocoa'
      vm.dependency 'WLBaseTableView/SM'
      vm.dependency 'SnapKit'
      vm.dependency 'WLToolsKit/Color'
    end
    
  end
  
end
