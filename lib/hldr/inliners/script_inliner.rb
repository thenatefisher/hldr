require 'hldr/inliners/inliner'

class ScriptInliner < Inliner
    def ScriptInliner.embed(element)
        
        # ignore if content exists within tags
        return if element.content &&
            !element.content.strip.empty?

        # try to retrieve content
        content = getContent(element[:src])
        return if content[:data].nil?

        # remove src attribute
        element.attributes["src"].remove

        # force script type to javascript if null
        element[:type] = "text/javascript" if 
            element[:type].nil? || element[:type] == ""
        
        # embed content
        element.content = content[:data]

    end
end
