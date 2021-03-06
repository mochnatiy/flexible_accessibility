# encoding: utf-8

Gem::Specification.new do |s|
  s.name = 'flexible_accessibility'
  s.version = '0.3.17'
  s.authors = ['Sergei Avanesov']
  s.date = '2019-01-24'
  s.summary = 'Flexible access control system'
  s.description = 'Flexible access control system for your rails application. Based on analysis of controller actions'
  s.email = 'sergey.awanesov@gmail.com'
  s.homepage = 'http://github.com/mochnatiy/flexible_accessibility'
  s.licenses = ['MIT']
  s.require_paths = ['lib']

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.rubygems_version = '3.0.2'
  s.required_rubygems_version = Gem::Requirement.new('> 1.3.1') if s.respond_to? :required_rubygems_version=

  s.add_development_dependency 'i18n'
  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec_junit_formatter'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rubocop', '0.59.2'
end
