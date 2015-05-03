class Realm
  LETTERS = %w{t s n f}

  def initialize(string)
    raise "#{string} isn't an Realm" unless LETTERS.include?(string)
    @index = LETTERS.index(string)
    @letter = string
  end
  attr_reader :letter, :index

  REALMS = LETTERS.collect{|choice| Realm.new(choice)}
  def self.all; REALMS; end

  def self.find(letter); REALMS[LETTERS.index(letter)]; end

  def next; Realm.all[(@index + 1).modulo(4)]; end
  def previous; Realm.all[(@index + 3).modulo(4)]; end

  def mbti; letter.upcase; end

  def +(attitude); Trait.find(self.letter + attitude.letter); end
  def behaviors; State.all.add(self); end

  def short; %w{financial physical mental interpersonal}[@index]; end
  def with_mbti; "(#{mbti})"; end
  def short_with_mbti; [short, with_mbti].join(" "); end

  def output; %w{buy take put\ together influence}[@index]; end
  def big_output; %w{expensive long hard unfamiliar}[@index]; end
  def small_output; %w{cheap short easy familiar }[@index]; end
  def productions; %w{tools walks pieces people}[@index]; end
  def input; %w{earn eat analyze hear}[@index]; end
  def big_input; %w{large high-calorie complex emotional}[@index]; end
  def small_input; %w{small low-calorie simple unemotional }[@index]; end
  def resources; %w{rewards meals puzzles stories}[@index]; end

  def manic; %w{poor thin stupid dominant}[@index]; end
  def depressed; %w{rich fat smart submissive}[@index]; end

  def manic_or_depressed; [manic, depressed].join(" or "); end
  def objective_measure; %w{bank\ statement scale test\ score social\ position}[@index]; end

end
