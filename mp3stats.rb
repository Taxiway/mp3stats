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

  def generate_table(headline, titles, rows, attributes, count, key_attr)
    puts "<p class=\"center\">#{headline}</p>"
    puts %q{<table class="style1">}
    puts "<tr>"
    puts "<th>Rank</th>"
    titles.each do |title|
      puts "<th>#{title}</th>"
    end
    puts "</tr>"

    iter = rows.each
    last_val = nil
    rank = 0
    (100 + count).times do |ind|
      item = iter.next
      val = item.method(key_attr).call
      rank = ind if val != last_val
      break if rank > count
      puts "<tr#{get_rank_class(rank + 1)}><td>#{rank + 1}</td>"
      attributes.each do |attr|
        puts "<td>#{item.method(attr).call}</td>"
      end
      last_val = val
    end
    puts "</table>"
  end

  def get_stats
    downloader = Downloader.new(MP3_URL)
    parser = Parser.new
    parser.parse(downloader.get_content)

    artists = Artist.all
    generate_table("Top 20 singers with most songs",
                   ["Artist", "Songs"],
                   artists.sort_by {|artist| -artist.songcount},
                   [:name, :songcount], 20, :songcount)
    generate_table("Top 20 singers with most albums",
                   ["Artist", "Albums"],
                   artists.sort_by {|artist| -artist.albumcount},
                   [:name, :albumcount], 20, :albumcount)

    albums = Album.all
    generate_table("Top 20 albums with most songs",
                   ["Album", "Songs"],
                   albums.sort_by {|album| -album.songcount},
                   [:name, :songcount], 20, :songcount)
  end
end

stats = Stats.new
stats.get_stats
