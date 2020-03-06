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
      vm.dependency 'ZCocoa/SM'
      vm.dependency 'ZBridge/Base'
      vm.dependency 'WLToolsKit/Color'
    end
  end
  # 协议
  spec.subspec 'Pravicy' do |pravicy|
    
    pravicy.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Pravicy/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZSign'
    end
    
    pravicy.subspec 'Bridge' do |vm|
      vm.source_files = "Code/ZBridge/Pravicy/Bridge/*.{swift}"
      vm.dependency 'ZBridge/Pravicy/VM'
      vm.dependency 'ZCollection'
      vm.dependency 'ZInner'
    end
  end
  
  # 登陆
  spec.subspec 'Login' do |login|
    
    login.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Login/VM/*.{swift}"
      vm.dependency 'RxCocoa'
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
      bridge.dependency 'ZNoti'
      bridge.dependency 'ZBase'
    end
  end
  
  # 注册/登陆
  spec.subspec 'Reg' do |reg|
    
    reg.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Reg/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZCheck'
      vm.dependency 'ZRealReq'
      vm.dependency 'ZApi'
    end
    
    reg.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Reg/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/Reg/VM'
      bridge.dependency 'ZCocoa/TextField'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZNoti'
      bridge.dependency 'ZBase'
    end
  end
  # 密码
  spec.subspec 'Password' do |password|
    
    password.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Password/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZCheck'
      vm.dependency 'ZRealReq'
      vm.dependency 'ZApi'
    end
    
    password.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Password/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/Password/VM'
      bridge.dependency 'ZCocoa/TextField'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZNoti'
      bridge.dependency 'ZBase'
    end
  end
  
  # 黑名单
  spec.subspec 'Black' do |black|
    
    black.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Black/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZBean/Black'
      vm.dependency 'ZRealReq'
      vm.dependency 'ZApi'
    end
    
    black.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Black/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/Black/VM'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZNoti'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCocoa/ASM'
      bridge.dependency 'ZCocoa/TableView'
    end
  end
  # 我的关注
  spec.subspec 'Focus' do |focus|
    
    focus.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Focus/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZBean/Focus'
      vm.dependency 'ZRealReq'
      vm.dependency 'ZApi'
    end
    
    focus.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Focus/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/Focus/VM'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZNoti'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCocoa/ASM'
      bridge.dependency 'ZCocoa/TableView'
    end
  end
  
  # 设置
  spec.subspec 'Setting' do |setting|
    
    setting.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Setting/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZCache/Account'
      vm.dependency 'ZSign'
    end
    
    setting.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Setting/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/Setting/VM'
      bridge.dependency 'ZNoti'
      bridge.dependency 'ZCache/Account'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCocoa/SM'
      bridge.dependency 'RxDataSources'
      
    end
  end
  
  # 个人中心
  spec.subspec 'Profile' do |profile|
    
    profile.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Profile/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZCache/Account'
      vm.dependency 'ZNoti'
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
    end
  end
  
  # 关于我们
  spec.subspec 'About' do |about|
    
    about.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/About/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
    end
    
    about.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/About/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/About/VM'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCocoa/SM'
      bridge.dependency 'RxDataSources'
    end
  end
  # 我的资料
  spec.subspec 'UserInfo' do |userinfo|
    
    userinfo.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/UserInfo/VM/*.{swift}"
      vm.dependency 'RxCocoa'
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
    end
  end
  
  # 登陆
  spec.subspec 'NickName' do |nickName|
    
    nickName.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/NickName/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZCache/User'
      vm.dependency 'ZRealReq'
      vm.dependency 'ZApi'
    end
    
    nickName.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/NickName/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/NickName/VM'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZNoti'
      bridge.dependency 'ZBase'
    end
  end
  
  # 个性签名
  spec.subspec 'Signature' do |signature|
    
    signature.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Signature/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZCache/User'
      vm.dependency 'ZRealReq'
      vm.dependency 'ZApi'
    end
    
    signature.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Signature/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/Signature/VM'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZNoti'
      bridge.dependency 'ZBase'
    end
  end
  # 地图
  spec.subspec 'ZAMap' do |amap|
    
    amap.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Map/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZRealReq'
      vm.dependency 'WLBaseResult'
      vm.dependency 'ZApi'
      vm.dependency 'ZBean/KeyValue'
      vm.frameworks = 'UIKit', 'Foundation' ,'CoreLocation'
      vm.dependency 'ZCache'
    end
    
    amap.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Map/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/ZAMap/VM'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZNoti'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCocoa/SM'
      
    end
  end
  
  # 列表
  spec.subspec 'TList' do |tList|
    
    tList.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/TList/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZRealReq'
      vm.dependency 'WLBaseResult'
      vm.dependency 'ZApi'
      vm.dependency 'ZBean/Circle'
    end
    
    tList.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/TList/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/TList/VM'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZNoti'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCocoa/ASM'
    end
  end
  
  # 列表
  spec.subspec 'CList' do |cList|
    
    cList.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/CList/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZRealReq'
      vm.dependency 'WLBaseResult'
      vm.dependency 'ZApi'
      vm.dependency 'ZBean/Commodity'
    end
    
    cList.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/CList/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/CList/VM'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZNoti'
      bridge.dependency 'ZCollection'
      bridge.dependency 'ZCocoa/ASM'
    end
  end
  
  # 举报
  spec.subspec 'Report' do |report|
    
    report.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Report/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ObjectMapper'
      vm.dependency 'RxDataSources'
      vm.dependency 'ZApi'
      vm.dependency 'ZRealReq'
    end
    
    report.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Report/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/Report/VM'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCocoa/SM'
      bridge.dependency 'RxDataSources'
    end
  end
  
  # 举报
  spec.subspec 'Evaluate' do |evaluate|
    
    evaluate.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Evaluate/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ObjectMapper'
      vm.dependency 'RxDataSources'
      vm.dependency 'ZApi'
      vm.dependency 'ZRealReq'
    end
    
    evaluate.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Evaluate/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/Evaluate/VM'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCocoa/SM'
      bridge.dependency 'RxDataSources'
    end
  end
  
  # 列表
  spec.subspec 'Comment' do |comment|
    
    comment.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Comment/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZRealReq'
      vm.dependency 'WLBaseResult'
      vm.dependency 'ZApi'
      vm.dependency 'ZBean/Comment'
    end
    
    comment.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Comment/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/Comment/VM'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZNoti'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCocoa/ASM'
    end
  end
  # 列表
  spec.subspec 'Content' do |content|
    
    content.subspec 'VM' do |vm|
      vm.source_files = "Code/ZBridge/Content/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZBean/Circle'
    end
    
    content.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Content/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/Content/VM'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZNoti'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCocoa/ASM'
    end
  end
  # 个性签名
  spec.subspec 'TextEdit' do |textEdit|
    
    textEdit.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/TextEdit/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
    end
    
    textEdit.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/TextEdit/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/TextEdit/VM'
      bridge.dependency 'ZBase'
    end
  end
  # 列表
  spec.subspec 'Publish' do |publish|
    
    publish.subspec 'VM' do |vm|
      vm.source_files = "Code/ZBridge/Publish/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZBean/Circle'
    end
    
    publish.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Publish/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/Publish/VM'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZNoti'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCocoa/ASM'
      bridge.dependency 'ZRealReq'
    end
  end
  # 列表
  spec.subspec 'Banner' do |banner|
    
    banner.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Banner/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZRealReq'
      vm.dependency 'WLBaseResult'
      vm.dependency 'ZApi'
      vm.dependency 'ZBean/Circle'
    end
    
    banner.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Banner/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/Banner/VM'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZNoti'
      bridge.dependency 'ZCollection'
      bridge.dependency 'ZCocoa/ASM'
    end
  end
  # 列表
  spec.subspec 'Handle' do |handle|
    
    handle.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Handle/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZCache'
      vm.frameworks = 'UIKit', 'Foundation' ,'CoreLocation'
    end
    
    handle.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Handle/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/Handle/VM'
      bridge.dependency 'ZCollection'
    end
  end
  # 列表
  spec.subspec 'Handler' do |handler|
    
    handler.subspec 'VM' do |vm|
      vm.source_files = "Code/ZBridge/Handler/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZRealReq'
      vm.dependency 'WLBaseResult'
      vm.dependency 'ZApi'
      vm.dependency 'ZBean/Circle'
    end
    
    handler.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Handler/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/Handler/VM'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZNoti'
      bridge.dependency 'ZCollection'
      bridge.dependency 'ZCocoa/ASM'
    end
  end
  
  # 列表
  spec.subspec 'Order' do |order|
    
    order.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Order/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZRealReq'
      vm.dependency 'WLBaseResult'
      vm.dependency 'ZApi'
      vm.dependency 'ZBean/Circle'
    end
    
    order.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Order/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/Order/VM'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZNoti'
      bridge.dependency 'ZCollection'
      bridge.dependency 'ZCocoa/ASM'
    end
  end
  # 列表
  spec.subspec 'Characters' do |character|
    
    character.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Characters/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZRealReq'
      vm.dependency 'WLBaseResult'
      vm.dependency 'ZApi'
      vm.dependency 'ZBean/Circle'
    end
    
    character.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/ZBridge/Characters/Bridge/*.{swift}"
      bridge.dependency 'ZBridge/Order/VM'
      bridge.dependency 'ZHud'
      bridge.dependency 'ZNoti'
      bridge.dependency 'ZTable'
      bridge.dependency 'ZCocoa/ASM'
      bridge.dependency 'ZCocoa/SM'
    end
  end
end
