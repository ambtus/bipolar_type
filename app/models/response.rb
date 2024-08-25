class Response

  NAMES = %w{Internalize Externalize}

  def initialize(name); @name = name; end
  attr_reader :name
  alias inspect :name
  def letter; name.first; end
  alias path :letter

  def index; NAMES.index @name; end
  def <=>(other); index <=> other.index; end
  def mbti; %w{I E}[index]; end
  alias display :mbti

  def symbolic_name; [display.colon, name].to_phrase; end

  ALL = NAMES.collect {|name| self.new name}
  def self.all; ALL; end

  def flip; ALL.without(self).first; end
  alias opposite :flip
  # no-op to allow mapping
  def flop; self; end

  def episode; %w{depressed manic}[index]; end
end
