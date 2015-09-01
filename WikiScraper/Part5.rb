# nokogiri is our scraping/parsing library
require 'nokogiri'
# open-uri is part of the standard library and allows you to download a webpage
require 'open-uri'
require 'csv'

$redirect_url = ""
$results_5 = ""
$test_director_data = ""

class Part5
	def main (num)
		root_url = "http://en.wikipedia.org"
		# storing root url for award academy portal 
		url = "#{root_url}" + "/wiki/Portal:Academy_Award"

		# Here we load the URL into Nokogiri for parsing the page in the process
		url_data = Nokogiri::HTML(open(url))
		# extracting table based on styling
		url_data_css = url_data.css("div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table tr td div div table tr td span.nowrap a")

		# puts url_data_css.text.gsub(/[^0-9A-Za-z\s.]/, '')

		$redirect_url = "No match"

		url_data_css.each do |val|
			# removing special character to get exact match 
			temp = val.text.gsub(/[^0-9A-Za-z\s.]/, '')
			if temp.eql? "Best Director"
				best_director = val
				# extracting url for redirecting to best director page
				$redirect_url = "#{root_url}" + best_director["href"]
			end
		end
		best_directors (num)
	end

	def best_directors (num)
		# puts @redirect_url
		if $redirect_url.eql? "No match"
			# check if Best director is not found
			puts "Best Director Not Found"
		else
			redirect_url_data = Nokogiri::HTML(open($redirect_url))
			# extracting required table for best director
			main_table = redirect_url_data.css("div#content.mw-body div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table.wikitable")

			# puts main_table.length

			# to store count of nominations for each director # initializing the values to 0
			hash_dir_count = Hash.new(0)
			# to maintain the list of movies for which the director was nominated
			hash_dir_movies = Hash.new{|hash, key| hash[key] = Array.new}

			main_table.each do |table|
				table.css("tr").each do |row|
					# initializing temp variable to traverse through the table
					index = 0
					row.css("td").each do |column|
						index += 1
						# on the required index id
						if index == 2 
							# extracting director name and movie that won 
							actor_movie = column.text.split("–").collect {|arr_val| arr_val.strip} 
							actor = actor_movie[0].delete!("\n")
							movie = actor_movie[1]
							# puts actor_movie[1]
							# updating count for the required director by 1 on match # adds new key (director) if not exist
							hash_dir_count[actor] = hash_dir_count[actor] + 1 
							# adding the current movie under the director
							hash_dir_movies[actor].push(movie)
						elsif index == 3
							# extracting director name and movies nominated
							# puts column.class
							# spliting based on special character to distinguish between director and movie
							column.text.split("\n").each do |pair|
								# puts pair.class
								actor_movie = pair.split("–").collect {|arr_val| arr_val.strip} 
								if actor_movie.length != 2
									actor_movie = pair.split("-").collect {|arr_val| arr_val.strip} 
								end 
								actor = actor_movie[0]
								movie = actor_movie[1]
								# updating count for the required director by 1 on match # adds new key (director) if not exist
								hash_dir_count[actor] = hash_dir_count[actor] + 1
								# adding the current movie under the director
								hash_dir_movies[actor].push(movie)
								# puts actor_movie[0]
								# puts actor_movie[1]
							end 
							# puts column.text
						end
					end
				end
				# break
			end
			# to traverse through the hash
			hash_dir_movies.each do |actor , movie|
				# if the count for the current director is greater than 4 display movie
				$test_director_data +=  actor + ":" + hash_dir_count[actor].to_s + ";"
				if (hash_dir_count[actor] >= num)
					# index += 1
					$results_5 += actor + ":" + movie*";" + "		"
					puts "#{actor}-----"
					puts "		#{movie}"
				end
			end	
			# puts "Total no of directors #{index}"
		end
	end
end

part5 = Part5.new()
part5.main(4)
# puts $results_5
# puts $test_director_data