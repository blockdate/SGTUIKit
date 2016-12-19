Pod::Spec.new do |s|
  s.name         = "SGTUIKit"
  s.version      = "1.0.10"
  s.summary      = "This is a private pod sp. provide SGTUIKit function."
  s.description  = <<-DESC
  This is a private Podspec. Provide SGTUIKit function. Base on ReactiveCocoa
                   DESC

  s.homepage     = "https://bitbucket.org/sgtfundation/sgtuikit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "吴磊" => "w.leo.sagittarius@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://bitbucket.org/sgtfundation/sgtuikit.git", :tag => s.version.to_s }
  s.source_files  = "Source/**/*.{h,m}"
  s.public_header_files = "Source/**/*.h"
  s.frameworks = "Foundation", "UIKit"
  s.requires_arc = true
  
  s.dependency 'ReactiveObjC'
  s.dependency 'Masonry'
  s.dependency 'SDWebImage'
end
