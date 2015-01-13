require_relative 'album'
require_relative 'artist'

class Song
  attr_reader :album

  def initialize(artist, title, album, year, track)
    @artist = artist
    @title = title
    @album = album
    @year = year
    @track = track
  end

  def log
    Album.get(@album).addsong self
    Artist.get(@artist).addsong self
  end
end
