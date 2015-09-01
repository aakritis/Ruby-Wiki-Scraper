# nokogiri is our scraping/parsing library
require 'nokogiri'
# open-uri is part of the standard library and allows you to download a webpage
require 'open-uri'
require 'csv'

$hash_country_url = Hash.new()
$country_list = ""
$results_6 = ""

class Part6
	def main
		root_url = "http://en.wikipedia.org"
		# accessing root url from awards portal
		url = "#{root_url}" + "/wiki/Portal:Academy_Award"

		# Here we load the URL into Nokogiri for parsing the page in the process
		url_data = Nokogiri::HTML(open(url))
		# extracting data based on table styling
		url_data_css = url_data.css("div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table tr td div div table tr td span.nowrap a")

		# puts url_data_css.text.gsub(/[^0-9A-Za-z\s.]/, '')

		# Best Foreign Language Film
		url_data_css.each do |val|
			# removing special characters to get exact match
			temp = val.text.gsub(/[^0-9A-Za-z\s.]/, '')
			if temp.eql? "Best Foreign Language Film"
				best_leading_actor = val
				# storing link for foreign language film
				url_official_link = "#{root_url}" + best_leading_actor["href"] # URL for Best Foreign Language Films 
				# iterating to 2nd HTML page 
				url_official_link_data = Nokogiri::HTML(open(url_official_link))
				# url_official_link_css = url_official_link_data.css("div#content.mw-body div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr div.hatnote.relarticle.mainarticle a")
				url_official_link_css = url_official_link_data.css("div#content.mw-body div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr ul li a")
				url_official_link_css.each do |val|
					# extracting url containing count of movies based on countries
					temp = val.text.gsub(/[^0-9A-Za-z\s.]/, '')
					if temp.eql? "List of countries by number of Academy Awards for Best Foreign Language Film"
						countries_list = val
						# setting url for redirecting to country based listing page
						$countries_url = "#{root_url}" + countries_list["href"]
						# puts countries_url
					end
				end
			end
		end
		best_country (root_url)
	end

	def best_country (root_url)
		# iterating to 3rd HTML page 
		countries_data = Nokogiri::HTML(open($countries_url))
		# puts countries_data
		countries_css = countries_data.css("div#content.mw-body div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table.wikitable tr td")

		# puts length_node_set

		# temp variable to traverse through movie listing based on countries 
		index = 0 
		# creating hash to store how many nominated movies based on countries
		hash_country_count = Hash.new(0)
		# storing redirect url for each country
		# setting value for iteration based on the country listing
		until index >= 580 do
			# extracting country name from href tag
			required_tag = countries_css[index].css("a")[1]
			# puts countries_css[index].css("a")[1].text
			country_name = required_tag.text
			# puts country_name
			country_href = required_tag["href"]
			# puts country_href
			# moving to index by 2 to reach nominations column
			update = index + 2
			# removing special characters appended in the count
			count = countries_css[update].text.gsub(/[^0-9]/, '')
			# puts count
			# store value of count of nominations and hrefs in hashes
			hash_country_count[country_name] = count.to_i
			$hash_country_url[country_name] = country_href
			index += 5
			# puts index
		end
		# accessing value that is maximum in created hash
		max_count = hash_country_count.values.max
		# extracting country with highesh no of nominations
		max_country = hash_country_count.select { |key,value| value == max_count }.keys
		$country_list = hash_country_count.select { |key,value| value == max_count }.keys*","
		get_movies(root_url,max_country)
	end

	def get_movies (root_url,max_country)
		# redirecting to required country url
		redirect_url = "#{root_url}" + $hash_country_url[max_country[0]]
		redirect_url_data = Nokogiri::HTML(open(redirect_url))
		# extracting required table based on styling
		redirect_url_css = redirect_url_data.css("div#content.mw-body div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table.wikitable tr td")

		# extracting length of required table for traversal
		length_node_set = redirect_url_css.length

		# temp variable for traversing through table 
		index_data = 0

		# display on console
		puts "#{max_country[0]} --------------------------"

		until index_data >= length_node_set do
			# checking index to know whether the movie was nominated or not
			result_index = index_data + 4
			if redirect_url_css[result_index].text.eql? "Not Nominated"
			else
				movie_index = index_data + 2
				# extracting nominated movies and displaying in console
				$results_6 +=  redirect_url_css[movie_index].text + ";"
				puts "		#{redirect_url_css[movie_index].text}"
			end
			index_data += 5
		end 
	end
end


part6 = Part6.new()
part6.main