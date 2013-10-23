require 'hldr/inliners/inliner'

class StyleInliner < Inliner
    def StyleInliner.embed(element)

        # try to retrieve content
        content = getContent(element[:href])
        return if content[:data].nil?

        # keep media and type; remove all other params
        whitelist = ["type", "media"]
        element.attributes.each do |key, val|
            if !whitelist.include?(key)
                element.attributes[key].remove
            end
        end

        # force rel type to style if null
        element[:type] = "text/css" if 
            element[:type].nil? || element[:type] == ""

        # rename tag to style
        element.name = "style"

        # embed content
        element.content = content[:data]

    end 
end
