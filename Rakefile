require "rubygems"
require "rake/gempackagetask"
require "rake/rdoctask"

task :default => :test

require "rake/testtask"
Rake::TestTask.new do |t|
  t.libs = [File.expand_path("lib"), "test"]
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end

# This builds the actual gem. For details of what all these options
# mean, and other ones you can add, check the documentation here:
#
#   http://rubygems.org/read/chapter/20
#
spec = Gem::Specification.new do |s|

  # Change these as appropriate
  s.name              = "flatbed"
  s.version           = "0.0.1"
  s.summary           = "A ruby library for video editing and assembly using ffmpeg"
  s.author            = "Marcus Rosentrater"
  s.email             = "marcus.rosentrater@gmail.com"
  s.homepage          = "http://github.com/meanmarcus/flatbed"

  s.has_rdoc          = false
  # s.extra_rdoc_files  = %w(Readme.markdown)
  # s.rdoc_options      = %w(--main Readme.markdown)

  # Add any extra files to include in the gem
  s.files             = %w(Rakefile README.markdown flatbed.rb) + Dir.glob("{lib}/**/*")
  # s.executables       = FileList["bin/**"].map { |f| File.basename(f) }
  s.require_paths     = ["lib"]

  # If you want to depend on other gems, add them here, along with any
  # relevant versions
  # s.add_dependency("some_other_gem", "~> 0.1.0")

  # If your tests use any gems, include them here
  # s.add_development_dependency("shoulda")
  # s.add_development_dependency("rspec")
  # s.add_development_dependency("cucumber")

  # If you want to publish automatically to rubyforge, you'll may need
  # to tweak this, and the publishing task below too.
  # s.rubyforge_project = "gem-this"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3")
end

# This task actually builds the gem. We also regenerate a static
# .gemspec file, which is useful if something (i.e. GitHub) will
# be automatically building a gem for this project. If you're not
# using GitHub, edit as appropriate.
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "Build the gemspec file #{spec.name}.gemspec"
task :gemspec do
  file = File.dirname(__FILE__) + "/#{spec.name}.gemspec"
  File.open(file, "w") {|f| f << spec.to_ruby }
end

task :package => :gemspec

# Generate documentation
Rake::RDocTask.new do |rd|
  rd.main = "Readme.markdown"
  rd.rdoc_files.include("Readme.markdown", "lib/**/*.rb")
  rd.rdoc_dir = "rdoc"
end

desc 'Clear out RDoc and generated packages'
task :clean => [:clobber_rdoc, :clobber_package] do
  rm "#{spec.name}.gemspec"
end