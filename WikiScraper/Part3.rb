# nokogiri is our scraping/parsing library
require 'nokogiri'
# open-uri is part of the standard library and allows you to download a webpage
require 'open-uri'
require 'csv'

$redirect_url =""
$results_3 = ""

class Part3
	def main (role_type)
		root_url = "http://en.wikipedia.org"
		# to set the root url for academy award winners 
		url = "#{root_url}" + "/wiki/Portal:Academy_Award"

		# Here we load the URL into Nokogiri for parsing the page in the process
		url_data = Nokogiri::HTML(open(url))

		# to extract required data based on table styling
		url_data_css = url_data.css("div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table tr td div div table tr td span.nowrap a")

		# puts url_data_css.text.gsub(/[^0-9A-Za-z\s.]/, '')

		$redirect_url = "No data"

		url_data_css.each do |val|
			# to remove special characters 
			temp = val.text.gsub(/[^0-9A-Za-z\s.]/, '')
			if temp.eql? "Best Leading Actor"
				best_leading_actor = val
				# setting redirect url for the required tab
				$redirect_url = "#{root_url}" + best_leading_actor["href"]
			end
		end
		best_actors (role_type)
	end

	def best_actors (role_type)
		# puts @redirect_url

		# check if required category is not found
		if $redirect_url.eql? "No data"
			puts "Best Leading Actor Not Found"
		else
			redirect_url_data = Nokogiri::HTML(open($redirect_url))
			# extract data based on the styling of table 
			best_actor_table = redirect_url_data.css("div#content.mw-body div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table.wikitable[cellpadding='4']")[0]
			
			# puts best_actor_table_array.length

			$actor_array = Array.new

			# removing row containing table headers 
			best_actor_table.css("tr")[1..-1].each do |row|
				# best_actor_table_array = row.map {|element| element.text}.collect {|arr_val| arr_val.strip} 
				# puts row
				# temp variable for proper traversal
				index = 0
				row.css("td").each do |column|
					if (index == 0)
						$actor = column.text
					elsif (index == 2)
						# extracting role name from 2 column in the table
						roles_array = column.text.split("\n")
						# puts roles_array.class
						# puts roles_array.class
						roles_array.each do |role|
							# asssuming role played is included in role name # no problem for substrings since check with 'K'ing
							if role.include? role_type
								$actor_array.push($actor)
							end
						end
					end
					index += 1
				end
			end
			# displaying unique list of actors who played role of king
			$results_3 += $actor_array.uniq*","
			puts $actor_array.uniq
		end
	end
end

part3 = Part3.new()
part3.main("King")
