# nokogiri is our scraping/parsing library
require 'nokogiri'
# open-uri is part of the standard library and allows you to download a webpage
require 'open-uri'
require 'csv'

root_url = "http://en.wikipedia.org"
# base url for the awards portal 
url = "#{root_url}" + "/wiki/Portal:Academy_Award"

# Here we load the URL into Nokogiri for parsing the page in the process
url_data = Nokogiri::HTML(open(url))
# extracting table based on css styling for the table
url_data_css = url_data.css("div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table tr td div div table tr td span.nowrap a")

url_data_css.each do |val|
	# replacing special characters by '' to get exact match of the url 
	temp = val.text.gsub(/[^0-9A-Za-z\s.]/, '')
	if temp.eql? "Best Cinematography"
		best_cinematography = val
		# storing the url for redirection for the required category
		$redirect_url = "#{root_url}" + best_cinematography["href"]
	end
end

redirect_data = Nokogiri::HTML(open($redirect_url))
# extracting table based on css styling for the table
main_table_css = redirect_data.css("div#content.mw-body div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table.wikitable") 

# puts main_table_css.length

# array initialization
array_row_data = Array.new
initial = 0
# hash_cinematographer = Hash.new

# for printing on console
puts "Cinematographer ----------------------------------- Awarded Movie"

# removing header table row
main_table_css[0].css("tr")[1..-1].each do |row|
	# getting data to get categories based on split of \n
	array_row_data = row.content.split("\n").collect {|arr_val| arr_val.strip} 
	if array_row_data.include? "Most Awards"
		array_row_data = array_row_data.drop(1)
		initial = 1
	end
	# to extract data if category Most Awards is found
	if initial == 1 
		# to break out of the loop once all most awards winners are extracted
		if array_row_data.include? "Most Nominations"
			break
		end
		# storing actress names 
		$actor_name = array_row_data[1].strip
		# accessing table containing movie details with winners 
		main_table_css[1..-1].each do |subtable|
			# puts "In subtable"
			# extracting movie names based on the actress -- only won
			subtable.css("tr[style='background:#FAEB86']").each do |subrow|
				# puts "In subrow"
				row_data = subrow.text.split("\n").collect {|arr_val| arr_val.strip} 
				row_length = row_data.size
				row_cinematographer = row_data[0..(row_length-1)]
				row_film = row_data[(row_length-1)]
				# print row_cinematographer
				# print row_film
				if row_cinematographer.include? $actor_name
					puts "#{$actor_name} ----------------------------------- #{row_film}"
				end
			end
		end
	end
end
