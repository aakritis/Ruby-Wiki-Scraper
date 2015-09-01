# nokogiri is our scraping/parsing library
require 'nokogiri'
# open-uri is part of the standard library and allows you to download a webpage
require 'open-uri'
require 'csv'

$redirect_url =""
$results_4 = ""
$results_4_links = ""

class Part4
    def main (given)
        root_url = "http://en.wikipedia.org"

        # hard coding root url for Academy award portal
        url = "#{root_url}" + "/wiki/Portal:Academy_Award"

        # Here we load the URL into Nokogiri for parsing the page in the process
        url_data = Nokogiri::HTML(open(url))
        # extracting required table based on styling
        url_data_css = url_data.css("div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table tr td div div table tr td span.nowrap a")

        # puts url_data_css.text.gsub(/[^0-9A-Za-z\s.]/, '')

        url_data_css.each do |val|
            # removing special characters for exact match
            temp = val.text.gsub(/[^0-9A-Za-z\s.]/, '')
            if temp.eql? "Best Leading Actress"
                best_leading_actor = val
                # setting redirect url 
                $redirect_url = "#{root_url}" + best_leading_actor["href"]
            end
        end
        best_actress(root_url, given)
    end

    def best_actress(root_url, given)

        redirect_data = Nokogiri::HTML(open($redirect_url))
        # extracting table for the required data
        main_table_css = redirect_data.css("div#content.mw-body div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table.wikitable") 

        # storing temp year variable for traversal 
        year = given
        main_table_css.each do |table|
            initial = 0
            table.css("tr").each do |row|
                # puts row
                # puts "============================="
                array_row_data = row.content.split("\n")
                # puts array_row_data
                # puts array_row_data

                # to initialize start of data extracting based on the year in the row 
                if array_row_data.include? year.to_s
                    initial = 1
                    next
                end
                if initial == 1 
                    # puts array_row_data
                    # to check where to break the loop after all the required data is extracted
                    if array_row_data.include? (year+1).to_s
                        exit
                    end
                    # storing actress name based on first href data in the row
                    actress = row.at_css("a")
                    actress_name = array_row_data[1]
                    actress_film = array_row_data[2]
                    # redirecting to the actress url to extract current age for the actress
                    actress_url = "#{root_url}" + "#{actress["href"]}"
                    $results_4_links += actress_url + ";"
                    get_each_actress(actress_url, year, actress_name, actress_film)
                end
            end
        end
    end
    def get_each_actress (actress_url, year, actress_name, actress_film)
        actress_data = Nokogiri::HTML(open(actress_url))
        # accessing division in actress url based on the styling
        actress_css_age = actress_data.css("div#content.mw-body div#bodyContent.mw-body-content div#mw-content-text.mw-content-ltr table.infobox.biography.vcard tr td span.noprint.ForceAgeToShow")    
        # change age calculations 
        # since ages are available based on the 2014 year --- subtracting the year under consideration
        # to know the value required to be subtracted to get actress age on release of movies
        age_sub = 2014 - year.to_i
        # to get actress age in release year of the movie
        actress_age = actress_css_age.text.gsub!(/\D/, "").to_i - age_sub
        $results_4 += actress_name + "," + actress_age.to_s + ";"
        # to display on console
        puts "Actress-Name: #{actress_name}     Actress-Film: #{actress_film}       Actress-Age: #{actress_age}"
    end

end

part4 = Part4.new()
part4.main(2006)