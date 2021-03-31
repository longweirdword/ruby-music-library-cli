class Song 
  attr_accessor :name
  attr_reader :artist, :genre 
  @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name 
        self.artist = artist if artist != nil 
        self.genre = genre if genre != nil 
    end 

    def self.all 
        @@all 
    end 

    def self.destroy_all 
        @@all.clear 
    end 

    def save 
        @@all << self 
    end 

    def self.create(name)
        song = self.new(name)
        song.save
        song 
    end 

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end  

    def genre=(genre)
        @genre = genre
        save if !self.class.all.include?(self) 
    end 

    def self.find_by_name(name)
        all.detect{|song| song.name == name}
    end 

    def self.find_or_create_by_name(name)
         if self.find_by_name(name)
            self.find_by_name(name)
        else 
            self.create(name)
        end 
    end 

    def self.new_from_filename(filename)
        data = filename.split(" - ")
        artist = Artist.find_or_create_by_name(data[0])
        genre = Genre.find_or_create_by_name(data[2].sub(/\.[^.]+\z/, ''))

        if !self.find_by_name(data[1])
            self.new(data[1], artist, genre)
        end 
    end 

    def self.create_from_filename(filename)
        song = self.new_from_filename(filename)
        self.all << song if !self.all.include?(song) 
    end 

end 