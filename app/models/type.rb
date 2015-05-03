class Type
  def self.my_path; "itnsf"; end
  def self.my_type; Type.find(my_path); end

  LETTERS = Realm::LETTERS.permutation(4).map(&:join).multiply(%w{i e}).flatten.map(&:reverse)

  def initialize(string)
    raise "#{string} isn't a Type" unless LETTERS.include?(string)
    @path = string
    @nurture = string[0]
    @nature = string[1,4]
  end
  attr_reader :path

  TYPES = LETTERS.collect{|choice| Type.new(choice)}
  def self.all; TYPES; end
  def self.find(letters); TYPES[LETTERS.index(letters)]; end

  def realms; @nature.scan(/./).collect{|r| Realm.find(r)}; end
  def states; Attitude.all.add(realms); end
  def ordered_states; @nurture == "i" ? states.reverse : states; end
  def mbti; ordered_states.map(&:mbti).join("-"); end

  def short; ordered_states.map(&:behavior).to_sentence; end
  def with_mbti; "(#{mbti})"; end
  def short_with_mbti; [short, with_mbti].join(" "); end
end
