Pod::Spec.new do |s|
  s.name         = "SHBLame"
  s.version      = "0.0.1"
  s.summary      = "音频转成mp3"
  s.description  = <<-DESC
    lame库，音频转mp3
                   DESC
  s.homepage     = "https://github.com/jiutianhuanpei/SHBLame"
  s.license      = "MIT"
  s.author             = { "shenhongbang" => "shenhongbang@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/jiutianhuanpei/SHBLame.git", :tag => "0.0.1" }
  s.source_files  = "SHBLame/*"
  s.frameworks = "AVFoundation", "UIKit"
  s.libraries = "lame"
  s.requires_arc = true
end
