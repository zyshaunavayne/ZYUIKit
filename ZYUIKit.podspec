Pod::Spec.new do |spec|
  spec.name = "ZYUIKit"
  spec.version = "1.0.0"
  spec.summary = "常用分类、UI组件、宏定义、内联函数"
   spec.homepage = "https://github.com/zyshaunavayne/ZYUIKit"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "zyshaunavayne" => "shaunavayne@vip.qq.com" }
  spec.platform = :ios, "11.0"
  spec.frameworks = 'Foundation', 'UIKit'
  spec.requires_arc = true
  spec.source = { git: "https://github.com/zyshaunavayne/ZYUIKit.git", tag: spec.version, submodules: true }
  spec.source_files = "ZYUIKit/ZYUIKit.h"
  spec.resource_bundles = {'ZYResources' => ['ZYUIKit/ZYResources/*.*']}

  if spec.respond_to? 'swift_version'
    spec.swift_version = "5.0"
  end
  
  spec.dependency "Aspects"
  spec.dependency "Masonry"

  spec.subspec "ZYComponents" do |ss|
    ss.source_files = "ZYUIKit/ZYComponents/**/*"
  end
  
  spec.subspec "ZYCore" do |ss|
    ss.source_files = "ZYUIKit/ZYCore/**/*"
  end
  
  spec.subspec "ZYExtensions" do |ss|
    ss.source_files = "ZYUIKit/ZYExtensions/*"
    
    ss.subspec "UIKit" do |sss|
      sss.source_files = "ZYUIKit/ZYExtensions/UIKit/**/*"
    end
    
    ss.subspec "Foundation" do |sss|
      sss.source_files = "ZYUIKit/ZYExtensions/Foundation/**/*"
    end
  end
  
  spec.subspec "Swift" do |ss|
    ss.source_files = "ZYUIKit/Swift/**/*"
  end
  
end
