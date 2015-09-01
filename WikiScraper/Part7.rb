# nokogiri is our scraping/parsing library
require 'nokogiri'
# open-uri is part of the standard library and allows you to download a webpage
require 'open-uri'
require 'csv'

$redirect_url = ""
$root_url = ""
$results_7 = ""

class Part7
	def main (actor_name)
		$root_url = "http://en.wikipedia.org"
		# using url for the root url -- award portal 
		url = "#{$root_url}" + "/wiki/Portal:Academy_Award"

		# Here we load the URL into Nokogiri for parsing the page in the process
		url_data = Nokogiri::HTML(open(url))
		# extracting required table based on styling
		url_data_css = url_data.css("div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table tr td div div table tr td span.nowrap a")

		url_data_css.each do |val|
			temp = val.text.gsub(/[^0-9A-Za-z\s.]/, '')
			if temp.eql? "Best Animated Feature"
				best_animated_feature = val
				# extracting url for best animated feature
				$redirect_url = "#{$root_url}" + best_animated_feature["href"]
			end
		end
		get_movies(actor_name)
	end

	def get_movies (actor_name)
		# puts @redirect_url	
		puts $redirect_url
		redirect_data = Nokogiri::HTML(open($redirect_url))
		# extracting table based on styling
		main_table_css = redirect_data.css("div#content.mw-body div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table.wikitable") 
		# puts main_table_css
		# puts main_table_css.length

		main_table_css[0..1].each do |table|
			table.css("tr")[1..-1].each do |row|
				row.css("td")[1..-1].each do |column|
					# extrating movie column based on hyperlinks 
					column.css("i a").each do |movie|
						# extracting movie url to go the movie page 
						movie_url = "#{$root_url}" + "#{movie["href"]}"
						# puts movie_url
						actor_data = Nokogiri::HTML(open(movie_url))
						# extracting div containing major details for movies
						actor_css = actor_data.css("div#content.mw-body div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table.infobox.vevent tr")
						actor_css.css("th").each do |data|
							# checking whether the detail is related to starring
							if data.content.include? "Starring"
								actor_css.css("td li").each do |actor|
									# puts actor
									# check whether the actor list includes required actor
									if actor.content.include? actor_name
										$results_7 += movie.text + ";"
										puts movie.text
									end
								end
							end
						end
					end
				end
			end
		end 
	end
end

part7 = Part7.new()
part7.main("Tom Hanks")