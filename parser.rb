# Parse http://www.hhanger.com/mp3tag.html

class Parser
  def parseline(line)
    line[(line.index('>') + 1) ... line.rindex('<')]
  end
  def parse(content)
    @content = content
    @content.select! {|line| line =~ /<td/}
    @artists = Hash.new(0)
    @content.each_with_index do |line, index|
      @artists[parseline(line)] += 1 if index % 8 == 2
    end
    @artists
  end
end
