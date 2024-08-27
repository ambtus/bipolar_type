class Realm

  NAMES = %w{Physical Financial Affective Mental}
  def self.names; NAMES; end

  def initialize(name); @name = name; end
  attr_reader :name
  alias inspect :name
  def letter; name.first; end
  alias path :letter

  def index; NAMES.index @name; end
  def <=>(other); index <=> other.index; end
  def mbti; %w{S T F N}[index]; end
  alias display :mbti


  ALL = NAMES.collect {|name| self.new name}
  def self.all; ALL; end

  def self.each(&block);all.each(&block); end

  def symbolic_name; [display.colon, name].to_phrase; end
  def adjective; name.downcase; end
  def adverb; adjective.ly; end

  ALL.each_with_index do |instance, index|
    %w{ name letter}.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end

  # no-ops to allow mapping
  def flip; self; end
  alias flop :flip
  alias opposite :flip

  def +(quadrant); Behavior.find([quadrant, self]); end
  def behaviors; Behavior.all.select{|b| b.realm == self}; end

  def internalize; %w{eat earn listen\ to look\ at}[index]; end
  def externalize; %w{move buy communicate ??}[index]; end

  def energy; %w{carbs cash emotions colors}[index]; end
  def strength; %w{protein credit words shapes}[index]; end
end
