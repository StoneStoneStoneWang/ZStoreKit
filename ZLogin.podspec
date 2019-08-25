Pod::Spec.new do |spec|
  
  spec.name         = "ZLogin"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For 登陆."
  spec.description  = <<-DESC
  ZLogin是登陆界面
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
  
  spec.source_files = "Code/ZLogin/*.{h,m}"
  spec.dependency 'WLComponentView/TextFeild/LeftImage'
  spec.dependency 'WLComponentView/TextFeild/Password'
  spec.dependency 'ZConfig'
  spec.dependency 'ZBridge/Login'
  
end
