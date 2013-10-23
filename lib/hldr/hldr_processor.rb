require 'nokogiri'
require 'yaml'
require 'hldr/inliners/script_inliner'
require 'hldr/inliners/image_inliner'
require 'hldr/inliners/style_inliner'

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

    def add_scaffolding

        hldr_config = YAML.load_file('.hldrconfig')
        hldr_config["scaffolding"].each do |resource|

            # if ends in .css or is a hash with value of css, add style
            if resource[-4..-1] == ".css"
                
                css_res = Nokogiri::XML::Node.new "style", @doc
                css_res.content = open(resource).read
                css_res[:type] = "text/css"

                head = @doc.at_css("html") 
                head << css_res
                
            end

        end 

    end

    def inline_assets

        inliners = {
            :link   => StyleInliner, 
            :script => ScriptInliner
        }

        # inhibit embedding images if flag set
        if @options[:no_embed]
            inliners[:img] = ImageInliner
        end

        inliners.each do |tag, inliner|

            @doc.css(tag.to_s).each do |element| 
                inliner::embed(element) 
            end

        end

        

    end

    # creates a cache location
    def HldrProcessor.generate_cache
        Dir::mkdir ".hldr" if !Dir::exist? ".hldr"
    end

    # creates a new config file
    def HldrProcessor.generate_config
        File::open ".hldrconfig", "w" if !File::exist? ".hldrconfig"
    end

end
