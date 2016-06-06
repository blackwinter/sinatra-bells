# -*- encoding: utf-8 -*-
# stub: sinatra-bells 0.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "sinatra-bells".freeze
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jens Wille".freeze]
  s.date = "2016-06-06"
  s.description = "Extends Sinatra with some convenience shortcuts.".freeze
  s.email = "jens.wille@gmail.com".freeze
  s.extra_rdoc_files = ["README".freeze, "COPYING".freeze, "ChangeLog".freeze]
  s.files = ["COPYING".freeze, "ChangeLog".freeze, "README".freeze, "Rakefile".freeze, "lib/sinatra-bells.rb".freeze, "lib/sinatra/bells.rb".freeze, "lib/sinatra/bells/helpers.rb".freeze, "lib/sinatra/bells/helpers/controller.rb".freeze, "lib/sinatra/bells/helpers/view.rb".freeze, "lib/sinatra/bells/version.rb".freeze]
  s.homepage = "http://github.com/blackwinter/sinatra-bells".freeze
  s.licenses = ["AGPL-3.0".freeze]
  s.post_install_message = "\nsinatra-bells-0.4.0 [2016-06-06]:\n\n* Prevent Sinatra's hash merge behaviour in Sinatra::Bells.set.\n* Added Sinatra::Bells::Helpers::View#tag__ and HTML element helpers.\n\n".freeze
  s.rdoc_options = ["--title".freeze, "sinatra-bells Application documentation (v0.4.0)".freeze, "--charset".freeze, "UTF-8".freeze, "--line-numbers".freeze, "--all".freeze, "--main".freeze, "README".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "2.6.4".freeze
  s.summary = "Sinatra with some more bells and whistles.".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sinatra>.freeze, ["~> 1.4"])
      s.add_development_dependency(%q<hen>.freeze, [">= 0.8.5", "~> 0.8"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<sinatra>.freeze, ["~> 1.4"])
      s.add_dependency(%q<hen>.freeze, [">= 0.8.5", "~> 0.8"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<sinatra>.freeze, ["~> 1.4"])
    s.add_dependency(%q<hen>.freeze, [">= 0.8.5", "~> 0.8"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
