Pod::Spec.new do |spec|
  
  spec.name         = "ZBridge"
  spec.version      = "0.6.9"
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
    base.dependency 'RxCocoa', '5.0.1'
    base.dependency 'RxSwift'
  end
  
  #欢迎界面
  spec.subspec 'Welcome' do |welcome|
    
    welcome.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Welcome/VM/*.{swift}"
      vm.dependency 'WLToolsKit/Common'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxCocoa', '5.0.1'
    end
    
    welcome.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Welcome/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/Welcome/VM'
      bridge.dependency 'ZCollection'
      bridge.dependency 'ZCocoa/SM'
      bridge.dependency 'ZCocoa/Button'
      bridge.dependency 'ZBridge/Base'
      bridge.dependency 'WLToolsKit/Color'
    end
  end
  # 协议
  spec.subspec 'Privacy' do |privacy|
    
    privacy.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Privacy/VM/*.{swift}"
      vm.dependency 'RxCocoa', '5.0.1'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZSign'
    end
    
    privacy.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Privacy/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/Privacy/VM'
      bridge.dependency 'ZInner'
      bridge.dependency 'ZBridge/Base'
      
    end
  end
  # 登陆
  spec.subspec 'Login' do |login|
    
    login.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Login/VM/*.{swift}"
      vm.dependency 'RxCocoa', '5.0.1'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZCheck'
      vm.dependency 'ZRealReq'
      vm.dependency 'ZApi'
    end
    
    login.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Login/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/Login/VM'
      bridge.dependency 'ZCocoa/TextField'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZBase'
      bridge.dependency 'ZBridge/Base'
    end
  end
  
  # 注册/登陆
  spec.subspec 'Reg' do |reg|
    
    reg.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Reg/VM/*.{swift}"
      vm.dependency 'RxCocoa', '5.0.1'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZCheck'
      vm.dependency 'ZRealReq'
      vm.dependency 'ZApi'
    end
    
    reg.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Reg/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/Reg/VM'
      bridge.dependency 'ZCocoa/TextField'
      bridge.dependency 'ZCocoa/Button'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZBase'
      bridge.dependency 'ZBridge/Base'
    end
  end
  
  # 密码
  spec.subspec 'Password' do |password|
    
    password.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Password/VM/*.{swift}"
      vm.dependency 'RxCocoa', '5.0.1'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZCheck'
      vm.dependency 'ZRealReq'
      vm.dependency 'ZApi'
    end
    
    password.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Password/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/Password/VM'
      bridge.dependency 'ZCocoa/TextField'
      bridge.dependency 'ZCocoa/Button'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZBase'
      bridge.dependency 'ZBridge/Base'
    end
  end
  
  # 设置
  spec.subspec 'Setting' do |setting|
    
    setting.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Setting/VM/*.{swift}"
      vm.dependency 'RxCocoa', '5.0.1'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZCache/Account'
      vm.dependency 'ZSign'
    end
    
    setting.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Setting/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/Setting/VM'
      bridge.dependency 'ZCache/Account'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCocoa/SM'
      bridge.dependency 'RxDataSources'
      bridge.dependency 'ZBridge/Base'
    end
  end
  
  # 个人中心
  spec.subspec 'Profile' do |profile|
    
    profile.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Profile/VM/*.{swift}"
      vm.dependency 'RxCocoa', '5.0.1'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZCache/Account'
      vm.dependency 'ZCache/User'
      vm.dependency 'ZApi'
      vm.dependency 'ZRealReq'
    end
    
    profile.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Profile/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/Profile/VM'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCocoa/SM'
      bridge.dependency 'RxDataSources'
      bridge.dependency 'RxGesture'
      bridge.dependency 'ZBridge/Base'
      bridge.dependency 'ZHud'
    end
  end
  
  # 关于我们
  spec.subspec 'About' do |about|
    
    about.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/About/VM/*.{swift}"
      vm.dependency 'RxCocoa', '5.0.1'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLToolsKit/String'
    end
    
    about.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/About/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/About/VM'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCocoa/SM'
      bridge.dependency 'RxDataSources'
      bridge.dependency 'ZBridge/Base'
    end
  end
  # 我的资料
  spec.subspec 'UserInfo' do |userinfo|
    
    userinfo.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/UserInfo/VM/*.{swift}"
      vm.dependency 'RxCocoa', '5.0.1'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLBaseResult'
      vm.dependency 'ZCache/User'
      vm.dependency 'ZApi'
      vm.dependency 'ZRealReq'
    end
    
    userinfo.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/UserInfo/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/UserInfo/VM'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCocoa/SM'
      bridge.dependency 'RxDataSources'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZBridge/Base'
    end
  end
  
  # 昵称
  spec.subspec 'NickName' do |nickName|
    
    nickName.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/NickName/VM/*.{swift}"
      vm.dependency 'RxCocoa', '5.0.1'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZCache/User'
      vm.dependency 'ZRealReq'
      vm.dependency 'ZApi'
      vm.dependency 'WLBaseResult'
    end
    
    nickName.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/NickName/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/NickName/VM'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZBase'
      bridge.dependency 'ZBridge/Base'
    end
  end
  # 个性签名
  spec.subspec 'Signature' do |signature|
    
    signature.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Signature/VM/*.{swift}"
      vm.dependency 'RxCocoa', '5.0.1'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZCache/User'
      vm.dependency 'ZRealReq'
      vm.dependency 'ZApi'
      vm.dependency 'WLBaseResult'
    end
    
    signature.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Signature/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/Signature/VM'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZBase'
      bridge.dependency 'ZBridge/Base'
    end
  end
end
