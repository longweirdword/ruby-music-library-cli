class MusicLibraryController

    def initialize(path = './db/mp3s')
        MusicImporter.new(path).import 
    end 

    def call 
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        input = gets.strip
        case input 
        when 'list songs'
            self.list_songs
        when 'list artists'
            self.list_artists
        when 'list genres'
            self.list_genres
        when 'list artist'
            self.list_songs_by_artist
        when 'list genre'
            self.list_songs_by_genre
        when 'play song'
            self.play_song
        end 
        call if input != "exit"
    end 

    def list_songs
        songs = Song.all.map{|song| song.name}.sort 
        filenames = songs.map{|song| Song.find_by_name(song)}
        filenames.each.with_index do |filename, index| 
            puts "#{index + 1}. #{filename.artist.name} - #{filename.name} - #{filename.genre.name}"
        end 
    end 

    def  list_artists
        artists = Artist.all.map{|artist| artist.name}.sort 
        artists.each.with_index{|artist, index| puts "#{index +1}. #{artist}"}
    end 

    def list_genres
        genres = Genre.all.map{|genre| genre.name}.sort
        genres.each.with_index{|genre, index| puts "#{index +1}. #{genre}"}
    end 

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.strip 
        if Artist.find_by_name(input)
            artist = Artist.find_by_name(input)
            song_genre_string = artist.songs.map{|song| "#{song.name} - #{song.genre.name}"}.sort 
            song_genre_string.each.with_index do |string, index|
                puts "#{index + 1}. " + string 
            end 
        end 
    end 
          
        def list_songs_by_genre
            puts "Please enter the name of a genre:"
            input = gets.strip 
            if Genre.find_by_name(input)
                genre = Genre.find_by_name(input)
                songs = genre.songs.map{|song| song.name}.sort 
                filenames = songs.map{|song| Song.find_by_name(song)}
                filenames.each.with_index do |song, index| 
                    puts "#{index + 1}. #{song.artist.name} - #{song.name}"
                end 
            end 
        end 

        def play_song 
            puts "Which song number would you like to play?"
            input = gets.strip.to_i 
            if input.between?(1, Song.all.count)
                songs = Song.all.map{|song| song.name}.sort 
                filenames = songs.map{|song| Song.find_by_name(song)}
                result = filenames[input - 1]
                puts "Playing #{result.name} by #{result.artist.name}"
            end 
        end 
    
end 