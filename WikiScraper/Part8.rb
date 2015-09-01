# nokogiri is our scraping/parsing library
require 'nokogiri'
# open-uri is part of the standard library and allows you to download a webpage
require 'open-uri'
require 'csv'

$actress_url = ""
$support_actress_url = ""
$results_8 = ""

class Part8
	def main
		root_url = "http://en.wikipedia.org"
		# default root page for Awards Portal
		url = "#{root_url}" + "/wiki/Portal:Academy_Award"

		# Here we load the URL into Nokogiri for parsing the page in the process
		url_data = Nokogiri::HTML(open(url))
		# extract tables based on styling
		url_data_css = url_data.css("div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table tr td div div table tr td span.nowrap a")

		url_data_css.each do |val|
			temp = val.text.gsub(/[^0-9A-Za-z\s.]/, '')
			if temp.eql? "Best Leading Actress"
				best_actress = val
				# setting url to redirect to best actress page
				$actress_url = "#{root_url}" + best_actress["href"]
				puts $actress_url
			end
			if temp.eql? "Best Supporting Actress"
				best_support_actress = val
				# setting url to redirect to best supporting actress page
				$support_actress_url = "#{root_url}" + best_support_actress["href"]
				puts $support_actress_url
			end
		end
		get_list
	end

	def get_list 
		actress_data = Nokogiri::HTML(open($actress_url))
		# extract data from the required tables based on the style
		actress_table_css = actress_data.css("div#content.mw-body div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table.wikitable") 

		# hash to store data corresponding to actress and movie 
		hash_best_actress = Hash.new{|hash, key| hash[key] = Array.new}

		# traversing through the required tables 
		actress_table_css[0..9].each do |table|
			# puts table
			table.css("tr")[1..-1].each do |row|
				# puts row
				array_row_data = row.content.split("\n")
				# puts array_row_data
				# puts "============================================"
		    # storing actress name based on first href data in the row
		    if (array_row_data.length >= 4)
			    actress = row.at_css("a")
		  	  actress_name = array_row_data[1]
		  	  # puts actress_name
		    	# actress_film = array_row_data[2]
		    	# updating hash to store movies corresponding to actresses 
		    	array_movie = array_row_data[2].split("/").collect {|arr_val| arr_val.strip} 
		    	# puts array_movie	
		    	index = 0
					array_movie.each do |movie|
						# puts movie
						index = index + 1 
						# if (row.has_attribute? ("style"))
						if (index == 1)
							hash_best_actress[actress_name].push(movie)
						end
						if (index == 3)
							index = 0
						end
						# end
					end
					# puts hash_best_actress
		    	# puts "Actress-Name: #{actress_name}     Actress-Film: #{actress_film} "
		  	end
		  end
		end

		# puts hash_best_actress

		# extract data from the required tables based on the style
		support_actress_data = Nokogiri::HTML(open($support_actress_url))
		# extract data from the required tables based on the style
		support_actress_table_css = support_actress_data.css("div#content.mw-body div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table.wikitable") 

		# hash to store data corresponding to actress and movie 
		hash_best_support_actress = Hash.new{|hash, key| hash[key] = Array.new}

		# traversing through the required tables 
		support_actress_table_css[0..9].each do |table|
			table.css("tr")[1..-1].each do |row|
				array_row_data = row.content.split("\n")
				# puts array_row_data
		    # storing actress name based on first href data in the row
		    if (array_row_data.length == 4)
			    actress = row.at_css("a")
		  	  actress_name = array_row_data[1]
		    	# actress_film = array_row_data[2]
		    	# updating hash to store movies corresponding to actresses 
		    	array_movie = array_row_data[2].split("/").collect {|arr_val| arr_val.strip} 
					array_movie.each do |movie|
						if (row.has_attribute? ("style"))
							hash_best_support_actress[actress_name].push(movie)
						end
					end
		    	# puts "Actress-Name: #{actress_name}     Actress-Film: #{actress_film} "
		  	end
		  end
		end

		# puts hash_best_support_actress

		# traversing through one hash and checking if actress exists in second hash
		hash_best_actress.each do |actress , movies|
			if hash_best_support_actress.has_key? actress
				# displaying data on console
				$results_8 += actress + ";"
				puts "Actress : #{actress}"
				puts "		Best Actress Award For : #{movies} "
				puts "		Best Supporting Actress Award For : #{hash_best_support_actress[actress]} "
			end
		end
	end
end


part8 = Part8.new()
part8.main