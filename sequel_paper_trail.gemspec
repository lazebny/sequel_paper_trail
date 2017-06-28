# coding: utf-8

$LOAD_PATH << File.expand_path('../lib', __FILE__)

require 'sequel_paper_trail/version'

Gem::Specification.new do |s|
  s.name          = 'sequel_paper_trail'
  s.version       = SequelPaperTrail::VERSION
  s.authors       = ['Vadim Lazebny']
  s.email         = ['vadim.lazebny@gmail.com']

  s.summary       = 'Sequel plugin for PaperTrail.'
  s.description   = s.summary
  s.homepage      = 'https://github.com/lazebny/sequel_paper_trail'
  s.license       = 'MIT'

  s.files             = Dir['README*', 'LICENSE*', 'CHANGELOG*']
  s.files            += Dir['{lib}/**/*']
  s.test_files        = Dir['{spec}/**/*']
  s.extra_rdoc_files  = Dir['README*', 'LICENSE*', 'CHANGELOG*']
  s.extra_rdoc_files += Dir['{docs}/**/*.{txt,md}']
  s.require_paths     = ['lib']

  s.required_ruby_version = '>= 1.8.7'
end
