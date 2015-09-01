# nokogiri is our scraping/parsing library
require 'nokogiri'
# open-uri is part of the standard library and allows you to download a webpage
require 'open-uri'
require 'csv'

$redirect_url = ""
$results_2 = ""

class Part2
	def main (screeplay)
		root_url = "http://en.wikipedia.org"

		# storing root url for academy award portal 
		url = "#{root_url}" + "/wiki/Portal:Academy_Award"

		# Here we load the URL into Nokogiri for parsing the page in the process
		url_data = Nokogiri::HTML(open(url))

		# extracting required table based on styling
		url_data_css = url_data.css("#content div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table tr td div div table tr td a.mw-redirect")

		$redirect_url = "No url"

		url_data_css.each do |val|
			if val.text.eql? "Best Original Screenplay"
				# index = url_data_css.index("Best Original Screenplay") -- to capture index in array
				# best_original_screenplay = url_data_css[index] 
				best_original_screenplay = val
				# puts val
				# setting redirect url for the required link
				$redirect_url = "#{root_url}" + best_original_screenplay["href"]
				# puts $redirect_url
				# puts best_original_screenplay
			end
		end
		# puts $redirect_url
		best_screenplay (screeplay)
	end

	def best_screenplay (screeplay)
		if $redirect_url.eql? "No url"
			puts "Best Original Screenplay Not Found"
		else
			redirect_url_data = Nokogiri::HTML(open($redirect_url))
			# puts redirect_url_data
			# extracting based on styling of table # removing first row to remove headers from the results
			best_writer_table = redirect_url_data.css("div#content.mw-body div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table.wikitable tr")[1..-1]
			# extracting elements based on table rows 
			best_writer_table_array = best_writer_table.map {|element| element.text}.collect {|arr_val| arr_val.strip} 

			# extracting invalid rows (containing years data) not required for the result based on rowspan attribute
			invalid_columns = best_writer_table = redirect_url_data.css("div#content.mw-body div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table.wikitable tr td[rowspan='6']")
			invalid_columns_array = invalid_columns.map {|element| element.text}.collect {|arr_val| arr_val.strip} 

			required_data = best_writer_table_array - invalid_columns_array
			# puts required_data

			# checking length of valid data to traverse the table
			length_node_set = required_data.length
			index = 0

			until index >= length_node_set do
				# puts "Inside the Loop for index = #{index}"
				data_split = required_data[index].split("\n")
				# displaying the required content
				# puts data_split [1 , data_split.size]
				if data_split[0].include? screeplay
					$results_2 += data_split [1 , data_split.size]*","
					puts data_split [1 , data_split.size]
				end
				index += 1
			end
		end
	end
end

p2 = Part2.new()
p2.main("Divorce, Italian Style")