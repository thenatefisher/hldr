require 'nokogiri'
require 'yaml'
require 'hldr/inliners/script_inliner'
require 'hldr/inliners/image_inliner'
require 'hldr/inliners/style_inliner'
require 'hldr/hldr_globals'

class HldrProcessor

    def initialize(location, options)
        begin
            @doc = Nokogiri::HTML(open(location))
        rescue
            puts "Could not open input file '#{location}'"
            exit(1)
        end
            @options = options
    end

    def to_s

        ## add config file scaffolding
        add_scaffolding

        ## process inlining
        inline_assets
        
        return @doc.to_html

    end

    # inline resources specified in the ENV file
    def add_scaffolding

        # load yaml env file
        env_path = File::join(Dir::pwd, HLDR_ENV)

        return if !File::exists? env_path
        return if File.zero?(env_path)
        hldr_config = YAML.load_file(env_path)

        # ensure scaffolding section is defined
        return if !hldr_config || 
            hldr_config["scaffolding"].nil? || 
            hldr_config["scaffolding"].empty?

        hldr_config["scaffolding"].each do |resource|

            # if ends in .css or is a hash with value of css, add style
            if (resource[-4..-1] == ".css") || 
                (resource.is_a?(Hash) && resource[resource.keys.first] == "css")

                begin
                    css_res = Nokogiri::XML::Node.new "style", @doc
                    res_handler = open(resource)
                    next if !res_handler

                    css_res.content = res_handler.read
                    css_res[:type] = "text/css"
                    head = @doc.at_css("html") 
                    head << css_res if !head.nil?

                    res_handler.close
                rescue
                    next
                end
                
            end

            # if ends in .js or is a hash with value of js, add script
            if (resource[-4..-1] == ".js") || 
                (resource.is_a?(Hash) && resource[resource.keys.first] == "js")

                begin
                    css_res = Nokogiri::XML::Node.new "script", @doc
                    res_handler = open(resource)
                    next if !res_handler

                    css_res.content = res_handler.read
                    css_res[:type] = "text/javascript"
                    head = @doc.at_css("html") 
                    head << css_res if !head.nil?

                    res_handler.close
                rescue
                    next
                end
                
            end

        end 

    end

    # copy all asset content directly into the original document
    def inline_assets

        inliners = {
            :link   => StyleInliner, 
            :script => ScriptInliner
        }

        # inhibit embedding images if flag set
        if @options[:images]
            inliners[:img] = ImageInliner
        end

        inliners.each do |tag, inliner|

            @doc.css(tag.to_s).each do |element| 
                inliner::embed(element) 
            end

        end

    end

    # creates a cache location (optionally in another path)
    def HldrProcessor.generate_cache(path=nil)
        # guard against bogus path
        return nil if (!path.nil? && !Dir::exist?(path))

        dir_path = File::join(Dir::pwd, HLDR_CACHE)
        dir_path = File::join(path, HLDR_CACHE) if path

        Dir::mkdir(dir_path) if !Dir::exist? dir_path
    end

    # creates a new config file (optionally in another path)
    def HldrProcessor.generate_env(path=nil)
        # guard against bogus path
        return nil if (!path.nil? && !Dir::exist?(path))

        env_path = File::join(Dir::pwd, HLDR_ENV)
        env_path = File::join(path, HLDR_ENV) if path

        if !File::exist? env_path
            env_file = File::open(env_path, "w") 
            env_file.write("scaffolding:\n")
            env_file.close
        end

    end

end
