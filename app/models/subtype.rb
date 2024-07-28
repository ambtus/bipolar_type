class Subtype

  def initialize(behavior, realm)
    @realm = realm
    @behavior = behavior
  end
  attr_reader :realm, :behavior

  def pair; [@behavior, @realm]; end
  def symbol; pair.map(&:symbol).join; end
  alias path :symbol

  def names; pair.map(&:name).map(&:to_words).flatten.values_at(0,2,1).map(&:titleize); end
  def name; names.wbr; end
  def inspect; names.to_phrase; end
  def symbolic_name; [symbol.colon, name].to_safe_phrase; end

  ALL = Behavior.all.collect do |behavior|
          Realm.all.collect do |realm|
            self.new(behavior,realm)
          end
        end.flatten

  class << self
    def find(string); ALL.find{|s| s.path == string}; end
    def select(realm, behavior); ALL.find{|s| s.realm == realm && s.behavior == behavior}; end
    def all; ALL; end
    def each(&block); ALL.each(&block); end
  end

  def mbti; pair.map(&:mbti).map(&:chars).flatten.values_at(0,2,1).join; end

  ALL.each_with_index do |instance, index|
    %w{symbol mbti}.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end

  def responsible_names; [@behavior.responsible_names.first, @realm.name, @behavior.responsible_names.second]; end
  def responsible_name; [responsible_names.map(&:first).join.colon, responsible_names.wbr].to_safe_phrase; end
  def conscious_names; [@behavior.conscious_names.first, @realm.name, @behavior.conscious_names.second]; end
  def conscious_name; [conscious_names.map(&:first).join.colon, conscious_names.wbr].to_safe_phrase; end
  def limited_names; [@behavior.limited_names.first, @realm.name, @behavior.limited_names.second]; end
  def limited_name; [limited_names.map(&:first).join.colon, limited_names.wbr].to_safe_phrase; end
  def compulsive_names; [@behavior.compulsive_names.first, @realm.name, @behavior.compulsive_names.second]; end
  def compulsive_name; [compulsive_names.map(&:first).join.colon, compulsive_names.wbr].to_safe_phrase; end

  def eg; @realm.send(@behavior.behavior); end

  def method_missing(meth, *arguments, &block)
    if realm.respond_to?(meth)
      realm.send(meth, *arguments, &block)
    elsif behavior.respond_to?(meth)
      behavior.send(meth, *arguments, &block)
    else
      super
    end
  end


end
