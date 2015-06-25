class Type
  LETTERS = Nature::LETTERS.product(Nurture::LETTERS).map(&:join)

  def self.my_path; Nature.first.path + Nurture.first.path ; end
  def self.first; Type.new(my_path); end

  def initialize(letters)
    raise "#{letters} isn't a Type" unless LETTERS.include?(letters)
    @index = LETTERS.index(letters)
    @path = letters
  end
  attr_reader :path

  TYPES = LETTERS.collect{|letters| Type.new(letters)}
  def self.all; TYPES; end
  def self.find(letters); TYPES[LETTERS.index(letters)]; end


  def nature; Nature.find(path[0,4]); end
  def nurture; Nurture.find(path[4,4]); end


  def messages; nurture.messages; end
  def stages; nurture.stages; end
  def sensitivities; nature.sensitivities; end
  def subtypes; nurture.subtypes.values_at(*nature.realms.map(&:index)); end

  def mbti; subtypes.map(&:mbti).join("–"); end

  def pairs; subtypes.combination(2); end

end
