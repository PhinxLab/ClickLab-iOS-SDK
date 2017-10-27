Pod::Spec.new do |s|
s.name             = 'ClickLab'
s.version          = '1.0.4'
s.summary          = 'ClickLAB Trackeame iOS SDK.'

s.description      = <<-DESC
iOS SDK to track events using Trackeame.
DESC

s.homepage         = 'https://github.com/clicklab-dev/ClickLab-iOS-SDK'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'ClickLAB' => 'clicklab.tracking@gmail.com' }
s.source           = { :git => 'https://github.com/clicklab-dev/ClickLab-iOS-SDK.git', :tag => s.version.to_s }

s.platform              = :ios, '7.1'
s.ios.deployment_target = '7.1'

s.source_files = 'ClickLab/Classes/**/*'
s.public_header_files = 'ClickLab/Classes/**/*.h'
s.library      = 'sqlite3.0'
s.vendored_libraries = 'lib/ClickLab/libClickLab.a'

end
