# -*- ruby -*-

require 'rubygems'
require 'rake'
require 'lib/pratt'
require 'tasks/pratt'

task :default => :spec

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
	gem.rubyforge_project = Pratt::NAME
    gem.name = Pratt::NAME
    gem.summary = Pratt::SUMMARY
    gem.description = Pratt::DESCRIPTION
    gem.email = "frogstarr78@gmail.com"
    gem.homepage = "http://github.com/frogstarr78/pratt"
    gem.authors = Pratt::AUTHORS
    gem.add_development_dependency 'rspec', '>=1.2.6'
    gem.add_development_dependency 'mocha', '>=0.9.5'
    gem.add_runtime_dependency 'activerecord', '>=2.1.1'
    gem.add_runtime_dependency 'sqlite3-ruby', '>=1.2.4'
    gem.add_runtime_dependency 'shifty_week', '>=0.1.0'
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
  Jeweler::RubyforgeTasks.new do |rubyforge|
	rubyforge.doc_task = "rdoc"
  end
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
  require 'reek/adapters/rake_task'
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

# vim: syntax=ruby
