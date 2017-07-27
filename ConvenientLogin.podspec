Pod::Spec.new do |s|
	s.name         = 'ConvenientLogin'
    s.version      = '1.0.2'
    s.homepage     = "http://www.lianluo.com/"
    s.license      = { :type => 'MIT', :file => 'LICENSE' }
    s.author       = { "liguangjian" => "liguangjian@lianluo.com" }
    s.summary      = 'Lianluo UserCenter Module..'
    s.platform     =  :ios, '8.0'
    s.source       = { :git => "https://github.com/meliguangjian/ConvenientLogin.git", :tag => s.version.to_s }
    s.frameworks       = 'UIKit', 'JavaScriptCore','SystemConfiguration','CoreTelephony'
    s.libraries        = 'icucore', 'z.1.2.5', 'stdc++'
    s.requires_arc = true
    s.ios.deployment_target = '8.0'
    s.source_files  = ["ConvenientLogin/Classes/**"]

    s.default_subspecs = 'Tools', 'Network', 'ThirdParty'      #默认模块如果不写则为所有

    s.subspec 'Tools' do |tools|
        tools.source_files = 'ConvenientLogin/Classes/Tools/**.{h,m}'
        tools.dependency 'MBProgressHUD', '~> 0.9.1'
    end

    s.subspec 'Network' do |network|
        network.source_files = 'ConvenientLogin/Classes/Network/**.{h,m}'
        network.dependency 'ConvenientLogin/Tools'
        network.dependency 'Reachability'
    end

    s.subspec 'ThirdParty' do |thirdParty|
        thirdParty.source_files = 'ConvenientLogin/Classes/ThirdParty/**.{h,m}'
        thirdParty.frameworks = 'UIKit'
        thirdParty.dependency 'ConvenientLogin/Tools'
        thirdParty.dependency 'ConvenientLogin/Network'
    end

    s.subspec 'Connection' do |sp|
        # 腾讯QQ
        sp.subspec 'QQ' do |ssp|
            ssp.vendored_frameworks = 'ConvenientLogin/Lib/TencentOpenApiSDK/TencentOpenAPI.framework'
            ssp.libraries = 'sqlite3'
        end
        # WeChatSDK
        sp.subspec 'WeChatSDK' do |ssp|
            ssp.vendored_libraries = "ConvenientLogin/Lib/WeChatSDK/*.a"
            ssp.source_files = "ConvenientLogin/Lib/WeChatSDK/*.h"
            ssp.libraries = 'sqlite3'
        end
        # SinaWeibo
        sp.subspec 'SinaWeibo' do |ssp|
            ssp.vendored_libraries = "ConvenientLogin/Lib/SinaWeiboSDK/*.a"
            ssp.resources = 'ConvenientLogin/Lib/SinaWeiboSDK/WeiboSDK.bundle'
            ssp.frameworks = 'ImageIO'
            ssp.libraries = 'sqlite3'
            ssp.source_files = "ConvenientLogin/Lib/SinaWeiboSDK/*.{h,m}"
            ssp.public_header_files = "ConvenientLogin/Lib/SinaWeiboSDK/*.h"
        end
        # Facebook
        sp.subspec 'Facebook' do |ssp|
            ssp.vendored_frameworks = 'ConvenientLogin/Lib/FacebookSDK/Bolts.framework', 'ConvenientLogin/Lib/FacebookSDK/FBSDKCoreKit.framework', 'ConvenientLogin/Lib/FacebookSDK/FBSDKLoginKit.framework'
            ssp.resource = 'ConvenientLogin/Lib/FacebookSDK/FacebookSDKStrings.bundle'
        end
        # Twitter
        sp.subspec 'Twitter' do |ssp|
            ssp.vendored_frameworks = 'ConvenientLogin/Lib/TwitterSDK/TwitterCore.framework', 'ConvenientLogin/Lib/FacebookSDK/TwitterKit.framework'
            ssp.resource = 'ConvenientLogin/Lib/FacebookSDK/*.bundle'
        end
    end
end
