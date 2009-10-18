# -*- ruby -*-

require 'rubygems'
require 'rake'
require 'lib/pratt'
require 'tasks/pratt'

task :default => :spec

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = Pratt::NAME
    gem.summary = Pratt::SUMMARY
    gem.description = %Q{
	  Need a way to keep track of your time, but get caught up in work? Or constant interruptions?
	  Yeah you know who I'm talking about. Those people from the [abc] department always "NEEDING xyz FEATURE NOW!!!".
	  Seriously though. I'm usually just loose track of time. I wanted an app that I could start with a task I think 
	  I'll be working on, but that get's in my face constantly to ensure I'm still working on it. And if I'm not any longer,
	  provides an easy way of changing to another task, or if I have changed tasks and not already updated the app, would 
	  provide an easy way of changing the task of the previously recorded interval. That's what this is intended to do.

	  Time Tracking.
	  Proactively set what you expect to work on.
	  Reactively modify what you are no longer working on.
	}
    gem.email = "frogstarr78@gmail.com"
    gem.homepage = "http://github.com/frogstarr78/pratt"
    gem.authors = Pratt::AUTHORS
    gem.add_development_dependency "rspec"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

begin
  require 'reek/rake_task'
  Reek::RakeTask.new do |t|
    t.fail_on_error = true
    t.verbose = false
    t.source_files = 'lib/**/*.rb'
  end
rescue LoadError
  task :reek do
    abort "Reek is not available. In order to run reek, you must: sudo gem install reek"
  end
end

begin
  require 'roodi'
  require 'roodi_task'
  RoodiTask.new do |t|
    t.verbose = false
  end
rescue LoadError
  task :roodi do
    abort "Roodi is not available. In order to run roodi, you must: sudo gem install roodi"
  end
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "pratt #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

# vim: syntax=Ruby
