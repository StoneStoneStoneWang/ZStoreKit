Pod::Spec.new do |spec|
  
  spec.name         = "ZFragment"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For UI碎片."
  spec.description  = <<-DESC
  ZFragment是oc碎片化视图
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
  
  spec.subspec 'Config' do |config|
    config.source_files = "Code/ZFragment/Config/*.{h}"
  end
  
  # 欢迎界面碎片
  spec.subspec 'Welcome' do |welcome|
    
    welcome.source_files = "Code/ZFragment/Welcome/*.{h,m}"
    welcome.dependency 'ZFragment/Welcome'
    welcome.dependency 'ZCollection'
    welcome.dependency 'ZFragment/Config'
    welcome.dependency 'ZBridge/Welcome'
    welcome.dependency 'SToolsKit'
    welcome.dependency 'Masonry'
  end
  
end
