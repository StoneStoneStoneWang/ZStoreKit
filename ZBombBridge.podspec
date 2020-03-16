Pod::Spec.new do |spec|
  
  spec.name         = "ZBombBridge"
  spec.version      = "0.4.1"
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
  # 举报
  spec.subspec 'Translate' do |translate|
    
    translate.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Translate/VM/*.{swift}"
      vm.dependency 'RxCocoa'
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
  
end
