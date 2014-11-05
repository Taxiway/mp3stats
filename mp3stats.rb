require_relative "html_downloader.rb"
require_relative "parser.rb"

class Stats
  MP3_URL = "http://www.hhanger.com/mp3tag.html"
  def get_rank_class(rank)
    case rank
    when 1
      ' class="first"'
    when 2
      ' class="second"'
    when 3
      ' class="third"'
    else
      ''
    end
  end

  def get_stats
    downloader = Downloader.new(MP3_URL)
    parser = Parser.new
    dict = parser.parse(downloader.get_content)
    dict = dict.sort_by {|artist, count| -count}
    iter = dict.each
    puts %q{<table class="style1">}
    puts "<tr><th>Rank</th><th>Artist</th><th>Count</th></tr>"
    last_count = 1024
    rank = 0
    100.times do |ind|
      artist, count = iter.next
      rank = ind if count != last_count
      break if rank > 20
      puts "<tr#{get_rank_class(rank + 1)}><td>#{rank + 1}</td><td>#{artist}</td><td>#{count}</td></tr>"
      last_count = count
    end
    puts "</table>"
  end
end

stats = Stats.new
stats.get_stats
