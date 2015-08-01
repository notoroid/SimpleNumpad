Pod::Spec.new do |s|

  s.name         = "SimpleNumpad"
  s.version      = "0.3.1"
  s.summary      = "SimpleNumpad provides a simple Numpad to your app . iOS8 it will support later ."

  s.description  = <<-DESC
                   SimpleNumpad provides a simple Numpad to your app . iOS8 it will support later . - SimpleNumpad は貴方のアプリにシンプルなNumpad を提供します。iOS8 以降をサポートします。 
                   DESC

  s.homepage     = "https://github.com/notoroid/SimpleNumpad"
  s.screenshots  = "https://raw.githubusercontent.com/notoroid/SimpleNumpad/master/Screenshots/ss01.png", "https://raw.githubusercontent.com/notoroid/SimpleNumpad/master/Screenshots/ss02.png", "https://raw.githubusercontent.com/notoroid/SimpleNumpad/master/Screenshots/ss03.png"


  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "notoroid" => "noto@irimasu.com" }
  s.social_media_url   = "http://twitter.com/notoroid"

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/notoroid/SimpleNumpad.git", :tag => "v0.3.1" }

  s.source_files  = "Lib/**/*.{h,m}"
  s.resources  = "Lib/**/*.{storyboard,xib}"
  s.framework    = "QuartzCore"

  s.requires_arc = true

end
