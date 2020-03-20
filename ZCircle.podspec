Pod::Spec.new do |spec|
  
  spec.name         = "ZCircle"
  spec.version      = "0.5.0"
  spec.summary      = "A Lib For 圈子."
  spec.description  = <<-DESC
  ZCircle是圈子
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
  
  spec.source_files = "Code/ZCircle/*.{h,m}"
  spec.dependency 'ZConfig'
  spec.dependency 'ZActionBridge/TList/Bridge'
  spec.dependency 'ZTable'
  spec.dependency 'JXTAlertManager'
  spec.dependency 'Masonry'
  spec.dependency 'SDWebImage'
  spec.dependency 'SToolsKit'
end

