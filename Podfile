source 'https://github.com/CocoaPods/Specs'
platform :ios, '8.0'
inhibit_all_warnings!
use_frameworks!

workspace 'SGTUIKit'
project 'SGTUIKit.xcodeproj'
project 'Demo/Demo.xcodeproj'

target 'SGTUIKit' do
    project 'SGTUIKit.xcodeproj'
    platform :ios, '8.0'
    pod 'ReactiveCocoa'
    pod 'Masonry'
    pod 'SDWebImage'
end

target 'Demo' do
    project 'Demo/Demo'
    platform :ios, '8.0'
#    pod 'Reveal-iOS-SDK', :configurations => ['Debug']
    pod 'SGTUIKit', :path => '../SGTUIKit'
end
#  target 'Demo' do
#      project 'Demo/Demo.xcodeproj'
#      platform :ios, '8.0'
# #     pod 'ReactiveCocoa', '~> 2.5'
#      pod 'Masonry', '~> 0.6.3'
#      pod 'SDWebImage', '~> 3.7.3'
#  end