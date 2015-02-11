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

require_relative 'helpers/controller'
require_relative 'helpers/view'

class Sinatra::Bells
  helpers ERB::Util, *Helpers.constants.map { |mod| Helpers.const_get(mod) }
end
