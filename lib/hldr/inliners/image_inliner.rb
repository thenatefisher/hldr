require 'base64'
require 'hldr/inliners/inliner'

class ImageInliner < Inliner
    def ImageInliner.embed(element)

        # try to retrieve content
        content = getContent(element[:src])
        return if content[:data].nil?

        # create embedded data uri 
        data = "data:#{content[:type]};base64,"
        data += Base64::encode64(content[:data])

        # embed content
        element[:src] = data

    end 
end
