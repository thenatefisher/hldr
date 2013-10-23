require 'trollop'
require 'hldr/hldr_processor'
require 'hldr/hldr_globals'

hldr_opts = Trollop::options do
  version "Hldr #{HLDR_VERSION} (c) 2013 Nate Fisher. \n\nThere can be only one!"
  banner <<-EOS
Hldr - Generate a flat HTML file from linked assets.

Usage:
    hldr [options] <file>
    hldr <command> [args]

Examples:
    hldr index.html > flat.html

Commands: 
    init        Creates a env file
    new NAME    Creates a new document folder, empty contents and a env file
    add         Add a package to environment
    rm          Remove a package from environment

Options:

EOS

  opt :images, "Embeds images as base64 in the data URI (allows you to embed images into the HTML file)", :default => true

end

hldr_cmd = ARGV.shift 
case hldr_cmd

  when "init"
        # create env and cache
        HldrProcessor::generate_env
        HldrProcessor::generate_cache

  when "add"
        # add stuff to env file

  when "rm"
        # remove stuff from env file   

  when "new"  
    if ARGV.first.nil?
        puts "Name of document required for NEW command."
    else
        # create project folder
        if !Dir::exist? ARGV.first
          if Dir::mkdir ARGV.first
            # create content file
            File::open File::join(ARGV.first, "#{ARGV.first}.html"), "w"
            # create env file and cache
            HldrProcessor::generate_env(ARGV.first)
            HldrProcessor::generate_cache(ARGV.first)
          end
        end
    end

  else
    if hldr_cmd.nil? 
        # no command entered
        Trollop::die "No input given"
    else
        # Processing file
        puts HldrProcessor.new(hldr_cmd, hldr_opts).to_s
    end

end

