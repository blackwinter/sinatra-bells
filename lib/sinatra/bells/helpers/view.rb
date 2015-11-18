# encoding: utf-8

#--
###############################################################################
#                                                                             #
# sinatra-bells -- Sinatra with some more bells and whistles                  #
#                                                                             #
# Copyright (C) 2014-2015 Jens Wille                                          #
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

    module View

      LABEL_FORMAT_RE = %r{
        \{
          ( \w+ )               # field
          (?: \( ( .*? ) \) )?  # separator
          (?: : ( .*? ) )?      # format string
        \}
      }x.freeze

      DEFAULT_FORMAT = '%s'.freeze

      DEFAULT_SEPARATOR = '; '.freeze

      HTML_ELEMENTS = %w[
        a abbr address area article aside audio b base bdi bdo blockquote body
        br button canvas caption cite code col colgroup command content datalist
        decorator del details dfn dialog div dl element em embed fieldset
        figcaption figure footer form h1 h2 h3 h4 h5 h6 head header hr html i
        iframe img input ins kbd keygen label legend li link main map mark math
        menu menuitem meta meter nav noscript object optgroup option output p
        param picture pre progress q rp rt ruby s samp script section select
        shadow small source span strong style sub summary sup svg table tbody td
        template textarea tfoot th thead time title tr track u var video wbr
      ].freeze

      LIST_ELEMENTS = %w[ol ul].freeze

      class << self

        def define_html_tag_method(*names)
          names.each { |name|
            class_eval <<-EOT, __FILE__, __LINE__ + 1
              def #{name}_(*args, &block)
                tag_(#{name.inspect}, *args, &block)
              end
            EOT
          }
        end

        def define_list_tag_method(*names)
          names.each { |name|
            class_eval <<-EOT, __FILE__, __LINE__ + 1
              def #{name}_(*args, &block)
                if args.first.respond_to?(:each)
                  raise ArgumentError, 'no block given' unless block

                  list, block_, block = args.shift, block, lambda { |tag|
                    list.each { |*item| tag << li_(*block_[*item]) }
                  }
                end

                tag_(#{name.inspect}, *args, &block)
              end
            EOT
          }
        end

      end

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

        a_(text, options.merge(href: href))
      end

      def link_to_if(condition, text, *args)
        condition ? link_to(text, *args) : block_given? ? yield(text, *args) : text
      end

      def tag_(name, *args)
        args.unshift('<', name, '>')

        if args.last.is_a?(Hash)
          attr = args.pop.map { |k, v| %Q{#{h(k)}="#{h(v)}"} }
          args.insert(2, ' ', attr.join(' ')) unless attr.empty?
        end

        yield args if block_given?

        args.push('</', name, '>').join
      end

      define_html_tag_method(*HTML_ELEMENTS)
      define_list_tag_method(*LIST_ELEMENTS)

      def active?(path)
        'active' if request.path_info =~ /\A#{Regexp.escape(path)}(?:\/|\?|\z)/
      end

      def disabled?(condition)
        'disabled' unless condition
      end

      def format_label(label, hash = nil, &block)
        hash ||= block

        label.gsub(LABEL_FORMAT_RE) {
          field, separator, format =
            $1, $2 || DEFAULT_SEPARATOR, $3 || DEFAULT_FORMAT

          value = Array(hash[field]).map(&:to_s).delete_if(&:empty?)
          format % [value.join(separator), field] unless value.empty?
        }
      end

    end

  end

end
