#!/usr/bin/ruby
require 'tk'
require 'tkextlib/tile'

class Pratt
  class Pop2 < Tk::Toplevel
    attr_reader :project


    def initialize project
      super nil, :title => 'Pratt Reminder', :width => 500

#      @project = project 
      $project = project

      build
    end

    cleanup = proc {
#      self.unlock
      exit
    }
    yes = proc {
#      self.when_to = Time.now
#      self.restart
      cleanup.call
    }
    adjust = proc {
#      self.when_to = Time.now
#      self.end
#      self.unlock
#      self.gui
#      # TODO: Clean up the slop
      cleanup.call
    }


    def show
      Tk.mainloop if Tk.has_mainwindow?
      puts self.state
    end

    private
      def build
        frm = Tk::Tile::Frame.new(self) { padding "5 5 5 5" }
        top_frm = Tk::Tile::Frame.new(frm) { padding "5 5 5 5" }

        Tk::Tile::Label.new(top_frm) do
          text "Have you been working on: "
        end.pack(:side => 'top', :fill => 'y')

        Tk::Tile::Label.new(top_frm) do
          text $project.name
        end.pack(:side => 'top', :fill => 'y')

        Tk::Tile::Label.new(top_frm) do
          text "started:
          #{$project.whences.last_unended.start_at}
        total time:
          #{Pratt.totals($project.time_spent)}."
        end.pack(:side => 'bottom', :fill => 'y')

        botm_frm = Tk::Tile::Frame.new(frm) { padding "5 5 5 5" }
        TkButton.new(botm_frm) do
          text "Yes"
          command &:yes
          underline 0
        end.pack('side' => 'left', :fill => 'y')
        self.bind("Alt-y", &:yes)

        TkButton.new(botm_frm) do
          text "Adjust"
          command &:adjust
          underline 0
        end.pack('side' => 'right', :fill => 'y')
        self.bind("Alt-a", &:adjust)

        top_frm.pack( :side => 'top',    :fill => 'y')
        botm_frm.pack(:side => 'bottom', :fill => 'y')
        frm.pack(     :side => 'top',    :fill => 'y')
      end
  end
end

#Tk.mainloop
