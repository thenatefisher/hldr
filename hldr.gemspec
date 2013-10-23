require './lib/hldr/hldr_globals'

Gem::Specification.new do |s|
  s.name        = 'hldr'
  s.version     = HLDR_VERSION
  s.date        = '2013-10-22'
  s.summary     = "Generate a flat HTML file from linked assets"
  s.description = "Hldr is a utility to compile all linked assets from an html document into a single file, rendered to STDOUT. The point is to allow content creators to more easily use powerful interactive frameworks within their document. "
  s.authors     = ["Nate Fisher"]
  s.email       = 'nate.scott.fisher@gmail.com'
  s.files       = Dir["{bin,lib,test}/**/*", "*.md", "Rakefile"].reject { |f| File.directory?(f) }
  s.homepage    = 'http://github.com/thenatefisher/hldr'
  s.license     = 'MIT'

  s.add_runtime_dependency "nokogiri", "~> 1.6"
  
  s.executables << 'hldr'

end