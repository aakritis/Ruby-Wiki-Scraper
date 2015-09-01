------------------------------------------
CIT 597 - Web Programming 
Assignment # 2
Name : Aakriti Singla
SEAS Login : aakritis@seas.upenn.edu
-------------------------------------------

PART 1 
----------------------------------------------------------------------------------------------------------------

Instructions to run the file :
All the files related to part 1 are zipped in Assignment_2_Part_1 folder
The Java Project is zipped into a folder and will require Java Run Time to run the same. 
Java File Name : TicTacToe.java
Ruby File Name : TicTacToe.rb

Details for the mini project : TIC TAC TOE
This is a simple program in ruby to play famous tic tac toe. The program expects two players as input. After users, a welcome message is displayed and the game starts. The user needs to provide valid set of indexes available in the board.
As per Tic Tac Toe game, the result is displayed as Who is the Winner or If it is a Draw.

The program is re-written as first basic Ruby code based on pig.rb elaborated in class and constructed with basic functions in ruby. This is a beginner Ruby Program

Result Window for TicTacToe.rb
==================================
       Welcome to Tic Tac Toe     
==================================
Enter first player :
Aakriti
Enter second player :
Dushan

 AAKRITI gets 'Noughts(Os)' and DUSHAN gets Crosses(Xs)


		   | 1  |  2  |  3  |  
  		   |____|_____|_____| 

		   | 4  |  5  |  6  |  
  		   |____|_____|_____| 

		   | 7  |  8  |  9  |  
  		   |    |     |     | 


AAKRITI choose a position to play
1


		   | O  |  2  |  3  |  
  		   |____|_____|_____| 

		   | 4  |  5  |  6  |  
  		   |____|_____|_____| 

		   | 7  |  8  |  9  |  
  		   |    |     |     | 


DUSHAN choose a position to play
4


		   | O  |  2  |  3  |  
  		   |____|_____|_____| 

		   | X  |  5  |  6  |  
  		   |____|_____|_____| 

		   | 7  |  8  |  9  |  
  		   |    |     |     | 
..............................................

		   | O  |  2  |  O  |  
  		   |____|_____|_____| 

		   | X  |  O  |  X  |  
  		   |____|_____|_____| 

		   | 7  |  X  |  O  |  
  		   |    |     |     | 


Nice Game !!! 
AAKRITI is the WINNER !!!


----------------------------------------------------------------------------------------------------------------
PART 2 
----------------------------------------------------------------------------------------------------------------

Instructions to run the file : 
All the files related to part 1 are zipped in Assignment_2_Part_2 folder
The values in Italics in the questions can be replaced by any value for testing. All files are simple ruby files tested in ruby 2.2 

Tools Used :
Ruby 2.2
NOKOGIRI 
Open-Uri
Chrome Element/ Web-Inspector
Sublime Editor 
* P.S. : The indentation was set as per Sublime Property Preferences but tab is not working in other editor. The overall indentation is done perfectly, just that tab appears as 4 spaces instead of 2 in other editors (works in sublime with property file).

All the programs/algorithms are implemented in basic ruby standards and were a good learning experiments. I have tried my best to code as per the ruby standards and have provided proper line-wise comments to ease the understanding of algorithm implemented.

Thank you for the opportunity for overall interesting learning experience.
----------------------------------------------------------------------------------------------------------------

All the programs/algorithm implemented follow the below basic flow. The details related/specific to subparts along with results is listed below. 

Steps to Wiki Web Scraper for Academy Award Portal
1. From the Academy Award Portal wiki link (provided in the assignment), access the required url with proper scrapping to the link.
2. Access the tables/links required in the link using css or at_css functions providing proper CSS path from the web inspector in Google Chrome.
3. Access elements from table like tr/th/td or links from a tags etc using proper syntaxes and display the required data using various filters and ruby defined loops/conditions

Please note root_url is defined for every algorithm as "http://en.wikipedia.org" which will behave as the root url for every redirection

Details for the sub parts :
1.
Explaination :
After accessing the Best Picture Url, calculate the length of the required data table and traverse through the table to fetch all movies whose production house include 'Disney'.
The value 'Disney' can be updated to any other value / producer listed in the table
Result :
Mary Poppins
Beauty and the Beast
Up
Toy Story 3
****************************************************************************************************************

2.
Explaination :
After accessing the Best Original Screenplay Url, extract only the required data for writers and movies and remove the year column by eliminating on td property of rowspan. The results are displayed for 'Divorce, Italian	Style.' The same value can be updated to any other value from the table
Result :
Ennio de Concini
Pietro Germi
Alfredo Giannetti
****************************************************************************************************************

3.
Explaination :
After redirecting to the Best Actor Url, extract the required and the role name (split on \n as there were multiple roles per actor) and return all the actors whose roles included 'King'
The value 'King' can be updated to any other value listed in the table
Assumption : 
That Actors playing the role of King will have 'King' as a Keyword in the role. Used include? function to check the substring. The data doesn't include substrings of name having 'king' pattern since 'K' is capslock in the comparision made

Result :
Charles Laughton
Laurence Olivier
Yul Brynner
Peter O'Toole
Richard Burton
Kenneth Branagh
Nigel Hawthorne
Colin Firth
George Clooney
****************************************************************************************************************

4.
Explaination :
This was an interesting question where after doing basic set up, I programmed in a way to loop in through the given year to the next year and exit the loop. 
As part of the program, on traversing every required row in the table i break out of the loop. Later, I am redirecting to the list actresses personal webpages and calculating their ages.
Result is displayed as 
Actress-Name: -------------     Actress-Film:----------------       Actress-Age: ---------------

Assumption : Every age value in wikipedia is relative to year 2014 and the same fact is used which calculating the required age for listed heroine.

Result :
Actress-Name: Helen Mirren     Actress-Film: The Queen       Actress-Age: 61
Actress-Name: Penélope Cruz     Actress-Film: Volver       Actress-Age: 32
Actress-Name: Judi Dench     Actress-Film: Notes on a Scandal       Actress-Age: 72
Actress-Name: Meryl Streep     Actress-Film: The Devil Wears Prada       Actress-Age: 57
Actress-Name: Kate Winslet     Actress-Film: Little Children       Actress-Age: 31
****************************************************************************************************************

5.
Explaination :
As part of this algorithm, I used Hash Map of arrays to store the director id and list of movies directed by him. To check the condition on total no of movies nominated >=4 , another hash map storing the counts of movies per director is used
Result is displayed as
Actor Name -------
		[Array of list of movies norminated or won] 

Result :
King Vidor-----
		["The Crowd", "Hallelujah", "The Champ", "The Citadel", "War and Peace"]
Clarence Brown-----
		["Anna Christie and Romance", "A Free Soul", "The Human Comedy", "National Velvet", "The Yearling"]
George Cukor-----
		["Little Women", "The Philadelphia Story", "A Double Life", "Born Yesterday"]
John Ford -----
		["The Informer", "The Grapes of Wrath", "How Green Was My Valley", "The Quiet Man"]
William Wyler-----
		["Dodsworth", "Wuthering Heights", "The Letter", "The Little Foxes", "The Heiress", "Detective Story", "Roman Holiday", "Friendly Persuasion", "The Collector"]
Alfred Hitchcock-----
		["Rebecca", "Lifeboat", "Spellbound", "Rear Window", "Psycho"]
Billy Wilder-----
		["Double Indemnity", "Sunset Boulevard", "Stalag 17", "Sabrina", "Witness for the Prosecution", "Some Like It Hot"]
David Lean-----
		["Brief Encounter", "Great Expectations", "Summertime", "Doctor Zhivago", "A Passage to India"]
Fred Zinnemann-----
		["The Search", "High Noon", "The Nun's Story", "The Sundowners", "Julia"]
John Huston-----
		["The Asphalt Jungle", "The African Queen", "Moulin Rouge", "Prizzi's Honor"]
Sidney Lumet-----
		["12 Angry Men", "Dog Day Afternoon", "Network", "The Verdict"]
Federico Fellini-----
		["La Dolce Vita", "8½", "Satyricon", "Amarcord"]
Stanley Kubrick-----
		["Dr. Strangelove", "2001: A Space Odyssey", "A Clockwork Orange", "Barry Lyndon"]
Robert Altman-----
		["MASH", "Nashville", "The Player", "Short Cuts", "Gosford Park"]
Steven Spielberg-----
		["Close Encounters of the Third Kind", "Raiders of the Lost Ark", "E.T. the Extra-Terrestrial", "Munich", "Lincoln"]
Woody Allen-----
		["Interiors", "Broadway Danny Rose", "Hannah and Her Sisters", "Crimes and Misdemeanors", "Bullets over Broadway", "Midnight in Paris"]
Martin Scorsese-----
		["Raging Bull", "The Last Temptation of Christ", "Goodfellas", "Gangs of New York", "The Aviator", "Hugo", "The Wolf of Wall Street"]
Peter Weir-----
		["Witness", "Dead Poets Society", "The Truman Show", "Master and Commander: The Far Side of the World"]
****************************************************************************************************************

6.
Explaination :

The approach used here is redirection to sub url "List of countries by number of Academy Awards for Best Foreign Language Film" in the initial redirected url of Best foreign language film.
I stored the value of country, url of country and total no of nominations from each movie.
I extracted the key with the maximum value in hash and redirected to the country's url. From the country's url, all the movies (other than not nominated ones) are displayed.

Result :
France --------------------------
		Monsieur Vincent
		Au-delà des grilles
		Jeux interdits
		Gervaise
		Porte des Lilas
		Mon Oncle
		Orfeu Negro
		La Vérité
		Les dimanches de ville d'Avray
		Les Parapluies de Cherbourg
		Un homme et une femme
		Vivre Pour Vivre
		Baisers volés
		Ma nuit chez Maud
		Hoa-Binh
		Le Charme discret de la bourgeoisie
		La Nuit américaine
		Lacombe Lucien
		Cousin, cousine
		La Vie devant soi
		Préparez vos mouchoirs
		Une histoire simple
		Le Dernier Métro
		Coup de torchon
		Coup de foudre
		Trois hommes et un couffin
		37°2 le matin
		Au revoir, les enfants
		Camille Claudel
		Cyrano de Bergerac
		Indochine
		Ridicule
		Est-Ouest [A]
		Le goût des autres
		Le Fabuleux Destin d'Amélie Poulain
		Les Choristes
		Joyeux Noël
		Fauteuils d'orchestre
		Entre les murs
		Un prophéte
		Des hommes et des dieux
		Intouchables
****************************************************************************************************************

7.
Explaination :
The algorithm uses simple approach explained above, followed by redirection to every movie link. On reaching movie link, the data for actors is extracted from 'Starring' table header. If the value matches 'Tom Hanks', results are displayed. 
Same can be tested for any another actor.

Result :
Toy Story 3
****************************************************************************************************************

8.
Wild Card Question :
List all the actress who won both Best Actress and Best Supporting Actress awards along with the list of movie(s) for which the won the respective awards

Explaination :
By simple redirection urls , I am redirecting to both the required urls and creating two hash maps of arrays to store actress as key and list of movies for which she got best actress and best supporting actress respectively as the array. 
On comparing the hashes, the values for matching actress along with both the arrays is returned.

Result :
Actress : Helen Hayes
		Best Actress Award For : ["The Sin of Madelon Claudet"] 
		Best Supporting Actress Award For : ["Airport"] 
Actress : Ingrid Bergman
		Best Actress Award For : ["Gaslight", "Anastasia"] 
		Best Supporting Actress Award For : ["Murder on the Orient Express"] 
Actress : Maggie Smith
		Best Actress Award For : ["The Prime of Miss Jean Brodie"] 
		Best Supporting Actress Award For : ["California Suite"] 
Actress : Meryl Streep
		Best Actress Award For : ["Sophie's Choice", "The Iron Lady"] 
		Best Supporting Actress Award For : ["Kramer vs. Kramer"] 
Actress : Jessica Lange
		Best Actress Award For : ["Blue Sky"] 
		Best Supporting Actress Award For : ["Tootsie"] 
Actress : Cate Blanchett
		Best Actress Award For : ["Blue Jasmine"] 
		Best Supporting Actress Award For : ["The Aviator"] 
****************************************************************************************************************


PART 2 Extra Credit
----------------------------------------------------------------------------------------------------------------
1. 
Explaination :
This question was little tricky and required data comparision from 4 different urls. The basic approach remains the same wherein I am redirecting to Best Actor, Best Actress, Best Picture and Best Director Awards data as below :
1. Hash Map for each page to store the list of movies nomminated/won wrt to the year
2. Store an array of movies that won the corresponding awards.

After storing the data, I am taking the intersection of the hash maps to get the list of movies that had all 4 nominations and listing the count based on the arrays.

Result :
Movie Name ------------------------- No of Awards
Cimarron ------------------------- 1
It Happened One Night ------------------------- 4
A Star Is Born ------------------------- 0
Gone with the Wind ------------------------- 3
Goodbye, Mr. Chips ------------------------- 1
Rebecca ------------------------- 1
The Philadelphia Story ------------------------- 1
Mrs. Miniver ------------------------- 2
The Bells of St. Mary's ------------------------- 0
The Yearling ------------------------- 0
Gentleman's Agreement ------------------------- 1
Johnny Belinda ------------------------- 1
Sunset Boulevard ------------------------- 0
A Place in the Sun ------------------------- 1
A Streetcar Named Desire ------------------------- 1
From Here to Eternity ------------------------- 2
The Country Girl ------------------------- 1
The King and I ------------------------- 1
Cat on a Hot Tin Roof ------------------------- 0
Room at the Top ------------------------- 1
The Apartment ------------------------- 2
The Hustler ------------------------- 0
Who's Afraid of Virginia Woolf? ------------------------- 1
Bonnie and Clyde ------------------------- 0
The Graduate ------------------------- 1
Guess Who's Coming to Dinner ------------------------- 1
The Lion in Winter ------------------------- 1
Love Story ------------------------- 0
Chinatown ------------------------- 0
Lenny ------------------------- 0
One Flew Over the Cuckoo's Nest ------------------------- 3
Rocky ------------------------- 2
Network ------------------------- 2
Annie Hall ------------------------- 3
Coming Home ------------------------- 2
Atlantic City ------------------------- 0
On Golden Pond ------------------------- 2
Reds ------------------------- 1
The Silence of the Lambs ------------------------- 4
The Remains of the Day ------------------------- 0
The English Patient ------------------------- 2
American Beauty ------------------------- 3
Million Dollar Baby ------------------------- 3
Silver Linings Playbook ------------------------- 1
American Hustle ------------------------- 0
****************************************************************************************************************
2. 

Wild Card Question :
List all the Cinematographer who got Most No. of awards along with the list of movies for which he/she won awards

Explaination :
After redirecting to Best Cinematography Url, from the superlatives table I am extracting the list of cinmaptographers who have won maximum no of awards this year. 
After extracting the required list, I am traversing through the list of year-wise tables to extract the list of movies for which they recieved the award

Result :
Cinematographer ----------------------------------- Awarded Movie
Leon Shamroy ----------------------------------- The Black Swan
Leon Shamroy ----------------------------------- Wilson
Leon Shamroy ----------------------------------- Leave Her to Heaven
Leon Shamroy ----------------------------------- Cleopatra
Joseph Ruttenberg ----------------------------------- The Great Waltz
Joseph Ruttenberg ----------------------------------- Mrs. Miniver
Joseph Ruttenberg ----------------------------------- Somebody Up There Likes Me
Joseph Ruttenberg ----------------------------------- Gigi
****************************************************************************************************************

----------------------------------------------------------------------------------------------------------------