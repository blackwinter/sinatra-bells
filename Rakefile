require_relative 'lib/sinatra/bells/version'

begin
  require 'hen'

  Hen.lay! {{
    gem: {
      name:         %q{sinatra-bells},
      version:      Sinatra::Bells::VERSION,
      summary:      %q{Sinatra with some more bells and whistles.},
      description:  %q{Extends Sinatra with some convenience shortcuts.},
      author:       %q{Jens Wille},
      email:        %q{jens.wille@gmail.com},
      license:      %q{AGPL-3.0},
      homepage:     :blackwinter,
      dependencies: { sinatra: '~> 1.4' },

      required_ruby_version: '>= 1.9.3'
    }
  }}
rescue LoadError => err
  warn "Please install the `hen' gem. (#{err})"
end
