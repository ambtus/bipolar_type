# Encoding: utf-8
class Type
  def self.my_path; "ntsf"; end
  def self.my_type; Type.find(my_path); end

  LETTERS = Realm::LETTERS.permutation(4).map(&:join)

  def initialize(string)
    raise "#{string} isn't a Type" unless LETTERS.include?(string)
    @path = string
  end
  attr_reader :path

  TYPES = LETTERS.collect{|choice| Type.new(choice)}
  def self.all; TYPES; end
  def self.find(letters); TYPES[LETTERS.index(letters)]; end


  def realms; path.scan(/./).collect{|r| Realm.find(r)}; end
  def states; Attitude.all.add(realms); end
  def short; states.map(&:short).to_sentence; end

  def mbti; states.map(&:mbti).join("‑"); end
  def with_mbti; "(#{mbti})"; end

  def states_without_state(state); states - [state]; end
  def qpath(state); "Q6_#{states_without_state(state).map(&:letters).join}"; end

  def j_state; states.first; end
  def e_state; states.second; end
  def p_state; states.third; end
  def i_state; states.fourth; end

  private
  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.*)_with_mbti$/
      [self.send($1, *args, &block), with_mbti].join(" ")
    else
      super
    end
  end

end
