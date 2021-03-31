class Artist
  extend Concerns::Findable 
    
  attr_accessor :name 
  @@all = []
  
      def initialize(name)
          @name = name 
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
          artist = self.new(name)
          artist.save
          artist 
      end 

      def songs 
        Song.all.select{|song| song.artist == self}
      end 

      def add_song(song)
        if !song.artist
          song.artist = self 
        end 
        song.save if !Song.all.include?(song)
      end 

      def genres 
        self.songs.collect{|song| song.genre}.uniq
      end 

end 