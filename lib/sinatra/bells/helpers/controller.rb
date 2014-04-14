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

require 'json'

class Sinatra::Bells

  module Helpers

    module Controller

      protected

      def send_file(file, options = {})
        options.is_a?(Hash) ? super :
          File.readable?(file) ? super(file, type: options) : not_found
      end

      def render_json
        JSON.fast_generate(to_render_hash)
      end

      private

      def to_render_hash(hash = {}, compact = true)
        if hash.is_a?(Array)
          ary, hash, at = hash, {}, '@'

          ary.each { |key| hash[key] = instance_variable_get(
            (name = key.to_s).start_with?(at) ? name : "#{at}#{name}") }
        end

        compact ? hash.delete_if { |_, value| !value } : hash
      end

    end

  end

end
