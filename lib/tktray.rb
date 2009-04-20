require 'tk'
require 'tkextlib/tile.rb'

TkPackage.require('tktray')

#Tk.__set_toplevel_aliases__(:Ttk, Tk::Tile::TkTrayIcon, :TkTrayIcon)

class Tk::Tile::TkTrayIcon < Tk::Button
  include Tk::Tile::TileWidget

  TkCommandNames = ['tktray::icon'.freeze].freeze
  
  def command cmd = nil, &b
    super
  end

  def bounding_box
    tk_send('bbox')
  end

#  def image
#  end
#
#  def image=(img)
#    set 'image', img
#  end

#  def set(val)
#    tk_send('set', val)
#  end

  private
    def __boolval_optkeys
      super() << 'exportselection'
    end

    def __listval_optkeys
      super() << 'values'
    end
end

Tk::Tile::TkTrayIcon.new
