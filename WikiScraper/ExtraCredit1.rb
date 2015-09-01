# nokogiri is our scraping/parsing library
require 'nokogiri'
# open-uri is part of the standard library and allows you to download a webpage
require 'open-uri'
require 'csv'

root_url = "http://en.wikipedia.org"

# setting default url to the root page
url = "#{root_url}" + "/wiki/Portal:Academy_Award"

# Here we load the URL into Nokogiri for parsing the page in the process
url_data = Nokogiri::HTML(open(url))
# extracting picture url 
picture_url_css = url_data.at_css("div#content.mw-body div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table tr td div div table tr td a")
# extract url for best picture
$picture_url = "#{root_url}" + picture_url_css["href"]

# puts @picture_url

# extract table based on css style 
url_data_css = url_data.css("div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table tr td div div table tr td span.nowrap a")

# puts url_data_css.text.gsub(/[^0-9A-Za-z\s.]/, '')
url_data_css.each do |val|
	temp = val.text.gsub(/[^0-9A-Za-z\s.]/, '')
	# extract url for best director
	if temp.eql? "Best Director"
		best_director = val
		$director_url = "#{root_url}" + best_director["href"]
	end
	# extract url for best actor
	if temp.eql? "Best Leading Actor"
		best_leading_actor = val
		$actor_url = "#{root_url}" + best_leading_actor["href"]
	end
	# extract url for best actress
	if temp.eql? "Best Leading Actress"
		best_leading_actress = val
		$actress_url = "#{root_url}" + best_leading_actress["href"]
	end
end

# create hash for best leading actress
actress_data = Nokogiri::HTML(open($actress_url))
# extract table based on css style 
actress_css = actress_data.css("div#content.mw-body div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table.wikitable") 
# storing array of movies for each year based on nominated actresses
hash_actress = Hash.new{|hash, key| hash[key] = Array.new}
# extract winners for best leading actress 
array_winner_actress = Array.new
actress_css.each do |table|
	table.css("tr")[1..-1].each do |row|
		array_row_data = row.content.split("\n")
		# extracting required key (year) from the table
		if (array_row_data.length == 3)
			$key = array_row_data[1]
			next
		end
		# based on structuring of table extracting movie names and dividing on / for multiple movies for a particular actress and year
		if (array_row_data.length == 4)
			array_movie = array_row_data[2].split("/").collect {|arr_val| arr_val.strip} 
			array_movie.each do |movie|
				hash_actress[$key].push(movie)
				# check if the current row represents winner for the current year
				if (row.has_attribute? ("style"))
					# puts "I am in Style Section"
					array_winner_actress.push(movie)
				end
			end
		end
	end
end
# puts hash_actress
# puts "------------------------------------------------------"
# puts array_winner_actress


# create hash for best leading actor
actor_data = Nokogiri::HTML(open($actor_url))
# extract table based on css style 
actor_css = actor_data.css("div#content.mw-body div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table.wikitable[cellpadding='4']")[0]
# hash to store array of movies for each year
hash_actor = Hash.new{|hash, key| hash[key] = Array.new}
# extract winners for best leading actor
array_winner_actor = Array.new
actor_css.css("tr")[1..-1].each do |row|
	# extracting table row header for the year 
	row.css("th").each do |header|
		$key = header.text.split("\n")[0]
		break
	end
	index = 0
	row.css("td").each do |column|
		index += 1
		if index == 2
			# split on \n for multiple movies listed in a td 
			array_movie = column.text.split("\n").collect {|arr_val| arr_val.strip} 
			array_movie.each do |movie|
				hash_actor[$key].push(movie)
				# check if the current row represents winner for the current year
				if (column.has_attribute? ("style"))
					# puts "I am in Style Section"
					array_winner_actor.push(movie)
				end
			end
		end 
	end
end
# puts hash_actor
# puts "------------------------------------------------------"
# puts array_winner_actor

# create hash for best director 
director_data = Nokogiri::HTML(open($director_url))
# extract table based on css style 
director_css = director_data.css("div#content.mw-body div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table.wikitable")
# store hash of arrays for each year with list of movies
hash_director = Hash.new{|hash, key| hash[key] = Array.new}
# extract winners from best directors 
array_winner_director = Array.new

director_css.each do |table|
	table.css("tr")[1..-1].each do |row|
		index = 0
		row.text.split("\n").each do |line|
			index += 1
			# index on each row where the years are listed
			if index == 2
				$key = line.split(" ")[0]
			# index on each row where the winners are listed and required split based on special character
			elsif index == 4
				hash_director[$key].push(line.gsub(/[^0-9A-Za-z\s\'\.]/, '').strip)
				# place winner of director in the array
				array_winner_director.push(line.gsub(/[^0-9A-Za-z\s]/, '').strip)
			# index on each row where the nominees are listed and required split based on special character
			elsif index > 4
				actor_movie = line.split("–").collect {|arr_val| arr_val.strip} 
				# print actor_movie.length
				if actor_movie.length != 2
					actor_movie = line.split("-").collect {|arr_val| arr_val.strip} 
				end 
				# puts actor_movie[1]
				hash_director[$key].push(actor_movie[1])
			end
		end
	end
end
# puts hash_director
# puts "------------------------------------------------------"
# puts array_winner_director

# create hash for best picrure
# puts @picture_url
picture_data = Nokogiri::HTML(open($picture_url))
# extract table based on css style 
picture_css = picture_data.css("div#content.mw-body div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table.wikitable")
# hash to store picture names year wise for nominations
hash_picture = Hash.new
# extract winners from best directors 
array_winner_picture = Array.new

index = 0 
year_array = Array.new
picture_css.each_with_index do |table , index|
	table_array = table.content.split("\n")
	# extract years and store on indexes in temp array from captions of table 
	if table_array[1].split(" ")[0].length > 6
		if table_array[1].split(" ")[0].include? "/" 
	  		year_array.push(table_array[1].split(" ").collect {|arr_val| arr_val.strip} [0][0..6])
	  	else
	    	year_array.push(table_array[1].split(" ").collect {|arr_val| arr_val.strip} [0][0..3])
	  	end 
	else
	  	year_array.push(table_array[1].split(" ")[0])
	end
end

# puts year_array

index = 0
picture_css.each_with_index do |table , index|
	table_array = table.content.split("\n")
	movie_array = Array.new
	# to extract movie names for the best picture category and map with the years based on the indexes
	picture_css[index].css("tr")[1..-1].each do |row|
		# spliting on \n to extract multiple movies in a table row
		row_array = row.content.split("\n").collect {|arr_val| arr_val.strip} 
		movie = row_array[1].split("[").collect {|arr_val| arr_val.strip} [0]
		movie_array.push(movie)
		# extract winners based on styling for 
		if (row.has_attribute? ("style"))
			# puts "I am in Style Section"
			# puts row["style"]
			if row["style"].eql? "background:#FAEB86"
				array_winner_picture.push(movie)
			end
		end
	end
	# storing movie array to hash on particular array index
	hash_picture[year_array[index]] = movie_array
end

# puts hash_picture
# puts "------------------------------------------------------"
# print array_winner_picture

result = Array.new
# to find intersection of all the nominated movies for various categories
hash_picture.keys.each do |key|
	intersection = hash_picture[key] & hash_director[key] & hash_actor[key] & hash_actress[key]
	if not intersection.size == 0 
		result.push(intersection).flatten!
	end
end
# puts result.sort.size

# to check how many awards each movie won
puts "Movie Name ------------------------- No of Awards"
result.each do |movie|
	# puts movie
	award_count = 0
	if array_winner_actor.include? movie
		award_count += 1
	end
	if array_winner_actress.include? movie
		award_count += 1
	end
	if array_winner_picture.include? movie
		award_count += 1
	end
	if array_winner_director.include? movie
		award_count += 1
	end
	# displaying on screen the required output
	puts "#{movie} ------------------------- #{award_count}"
end