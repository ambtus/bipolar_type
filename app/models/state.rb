class State
  LETTERS = %w{ep ej ij ip}

  def initialize(string)
    raise "#{string} isn't a State" unless LETTERS.include?(string)
    @index = LETTERS.index(string)
    @letters = string
  end
  attr_reader :index, :letters

  def attitudes; letters.scan(/./).collect{|l| Attitude.find(l)}; end

  STATES = LETTERS.collect{|choice| State.new(choice)}
  def self.all; STATES; end

  def self.find(letter); STATES[LETTERS.index(letter)]; end

  def next; State.all[(@index + 1).modulo(4)]; end
  def previous; State.all[(@index + 3).modulo(4)]; end

  def mbti; letters.upcase; end

  def +(realm); Behavior.find(realm.letter + self.letters); end

  def adjective; attitudes.second.adjective; end
  def noun; attitudes.first.short; end

  def short; [adjective, noun].join(" "); end
  def with_mbti; "(#{mbti})"; end
  def short_with_mbti; [short, with_mbti].join(" "); end

end
