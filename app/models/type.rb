class Type
  def self.my_path; "tespnjfip"; end
  def self.my_type; Type.new(my_path); end

  def initialize(string)
    @path = string
    @trait_letters = string[0,8]
    @direction = string[8] == "n" ? :next_subtype : :previous_subtype
  end
  attr_reader :path

  def traits; @trait_letters[0,8].scan(/../).collect{|ra| Trait.find(ra)}; end
  def subtypes; traits.map(&@direction); end
  def mbti; subtypes.map(&:mbti).join("-"); end

  def without_trait(subtype); (subtypes - [subtype]).map(&:trait).map(&:letters).join; end
  def discover_path_without_trait(subtype); "Q4_#{without_trait(subtype)}"; end
  def discover_path_change_direction; "Q5_#{@trait_letters}"; end

  def+(state); Priority.new(@path + state.letters); end
  def priorities; State.all.collect{|s| self + s}; end
  def priority_mbtis; priorities.map(&:mbti).join("-"); end 
end
