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
    hldr index.md > flat.html

Commands: 
    update      Updates external content in the config file and stores to cache
    init        Creates a config file
    new NAME    Creates a new document folder, empty contents and a config file

Options:

EOS

  opt :no_embed, "Inhibits base64 data URI image embedding", :default => true

end

hldr_cmd = ARGV.shift 
case hldr_cmd
  when "update" 
        # update cache from config file
  when "init"
        # create config file
        HldrProcessor::generate_config
        HldrProcessor::generate_cache
  when "new"  
    if ARGV.first.nil?
        puts "Name of document required for NEW command."
    else
        # create project folder
    end
  else
    # no subcommand entered
    if hldr_cmd.nil? 
        Trollop::die "No input given."
    else
        # Processing file
        puts HldrProcessor.new(hldr_cmd, hldr_opts).to_s
    end
  end