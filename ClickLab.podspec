Pod::Spec.new do |s|
s.name             = 'ClickLab'
s.version          = '1.0.2'
s.summary          = 'ClickLab client iOS SDK.'

s.description      = <<-DESC
iOS SDK to track events using ClickLab.
DESC

s.homepage         = 'http://www.clicklab.com/'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'ClickLab' => 'clicklab.tracking@gmail.com' }
s.source           = { :git => 'https://github.com/PhinxLab/ClickLab-iOS.git', :tag => s.version.to_s }

s.platform              = :ios, '7.1'
s.ios.deployment_target = '7.1'

s.source_files = 'ClickLab/Classes/**/*'
s.public_header_files = 'ClickLab/Classes/**/*.h'
s.library      = 'sqlite3.0'
s.vendored_libraries = 'lib/ClickLab/libClickLab.a'

end
