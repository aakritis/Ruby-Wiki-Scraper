# nokogiri is our scraping/parsing library
require 'nokogiri'
# open-uri is part of the standard library and allows you to download a webpage
require 'open-uri'
require 'csv'

$results_1 = ""

class Part1
	def main (production_house)
		root_url = "http://en.wikipedia.org"

		# storing root url for the academy award portal 
		url = "#{root_url}" + "/wiki/Portal:Academy_Award"

		# Here we load the URL into Nokogiri for parsing the page in the process
		url_data = Nokogiri::HTML(open(url))

		# Targeting data in the page using css selectors. The at_css method returns the first element that matches the selector.
		best_movies_link = url_data.at_css("div#content.mw-body div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table tr td div div table tr td a")

		redirect_url = "#{root_url}" + best_movies_link["href"]
		get_best_movies(redirect_url,production_house)
	end

	def get_best_movies (redirect_url,production_house)
		# loading URL into Nokogiri for parsing the required page
		redirect_url_data = Nokogiri::HTML(open(redirect_url))


		# css method returns all the occurences that matches the selector
		best_movies_table = redirect_url_data.css("div#content.mw-body div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table.wikitable tr td")

		# extract the size of node set created from the above html occurences 
		length_node_set = best_movies_table.length 

		# temp variable to traverse through the loop
		index = 0

		until index >= length_node_set do
			#puts "Inside the Loop for index = #{index}"

			#array_productions.each do |val|
			#	puts val
			#end

			# extract production company(s) for current index
			production_company = CSV.parse_line(best_movies_table[index+1].text.strip).collect {|arr_val| arr_val.strip} 

		  if production_company.include? production_house
				movie_name = best_movies_table[index].at_css("i").at_css("a").text.strip
				$results_1 += movie_name + ";"
				puts movie_name
			end 
			index += 3
		end 
	end
end

p1 = Part1.new()
p1.main("Disney")