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
  def previous; Attitude.all[(@index + 3).modulo(4)]; end

  def mbti; %w{EP IP EJ IJ}[@index]; end
  def adjective; %w{bursty over under steady}[@index]; end
  def description; adjective.capitalize; end
  def description_with_mbti; "#{description} (#{mbti})"; end

  # number of chunks
  # make the numbers look reasonable and all equal about the same
  # when multiplied by the realm.send(attitude)
  def number; [1, 2, 4, 6][@index]; end # median 3
  def size; %w{triple 150% 75% half}[@index]; end # median 100%
  def chunks; number == 1 ? "chunk" : "chunks"; end
  def number_chunks; "#{number.word} #{size}-sized #{chunks}"; end

end
