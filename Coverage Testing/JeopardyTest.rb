require 'simplecov'
SimpleCov.start
require_relative 'Part1'
require_relative 'Part2'
require_relative 'Part3'
require_relative 'Part4'
require_relative 'Part5'
require_relative 'Part6'
require_relative 'Part7'
require_relative 'Part8'

# Test for Part 1
describe "get_best_films" do 
	it "should display films" do
		part1 = Part1.new
		root_url = "http://en.wikipedia.org"
		redirect_url = root_url + "/wiki/Academy_Award_for_Best_Picture"
		production_house = "Disney"
		# output populated to global results array
		part1.get_best_movies(redirect_url,production_house)
		$results_1.should match(/.*Mary Poppins.*/) #'Mary Poppins' is a film for Disney and should be in the output
		$results_1.should_not match(/.*Selma.*/) #'Selma' is a film for Paramount and shouldnt be in output
	end 
end

# Test for Part 2
describe "get_best_screenplays" do 
	it "should display writers" do
		part2 = Part2.new
		root_url = "http://en.wikipedia.org"
		$redirect_url = root_url + "/wiki/Academy_Award_for_Best_Original_Screenplay"
		screenplay = "Divorce, Italian Style"
		# output populated to global results array
		part2.best_screenplay(screenplay)
		$results_2.should match(/.*Ennio de Concini.*/) 
		$results_2.should_not match(/.*Charlie Chaplin.*/)
		screenplay = "The Great Dictator"
		part2.best_screenplay(screenplay)
		# output populated to global results array
		$results_2.should match(/.*Charlie Chaplin.*/)
	end 
end

# Test for Part 3
describe "get_best_actors" do 
	it "should display actors" do
		part3 = Part3.new
		root_url = "http://en.wikipedia.org"
		$redirect_url = root_url + "/wiki/Academy_Award_for_Best_Actor"
		role = "King"
		# output populated to global results array
		part3.best_actors(role)
		$results_3.should match(/.*George Clooney.*/) 
		$results_3.should_not match(/.*Jesse Eisenberg.*/)
	end 
end

# Test for Part 4
describe "get_best_actress" do 
	it "should display actress" do
		part4 = Part4.new
		root_url = "http://en.wikipedia.org"
		$redirect_url = root_url + "/wiki/Academy_Award_for_Best_Actress"
		year = 2014	
		# output populated to global results array
		part4.best_actress(root_url, year)
		$results_4.should match(/.*Sandra Bullock.*/) # Sandra Bullock 50 years
		$results_4.should_not match(/.*Meryl Streep.*64.*/)

		# subdivision test #find url in actresses
		$results_4.should match(/.*Sandra_Bullock.*/) #contains redirect for Sandras page

		year = 2006
		part4.best_actress(root_url, year)
		$results_4.should match(/.Kate Winslet.*31./) # Kate Winslet for year 2006
		$results_4.should_not match(/.*50.*/)

		# subdivision test 
		actress_url = "http://en.wikipedia.org/wiki/Julianne_Moore";
		year = 2006
		actress_name = "Julianne Moore"
		actress_film = "Still Alice"
		$results_4.should match(/.*54.*/)
	end 
end

# Test for Part 5
describe "get_best_directors" do 
	it "should display actress" do
		part5 = Part5.new
		root_url = "http://en.wikipedia.org"
		$redirect_url = root_url + "/wiki/Academy_Award_for_Directing"
		num = 4
		# output populated to global results array
		part5.best_directors(num)
		$results_5.should match(/.*King Vidor:The Crowd;Hallelujah;The Champ;The Citadel;War and Peace.*/) # Sandra Bullock 50 years
		$results_5.should_not match(/.*Steven Soderbergh.*/)
		$test_director_data.should match(/.*Steven Soderbergh:1.*/)
	end
end 

# Test for Part 6
describe "get_best_country" do 
	it "should display country movies" do
		part6 = Part6.new
		root_url = "http://en.wikipedia.org"
		$redirect_url = root_url + "/wiki/List_of_countries_by_number_of_Academy_Awards_for_Best_Foreign_Language_Film"
		part6.best_country (root_url)		
		# output populated to global results array
		$country_list.should match (/.*France.*/)
		$country_list.should_not match (/.*Germany.*/)
		# output populated to global results array
		$results_6.should_not match(/.*Barfi.*/)
		$results_6.should match(/.*Intouchables.*/)
	end
end 

# Test for Part 7
describe "get_best_movies" do 
	it "should display movies" do
		part7 = Part7.new
		root_url = "http://en.wikipedia.org"
		$redirect_url = root_url + "/wiki/Portal:Academy_Award"
		part7.main("Tom Hank")
		# output populated to global results array
		$results_7.should match (/.*Toy Story 3.*/)
		$results_7.should_not match (/.*Intouchables.*/)

		$redirect_url = "http://en.wikipedia.org/wiki/Academy_Award_for_Best_Animated_Feature"
		part7.get_movies ("Tom Hank")
		$results_7.should match (/.*Toy Story 3.*/)
		$results_7.should_not match (/.*Intouchables.*/)
	end
end 

# Test case for Wild Card Question 8
describe "get_actress_support_actress" do
	it "should display actress" do
		part8 = Part8.new
		root_url = "http://en.wikipedia.org"
		$redirect_url = root_url + "/wiki/Portal:Academy_Award"
		$actress_url = "http://en.wikipedia.org/wiki/Academy_Award_for_Best_Actress"
		$support_actress_url = "http://en.wikipedia.org/wiki/Academy_Award_for_Best_Supporting_Actress"
		# output populated to global results array
		part8.get_list
		$results_8.should match (/.*Helen Hayes.*/)
		$results_8.should match (/.*Ingrid Bergman.*/)
	end
end 
