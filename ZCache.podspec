Pod::Spec.new do |spec|
  
  spec.name         = "ZCache"
  spec.version      = "0.0.2"
  spec.summary      = "A Lib For cache."
  spec.description  = <<-DESC
  ZCache是user 和account 的封装
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
  
  spec.subspec 'Account' do |account|
    account.source_files = "Code/ZCache/Account/*.{swift}"
    account.dependency 'ZBean/Account'
  end
  
  spec.subspec 'User' do |user|
    user.source_files = "Code/ZCache/User/*.{swift}"
    user.dependency 'ZBean/User'
    user.dependency 'ZYYCache'
    user.dependency 'ZCache/Account'
  end
  
end
