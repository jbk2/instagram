# -*- encoding: utf-8 -*-
# stub: aws-sdk 2.0.22 ruby lib

Gem::Specification.new do |s|
  s.name = "aws-sdk"
  s.version = "2.0.22"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Amazon Web Services"]
  s.date = "2015-02-05"
  s.description = "Provides libraries for AWS."
  s.homepage = "http://github.com/aws/aws-sdk-core-ruby"
  s.licenses = ["Apache 2.0"]
  s.rubygems_version = "2.4.5"
  s.summary = "AWS SDK for Ruby - Version 2"

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<aws-sdk-resources>, ["= 2.0.22"])
    else
      s.add_dependency(%q<aws-sdk-resources>, ["= 2.0.22"])
    end
  else
    s.add_dependency(%q<aws-sdk-resources>, ["= 2.0.22"])
  end
end
