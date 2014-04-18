#Hack to generalise call empty? on
#objects, arrays and hashes
class Object
	def empty?
		false
	end
end

module JsonResume
	class Formatter
    attr_reader :hash
    
		def initialize(hash, type)
      @hash = hash
      @output_type = type 

      #recursively defined proc
			@hash_proc = Proc.new do |k,v| 
                    v = k if v.nil? #hack to make it common for hash and array
										v.delete_if(&@hash_proc) if [Hash,Array].any? { |x| v.instance_of? x }
                    v.empty?
                  end
		end

    def add_padding(course)
      unless @hash["bio_data"][course].nil?
        course_hash = @hash["bio_data"][course]
        course_hash << { "name"=>"", "url"=>"" } if course_hash.size % 2 == 1 
        @hash["bio_data"][course] = {
          "rows" => course_hash.each_slice(2).to_a.map{ |i| { "columns" => i } }
        }
      end
		end

    def add_last_marker_on_stars
			@hash["bio_data"]["stars"] = {
        "items" => @hash["bio_data"]["stars"].map{ |i| { "name" => i } }
      }
			@hash["bio_data"]["stars"]["items"][-1]["last"] = true
    end

		def cleanse
			@hash.delete_if &@hash_proc
      self
    end

    def format_url
			format_proc = Proc.new do |k,v| 
                      v = k if v.nil?
                      v.each{|x| format_proc.call(x)} if [Hash,Array].any? {|x| v.instance_of? x}
                      if v.instance_of? String
                        self.send('format_link_for_' + @output_type, v)
                        self.send('format_autolink_for_' + @output_type, v)
                      end
                    end
      @hash.each{|x| format_proc.call(x)}
      self
    end

    def is_false? item
      item == false || item == 'false'
    end

    def purge_gpa
     @hash["bio_data"]["education"].delete("show_gpa") if is_false?(@hash["bio_data"]["education"]["show_gpa"]) || @hash["bio_data"]["education"]["schools"].all? {|sch| sch["gpa"].nil? || sch["gpa"].empty?} 
    end

		def format
      cleanse

      format_url #href

      #make odd listed courses to even
			["grad_courses", "undergrad_courses"].each { |course| add_padding(course) }

      add_last_marker_on_stars

      purge_gpa
      self
		end

    def format_link_for_html str
        str.gsub! /\[(.*?)\]{(.*?)}/, '<a href="\2">\1</a>'
    end

    def format_link_for_latex str
        str.gsub! /\[(.*?)\]{(.*?)}/, '{\color{see} \href{\2}{\1}}'
    end

    def format_autolink_for_html str
        str.gsub! /<<(\S*?)>>/, '<a href="\1">\1</a>'
    end

    def format_autolink_for_latex str
        str.gsub! /<<(\S*?)>>/, '{\color{see} \url{\1}}'
    end

	end
end    

