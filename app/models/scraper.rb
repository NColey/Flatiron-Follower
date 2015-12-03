class Scraper

	attr_accessor :url, :cohort_id 

	def initialize(url, cohort_id)
		@url = url
		@cohort_id = cohort_id
	end

	def noko_data
		noko_document = Nokogiri::HTML(open(url))
	end

	def get_student_data(selector)
		noko_data.css(selector)
	end

	def student_name_array
		get_student_data('div.blog-title h3 a').collect {|name_data| name_data.text}
	end

		
	def student_page_array
		students_name_array = get_student_data('div.blog-title h3 a').collect do |name_data|
			self.url + name_data['href']
		end
		
		#cleans out the broken links
		students_name_array.reject do |link|
	    link == "#{self.url}students/student_name.html" || link == "#{self.url}students/student_he.html"
	end

	  
	end

	def scrape_student_info
		student_page_array.each do |link|
		    profile_html = open(link)
		    profile_doc = Nokogiri::HTML(profile_html)
		    name = profile_doc.search('.ib_main_header').text

		    twitter = profile_doc.search('.social-icons a')[0].attr('href')[20..-1] if profile_doc.search('.social-icons a')[0]
		    github = profile_doc.search('.social-icons a')[2].attr('href')[19..-1] if profile_doc.search('.social-icons a')[2]
		    linkedin = profile_doc.search('.social-icons a')[1].attr('href') if profile_doc.search('.social-icons a')[1]
		    @student = Student.new(name: name, twitter_handle: twitter, github_handle: github, linkedin_url: linkedin, cohort_id: self.cohort_id)
		    @student.save(:validate=>false)
		end
	end

end
