# -*- ruby -*-

$LOAD_PATH << '.'
$LOAD_PATH << 'lib'
require 'pratt'
require 'spec'

Hoe.spec('pratt') do |p|
  p.rubyforge_name = 'pratt' # if different than lowercase project name
  p.developer('michael goff, scott noel-hemming', 'devs@example.com')
end

#task :default => [:test] 
task :default => [:spec] 

desc "connect to database"
task :console do 
  Pratt.connect( ENV['PRATT_ENV'] || 'development' )
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
	  Pratt.connect( ENV['PRATT_ENV'] || 'development' )
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

namespace :generate do
	desc "Genarate model"
	task :model do
	  raise "Missing required klass parameter" unless ENV.include?('klass')
    klass = ENV['klass'].downcase.singularize
		outdir = Pratt.root('models')
		template = ''
		Pratt.root('templates', 'model.eruby') {|model_gen| template = File.read(model_gen) }

		eruby = Erubis::Eruby.new(template)
		File.open(File.join(outdir, "#{klass}.rb"), 'w') {|file| file.write eruby.result(:klass => klass) }
	end
end

# vim: syntax=Ruby
