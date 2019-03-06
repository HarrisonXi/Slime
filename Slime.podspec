Pod::Spec.new do |spec|
  spec.name         = 'Slime'
  spec.version      = '0.0.1'
  spec.summary      = 'Slime'
  spec.homepage     = 'https://github.com/HarrisonXi/Slime'
  spec.license      = { :type => 'MIT' }
  spec.author       = { 'HarrisonXi' => 'gpra8764@gmail.com' }
  spec.source       = { :git => 'https://github.com/HarrisonXi/Slime.git', :branch => 'master' }
  spec.source_files = 'Slime/*.{h,m}'
  spec.private_header_files = 'Slime/*+Private.h', 'Slime/SLMIvarSetter.h', 'Slime/SLMMethodSetter.h'
end
