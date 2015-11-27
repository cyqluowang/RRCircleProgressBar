
Pod::Spec.new do |s|

  s.name         = "RRCircleProgressBar"
  s.version      = "0.0.2"
  s.summary      = "圆形精度条."

 
  s.description  = <<-DESC
  仁润圆形精度条
                   DESC

  s.homepage     = "https://github.com/cyqluowang/RRCircleProgressBar"
 

  s.license      = "MIT"
 
  s.author             = { "李峰健" => "yq.chen@renrunkeji.com" }
  
  s.platform     = :ios
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/cyqluowang/RRCircleProgressBar.git", :tag => s.version }
  s.source_files  = "Core/*"
  s.requires_arc = true
  s.ios.deployment_target = '7.0'
  s.framework  = 'QuartzCore'


end
