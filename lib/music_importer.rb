class MusicImporter 
  attr_accessor :path 

    def initialize(path)
        @path = path 
    end 

    def files 
        @files = []
        Dir.foreach(@path){|file| @files << file if file.include?(".mp3")}
        @files.uniq 
    end 

    def import
        self.files.each{|filename| Song.create_from_filename(filename)} 
    end 

end 