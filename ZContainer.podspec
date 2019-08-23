Pod::Spec.new do |spec|
  
  spec.name         = "ZContainer"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For container."
  spec.description  = <<-DESC
  ZContainer是ocvc容器的封装
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
    base.source_files = "Code/ZContainer/ZBase/*.{h,m}"
    base.dependency 'ZBridge/Base'
  end
  
  spec.subspec 'Table' do |table|
    table.source_files = "Code/ZContainer/ZTable/*.{h,m}"
    table.dependency 'ZContainer/Base'
    table.dependency 'WLBaseTableView/RTV'
    table.dependency 'ZLoading'
  end
  
  spec.subspec 'Collection' do |collection|
    collection.source_files = "Code/ZContainer/ZCollect/*.{h,m}"
    collection.dependency 'ZContainer/Base'
    collection.dependency 'ZLoading'
    collection.dependency 'MJRefresh'
  end
  
end
