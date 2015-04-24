class Attitude
  LETTERS = %w{e f g h}

  def initialize(string)
    @index = LETTERS.index(string)
    raise "#{string} isn't an Attitude" unless @index
    @letter = string
  end
  attr_reader :letter, :index

  ATTITUDES = LETTERS.collect{|choice| Attitude.new(choice)}
  def self.all; ATTITUDES; end

  def self.find(letter); ATTITUDES[LETTERS.index(letter)]; end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end

  def next; Attitude.all[(@index + 1).modulo(4)]; end
  def opposite; Attitude.all[(@index + 2).modulo(4)]; end
  def previous; Attitude.all[(@index + 3).modulo(4)]; end

  def mbti; %w{EP IP EJ IJ}[@index]; end
  def adjective; %w{bursty over under steady}[@index]; end
  def ed; @index.odd? ? "introverted" : "extroverted"; end
  def vert; @index < 2 ? "extrovert" : "introvert"; end
  #def description; [ed, vert].map(&:capitalize).join(" "); end
  def description; adjective.capitalize; end
  def description_with_mbti; "#{description} (#{mbti})"; end

  # make the numbers look reasonable and all equal about the same
  # when multiplied by the realm.send(attitude)
  def physical; [1, 2, 4, 6][@index]; end # median 3
  def interpersonal; [1, 2, 4, 8][@index]; end # median 3
  def cognitive; [1, 2, 7, 20][@index]; end # median 4
  def financial; [1, 4, 10, 12][@index]; end # median 8
  def size; %w{triple 150% 75% half}[@index]; end

  def generic; physical; end
  def units; generic == 1 ? "unit" : "units"; end
  def short; "#{generic.word} #{size}-sized #{units}"; end

end
