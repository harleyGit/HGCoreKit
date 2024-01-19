#
# Be sure to run `pod lib lint HGCoreKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HGCoreKit'
  s.version          = '0.1.0'
  s.summary          = 'Personal custom iOS Kit Class of HGCoreKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/harleyGit/HGCoreKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'HGCoreKit', :file => 'LICENSE' }
  s.author           = { 'harleyGit' => 'harelysoa@qq.com' }
  s.source           = { :git => 'https://github.com/harleyGit/HGCoreKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform = :ios, '11.0'
  s.ios.deployment_target = '11.0'
  
  #是否使用引用计数
  s.requires_arc = true
  #是否导出静态库
  s.static_framework = true

  s.source_files = 'HGCoreKit/Classes/**/*.{h,m,mm}'
  # 暴露公共头文件,若是没有这些则默认为s.source_files里的文件
  s.public_header_files = 'HGCoreKit/Classes/{HGCoreKit,HGCoreKitDefines}.h'
  s.prefix_header_file = './HGCoreKitPrefixHeader.pch'
  
  # s.resource_bundles = {
  #   'HGCoreKit' => ['HGCoreKit/Assets/*.png']
  # }

  #指定依赖的系统库,避免链接错误
  s.frameworks = 'UIKit', 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
