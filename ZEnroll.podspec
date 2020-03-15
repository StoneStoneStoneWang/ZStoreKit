Pod::Spec.new do |spec|
  
  spec.name         = "ZEnroll"
  spec.version      = "0.3.5"
  spec.summary      = "A Lib For 报名."
  spec.description  = <<-DESC
  ZEnroll是角色信息
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
  
  spec.source_files = "Code/ZEnroll/*.{h,m}"
  spec.dependency 'ZConfig'
  spec.dependency 'ZActionBridge/Enroll'
  spec.dependency 'ZTable'
  spec.dependency 'Masonry'
  spec.dependency 'JXTAlertManager'
  spec.dependency 'SToolsKit'
  spec.dependency 'ZTField'
  spec.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }
  
end

