require 'open-uri'
require 'nokogiri'

class ImdbScraping 
 
    attr_reader :number_of_top_movies, :moviesHash

    def initialize(number_of_top_movies)
        @number_of_top_movies = number_of_top_movies
        @moviesHash = {} 
        off_load_response(number_of_top_movies)
    end


    def get_movies_of_actors(actor_name, num_movies)
    
        moviesList = []
        (1..@number_of_top_movies).each do |i|
          actors = @moviesHash[i.to_s]["actors"]
          moviesList << @moviesHash[i.to_s]["name"] if actors.include?(actor_name)
        end
        puts moviesList
    end

    def off_load_response(number_of_top_movies)
        @moviesHash = {} 
        movies = get_movies_response(number_of_top_movies)
        threads = []
        movies.each do |movie| 
          movie_part = movie.text.split('.' , 2)
          movie_rank = movie_part[0]
          movie_name = movie_part[1].strip
          puts movie_name
          link = movie['href']
          threads << Thread.new(link) do |u|
    
                actors = get_actors_response(u)
                @moviesHash[movie_rank] = {
                "rank" => movie_rank,
                "name" => movie_name,
                "actors" => actors
                }
          end
        end
      threads.each(&:join)
    end
    
    private 

    def get_movies_response(num_movies)
        imdb_top_url = "https://www.imdb.com/chart/top"
        number_of_top_movies = num_movies
        xpath = ".ipc-title-link-wrapper"
        headers = { 'User-Agent' => 'Chrome/58.0.3029.110' }
        html = URI.open(imdb_top_url,headers).read
        doc = Nokogiri::HTML(html)
        movies = doc.css(xpath).first(number_of_top_movies)
        movies   
    end
    
    
    def get_actors_response(url)
        movie_http_url = "https://www.imdb.com/"
        headers = { 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36' }
        actor_url = movie_http_url + url
        
        html = URI.open(actor_url,headers).read
        doc = Nokogiri::HTML(html)
        actors = doc.css(".sc-bfec09a1-1.fUguci")
        actors = actors.map{|actor|  actor.text} 
        actors
    end
end


def main()
    puts "How many top imdb movies you want to search upon "
    number_of_top_movies = gets.chomp.to_i

    imdb = ImdbScraping.new(number_of_top_movies)
 

    while true do
        puts "enter actor name"
        actor = gets.chomp
        puts "enter movies"
        number_of_movies = gets.chomp.to_i
        imdb.get_movies_of_actors(actor, number_of_movies)
        puts "press 1 to continue or 0 to exit"
        flag = gets.chomp.to_i
        break if(flag == 0) 
    end

end

main()



