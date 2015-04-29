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

  def get?; @index.odd? ? true : false; end
  def rational?; [1,2].include?(@index) ? true : false; end
  def bursty?; @index < 2 ? true : false; end


  def adjective; rational? ? "chronic" : "acute"; end
  def noun; get? ? "depression" : "mania"; end
  def description; [adjective, noun].map(&:capitalize).join(" "); end
  def mbti; %w{EP IP EJ IJ}[@index]; end
  def with_mbti; "(#{mbti})"; end
  def description_with_mbti; [description, with_mbti].join(" "); end


  def do_or_do_not; bursty? ? "" : "do not"; end
  def too_much_or_enough; bursty? ? "too much" : "enough"; end
  def generic; get? ? "get" : "use"; end


  def trait(get_or_use=generic); "#{do_or_do_not} #{get_or_use} #{too_much_or_enough}".squish; end


end
