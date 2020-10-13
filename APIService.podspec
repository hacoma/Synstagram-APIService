Pod::Spec.new do |s|
  s.name = 'APIService'
  s.version = '1.0.3'
  s.license = { :type => 'MIT' }
  s.homepage = 'https://github.com/hacoma/Synstagram-APIService'
  s.authors = { 'hacoma' => 'hacoma92@gmail.com' }
  s.summary = 'APIService for synstagram'
  s.swift_version = '5.0'

  s.ios.deployment_target = '11.0'

  s.source = { :git => 'https://github.com/hacoma/Synstagram-APIService.git', :tag => s.version }

  s.dependency 'HacomaExtensions', '1.0.2'

  s.default_subspec = :none

  s.subspec 'Auth' do |ss|
    ss.source_files = 'APIService/Module/Auth/Source/*.swift'
    ss.dependency 'HacomaNetwork', '1.0.2'
  end
end