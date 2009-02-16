# -*- ruby -*-

$LOAD_PATH << '.'
$LOAD_PATH << 'lib'
require 'config'
require 'pratt'

Hoe.new('pratt', Pratt::VERSION) do |p|
  p.rubyforge_name = 'pratt' # if different than lowercase project name
  p.developer('michael goff, scott noel-hemming', 'devs@example.com')
end

task :default => [:test] 

task :console do 
  require 'ruby-debug'
  libs =  " -r irb/completion"
  libs << " -r lib/pratt"
  libs << " -r ruby-debug"
  exec "irb #{libs} --simple-prompt"
end

desc "Database migrations"
namespace "migrate" do
  desc "Set up tables"
  task :up do
    PrattConfig.models do |model|
      model.migrate
    end
  end

  desc "Tear down tables"
  task :down do
    PrattConfig.models do |model|
      model.migrate false
    end
  end
end

# vim: syntax=Ruby
