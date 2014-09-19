# encoding: utf-8

#--
###############################################################################
#                                                                             #
# sinatra-bells -- Sinatra with some more bells and whistles                  #
#                                                                             #
# Copyright (C) 2014 Jens Wille                                               #
#                                                                             #
# Authors:                                                                    #
#     Jens Wille <jens.wille@gmail.com>                                       #
#                                                                             #
# sinatra-bells is free software; you can redistribute it and/or modify it    #
# under the terms of the GNU Affero General Public License as published by    #
# the Free Software Foundation; either version 3 of the License, or (at your  #
# option) any later version.                                                  #
#                                                                             #
# sinatra-bells is distributed in the hope that it will be useful, but        #
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY  #
# or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public      #
# License for more details.                                                   #
#                                                                             #
# You should have received a copy of the GNU Affero General Public License    #
# along with sinatra-bells. If not, see <http://www.gnu.org/licenses/>.       #
#                                                                             #
###############################################################################
#++

require 'sinatra/base'

module Sinatra

  class Bells < Sinatra::Base

    class << self

      def set(option, *args, &block)
        if block
          args[0] = lambda {
            value = instance_eval(&block)
            set(option, value)
            value
          }
        end

        super(option, *args, &nil)
      end

      def set_root(file)
        set(:root, file.chomp(File.extname(file)))
      end

      private

      def route(verb, path, options = {}, &block)
        return super unless render = options.delete(:render)

        if render.is_a?(Hash)
          template = render.delete(:html)
        else
          template, render = render, settings.default_render
        end

        blocks = {}

        type_paths(render, path) { |type_path, type, method|
          super(verb, type_path, options, &blocks[type] = lambda {
            content_type(type)
            instance_eval(&block)
            instance_eval(&method)
          })
        }

        super(verb, path, options.merge(provides: :html)) {
          instance_eval(&block)
          send(settings.default_renderer, template)
        }

        blocks.each { |type, type_block|
          super(verb, path, options.merge(provides: type), &type_block)
        }
      end

      def type_paths(render, path)
        path, re = path.source, path if path.is_a?(Regexp)
        anchor = $& if re && path.sub!(/\\z|\$/i, '')

        dot = '.' unless path.end_with?('/')
        dot = Regexp.escape(dot) if dot && re

        render.each { |type, method|
          type_path = "#{path}#{dot}#{type}#{anchor}"
          yield re ? Regexp.new(type_path, re.options) : type_path, type, method
        }
      end

    end

    set :default_render, {}

    set :default_renderer, :erb

    set settings.default_renderer, { content_type: 'application/xhtml+xml' }

  end

end

require_relative 'bells/version'
require_relative 'bells/helpers'
