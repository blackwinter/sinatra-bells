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

require 'cgi'

class Sinatra::Bells

  module Helpers

    module HTML

      protected

      def link_to(text, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}

        href = uri(args.join('/'))

        if params = options.delete(:params)
          href << '?' << Array(params).flat_map { |key, value|
            key = CGI.escape(key.to_s)

            value.nil? ? key : Array(value)
              .map { |val| "#{key}=#{CGI.escape(val.to_s)}" }
          }.join('&')
        end

        if anchor = options.delete(:anchor)
          href << '#' << CGI.escape(anchor.to_s)
        end

        _a(text, options.merge(href: href))
      end

      def link_to_if(condition, text, *args)
        condition ? link_to(text, *args) : block_given? ? yield(text, *args) : text
      end

      def _tag(name, *args)
        args.unshift('<', name, '>')

        if args.last.is_a?(Hash)
          attr = args.pop.map { |k, v| %Q{#{h(k)}="#{h(v)}"} }
          args.insert(2, ' ', attr.join(' ')) unless attr.empty?
        end

        yield args if block_given?

        args.push('</', name, '>').join
      end

      def _a(*args)
        _tag(:a, *args)
      end

      def _li(*args)
        _tag(:li, *args)
      end

      def _ul(list, *args)
        _tag(:ul, *args) { |tag| list.each { |*item| tag << yield(*item) } }
      end

      def active?(path)
        'active' if request.path_info =~ /\A#{Regexp.escape(path)}(?:\/|\?|\z)/
      end

      def disabled?(condition)
        'disabled' unless condition
      end

    end

  end

end
