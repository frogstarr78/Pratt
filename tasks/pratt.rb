# -*- ruby -*-

namespace :pratt do 

  task :establish_connection do
    Pratt.connect!( ENV['PRATT_ENV'] || 'development' )
    Pratt.root 'models', '*.rb' do |model|
      require model
    end
  end

  desc "DB Quick access"
  namespace :db do

    desc "Show App detail."
    task :app => :establish_connection do 
      puts App.last.inspect
    end

    namespace :schema do
      desc "Run schema file" 
      task :run => :establish_connection do
        raise "Missing required file argument" unless ENV.include? 'file'
        schema_change = File.open( ENV['file'] ).read

        ActiveRecord::Schema.define do
          ActiveRecord::Base.transaction do
            begin
              eval schema_change
            rescue Exception => e
              puts "There was an error:
              #{e.inspect}.
              Rolling back!"
              raise ActiveRecord::Rollback
            end
          end
        end
      end
    end
  end

  namespace :generate do
    desc "Genarate model"
    task :model do
      raise "Missing required klass parameter" unless ENV.include? 'klass'
      klass = ENV['klass'].downcase.singularize
      outfile = File.join(Pratt.root('models'), "#{klass}.rb")
      template = ''
      Pratt.root('templates', 'model.eruby') {|model_gen| template = File.read(model_gen) }

      eruby = Erubis::Eruby.new(template)
      unless File.exists? outfile
        File.open(outfile, 'w') {|file| file.write eruby.result(:klass => klass) }
      else
        puts "Model '#{klass}' already exists"
      end

      Rake::Task["generate:spec"].execute
    end

    desc "Generate spec test"
    task :spec do
      klass = ENV['klass'].downcase.singularize
      raise "Missing required klass parameter" unless ENV.include? 'klass'

      outpath = File.join(Pratt.root('spec'),      "#{klass}_spec.rb")
      inpath  = File.join(Pratt.root('templates'), "spec.eruby")

      if File.exists? outpath
        puts "Spec '#{klass}' already exists"
      else
        File.open outpath, 'w' do |outfile|
          File.open inpath do |infile|
            eruby = Erubis::Eruby.new( infile.read )
            outfile.write eruby.result( :klass => klass )
          end
        end
      end
    end
  end

end

# vim: syntax=Ruby
