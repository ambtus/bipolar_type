class Subtype

  def initialize(behavior, realm, position)
    @realm = realm
    @behavior = behavior
    @position = position
  end
  attr_reader :behavior, :realm, :position

  def triplet; [@behavior, @realm, @position]; end
  def symbol; triplet.map(&:symbol).map(&:chars).flatten.values_at(0,2,1,3).join; end
  alias path :symbol
  alias inspect :symbol

  def base_mbti; [@behavior, @realm].map(&:mbti).map(&:chars).flatten.values_at(0,2,1).join; end
  def mbti; [base_mbti, @position.mbti].join.html_safe; end

  def names;[@position.name, *@behavior.names, @realm.name].values_at(0,1,3,2); end
  def name; names.wbr; end
  def symbolic_name; [symbol.colon, name].to_safe_phrase; end

  ALL = Behavior.all.collect do |behavior|
          Realm::ALL.collect do |realm|
            Position.all.collect do |position|
              self.new(behavior,realm,position)
            end
          end
        end.flatten

  class << self
    def find(string); ALL.find{|s| s.path == string}; end
    def select( behavior, realm, position); ALL.find{|s| s.realm == realm && s.behavior == behavior && s.position == position}; end
    def all; ALL; end
    def each(&block); ALL.each(&block); end
  end

  ALL.each_with_index do |instance, index|
    %w{symbol}.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end

  def inferior?; @position.inferior?; end
  def make_inferior; Subtype.find(self.path.chop+'4'); end
  def make_dominant; Subtype.find(self.path.chop+'1'); end
  def aux_position; behavior.unhappy? ? Position.second : Position.third; end
  def make_tertiary; Subtype.select(behavior.previous,realm,aux_position); end
  def make_auxiliary; Subtype.select(behavior.next,realm,aux_position); end

  def sample_behavior; @realm.send(@behavior.send_name); end

end
