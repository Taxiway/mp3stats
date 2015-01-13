class Album
  @@albums = Hash.new

  def initialize(name)
    @name = name
    @songs = Array.new
  end

  def addsong(song)
    @songs.push song
  end

  def log
    unless @@albums.has_key? @name
      @@albums[@name] = self
    end
    self
  end

  def inspect
    "Album #{@name}\n#{@songs.length} songs"
  end

  def self.get(name)
    if @@albums.has_key? name
      @@albums[name]
    else
      Album.new(name).log
    end
  end

  def self.all
    @@albums.values
  end
end
