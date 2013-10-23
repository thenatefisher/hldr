require 'open-uri'

class Inliner

    def Inliner.get_image_extension(local_file_path)
        # take from Alain Beauvois's post in
        # http://stackoverflow.com/questions/4600679/detect-mime-type-of-uploaded-file-in-ruby
        
        png = Regexp.new("\x89PNG".force_encoding("binary"))
        jpg = Regexp.new("\xff\xd8\xff\xe0\x00\x10JFIF".force_encoding("binary"))
        jpg2 = Regexp.new("\xff\xd8\xff\xe1(.*){2}Exif".force_encoding("binary"))

        case IO.read(local_file_path, 10)
        when /^GIF8/
            'image/gif'
        when /^#{png}/
            'image/png'
        when /^#{jpg}/
            'image/jpg'
        when /^#{jpg2}/
            'image/jpg'
        else
            mime_type = `file #{local_file_path} --mime-type`.gsub("\n", '') # Works on linux and mac
            raise UnprocessableEntity, "unknown file type" if !mime_type
            mime_type.split(':')[1].split('/')[1].gsub('x-', '').gsub(/jpeg/, 'jpg').gsub(/text/, 'txt').gsub(/x-/, '')
        end  

    end

    def Inliner.getContent(location)

        content = Hash.new

        begin
            if location[0..3] == "http"
                handler = open(location)
                return if !handler

                content[:data] = handler.read
                content[:type] = handler.meta["content-type"]
                handler.close
            else
                handler = File::open(location, "rb")
                return if !handler
                
                content[:data] = handler.read
                content[:type] = self.get_image_extension(location)
                handler.close
            end 
        rescue
        end

        return content

    end
end
