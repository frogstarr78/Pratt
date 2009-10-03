# -*- ruby -*-

$LOAD_PATH << '.'
$LOAD_PATH << 'lib'
require 'pratt'
require 'spec'

Hoe.spec('pratt') do |p|
  p.rubyforge_name = 'pratt' # if different than lowercase project name
  p.developer('michael goff, scott noel-hemming', 'devs@example.com')
end

task :default => [:test] 
#task :default => [:spec] 

Pratt.connect( ENV['env'] || 'development' )

desc "connect to database"
task :console do 
  require 'ruby-debug'
  libs =  " -r irb/completion"
  libs << " -r lib/pratt"
  libs << " -r ruby-debug"
  exec "irb #{libs} --simple-prompt"
end

desc "DB Quick access"
namespace :db do

  desc "Show App detail."
  task :app do 
    puts App.last.inspect
  end

  desc "Show Last Whence log."
  task :last do
    last = Whence.last_unended || Whence.last
    puts last.inspect
  end
end

namespace :spec do
  desc "Spec testing"
  Spec::Rake::SpecTask.new(:rcov) do |t|
    t.spec_opts  = ["--options", "'./spec/spec.opts'"]
    t.spec_files = FileList['spec/*_spec.rb']
    t.rcov       = true
    t.rcov_opts = lambda do
      IO.readlines("./spec/rcov.opts").map {|l| l.chomp.split ' ' }.flatten
    end
  end
end

# vim: syntax=Ruby
