Pod::Spec.new do |s|
  s.name = 'ONECore'
  s.version = '0.1.0'
  s.summary = 'One Labs Core Library'
  s.description = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.homepage = 'https://github.com/ndv6/ONECore'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { 'onelabs' => 'onelabsco@gmail.com' }
  s.source = { :git => 'https://github.com/ndv6/ONECore.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'
  s.source_files = 'ONECore/Classes/**/*'
  s.dependency 'SDWebImage'
end