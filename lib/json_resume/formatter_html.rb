require_relative 'formatter'

module JsonResume
 class FormatterHtml < Formatter
    def format_link! str
        str.gsub! /\[(.*?)\]{(.*?)}/, '<a href="\2">\1</a>'
    end

    def format_autolink! str
        str.gsub! /<<(\S*?)>>/, '<a href="\1">\1</a>'
    end
    
    def format_string! str
      format_link! str
      format_autolink! str
    end

    def add_padding(course)
      unless @hash["bio_data"].nil? || @hash["bio_data"][course].nil?
        course_hash = @hash["bio_data"][course]
        course_hash << { "name"=>"", "url"=>"" } if course_hash.size % 2 == 1 
        @hash["bio_data"][course] = {
          "rows" => course_hash.each_slice(2).to_a.map{ |i| { "columns" => i } }
        }
      end
		end
    
    def format
      super

      #make odd listed courses to even
			["grad_courses", "undergrad_courses"].each { |course| add_padding(course) }

      self
    end

 end
end

