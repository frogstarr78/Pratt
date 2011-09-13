#!/usr/bin/ruby
DEFAULT_TK_ENCODING = __ENCODING__
require 'tk'
#Tk.encoding = __ENCODING__
require 'tkextlib/tile'

class Pratt
  class TkBase < Tk::Toplevel
    def button txt, args = {}, &block
      args = { 'side' => 'left', :fill => 'y' }.update args
      TkButton.new(self) do
        text txt
        command block
        underline 0
      end.pack args
    end

    def label txt, args = {}
      args = { :side => 'top', :fill => 'y' }.update args
      Tk::Tile::Label.new(self) do
        text txt
      end.pack args
    end

    def frame args = {}
      args = { :side => 'top', :fill => 'y' }.update args
      me = Tk::Tile::Frame.new(self) { padding "5 5 5 5" }
      me.instance_eval { yield }
      me.pack args
    end

  end

  class Pop2 < TkBase
    attr_accessor :project


    def initialize project
      super nil, :title => 'Pratt Reminder', :width => 500

      build project
    end


    def cleanup
#      self.unlock
      exit
    end

    def adjust
      puts 'here'
#      self.when_to = Time.now
#      self.end
#      self.unlock
#      self.gui
#      # TODO: Clean up the slop
      exit
#      cleanup
    end

    def yes
#      self.when_to = Time.now
#      self.restart
      exit
#      cleanup
    end

    def show
      if Tk.has_mainwindow?
        root = Tk::Root.new
        root.withdraw
        Tk.mainloop
      end
      puts self.state
    end

    private
      def build project
        frame do

          frame do
            label "Have you been working on: "
            label project.name
            label "started:
              #{project.whences.last_unended.start_at}
            total time:
              #{Pratt.totals(project.time_spent)}."
          end

          frame :side => 'bottom' do
            button 'Yes', :side => 'left' do
              exit
            end

            button 'Adjust', :side => 'right' do
              adjust
            end
          end
        end

        self.bind "Alt-y", &method(:yes)
        self.bind "Alt-a", &method(:adjust)
      end
  end
end

if $0 == __FILE__
  $: << '.'
  require 'lib/pratt'
  require 'config'

  Pratt.connect!
  view = Pratt::Pop2.new( Whence.last_unended.project )
  view.show
end
