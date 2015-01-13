class Artist
  @@artists = Hash.new

  def initialize(name)
    @name = name
    @songs = Array.new
  end

  def addsong(song)
    @songs.push song
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
