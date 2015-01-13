class Artist
  attr_reader :name

  @@artists = Hash.new

  def initialize(name)
    @name = name
    @songs = Array.new
    @albums = Hash.new
  end

  def addsong(song)
    @songs.push song
    @albums[song.album] = true
  end

  def log
    unless @@artists.has_key? @name
      @@artists[@name] = self
    end
    self
  end

  def inspect
    "Artist #{@name}\n#{@songs.length} songs"
  end

  def songcount
    @songs.length
  end

  def albumcount
    @albums.keys.length
  end

  def self.get(name)
    if @@artists.has_key? name
      @@artists[name]
    else
      Artist.new(name).log
    end
  end

  def self.all
    @@artists.values
  end
end
