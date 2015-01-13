# Parse http://www.hhanger.com/mp3tag.html

require_relative 'song'
require_relative 'album'
require_relative 'artist'

class Parser
  def parseline(line)
    line[(line.index('>') + 1) ... line.rindex('<')]
  end

  def parse(content)
    puts "Parsing Start"

    content.select! {|line| line =~ /<td/}
    content.collect! {|line| parseline(line)}
    song_count = content.length / 8;
    1.upto(song_count) do |index|
      _, title, artist, album, track, year =
        content[8 * (index - 1) ... 8 * index]
      Song.new(artist, title, album, year, track).log
    end
  end
end
