# -*- encoding: utf-8 -*-
# stub: sinatra-bells 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "sinatra-bells"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jens Wille"]
  s.date = "2014-04-14"
  s.description = "Extends Sinatra with some convenience shortcuts."
  s.email = "jens.wille@gmail.com"
  s.extra_rdoc_files = ["README", "COPYING", "ChangeLog"]
  s.files = ["COPYING", "ChangeLog", "README", "Rakefile", "lib/sinatra-bells.rb", "lib/sinatra/bells.rb", "lib/sinatra/bells/helpers.rb", "lib/sinatra/bells/helpers/controller.rb", "lib/sinatra/bells/helpers/html.rb", "lib/sinatra/bells/version.rb"]
  s.homepage = "http://github.com/blackwinter/sinatra-bells"
  s.licenses = ["AGPL-3.0"]
  s.post_install_message = "\nsinatra-bells-0.0.1 [2014-04-14]:\n\n* First release.\n\n"
  s.rdoc_options = ["--title", "sinatra-bells Application documentation (v0.0.1)", "--charset", "UTF-8", "--line-numbers", "--all", "--main", "README"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
  s.rubygems_version = "2.2.2"
  s.summary = "Sinatra with some more bells and whistles."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sinatra>, [">= 0"])
      s.add_development_dependency(%q<hen>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<sinatra>, [">= 0"])
      s.add_dependency(%q<hen>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<sinatra>, [">= 0"])
    s.add_dependency(%q<hen>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
