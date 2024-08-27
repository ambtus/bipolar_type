class Attitude

  NAMES = %w{ Speed Strength}

  def initialize(name); @name = name; end
  attr_reader :name
  alias inspect :name
  def letter; name.first; end
  alias path :letter

  def index; NAMES.index @name; end
  def <=>(other); index <=> other.index; end
  def mbti; %w{ P J}[index]; end
  alias display :mbti


  def symbolic_name; [display.colon, name].to_phrase; end

  ALL = NAMES.collect {|name| self.new name}
  def self.all; ALL; end

  def flop; ALL.without(self).first; end
  alias opposite :flop
  # no-op to allow mapping
  def flip; self; end

end
