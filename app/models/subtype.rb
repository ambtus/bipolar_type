class Subtype < Concept

  def initialize(string)
    @symbol = string
    @nature = Nature.send(string.first)
    @realm = Realm.send(string.second)
    @nurture = Nurture.send(string.third)
  end
  attr_reader :symbol, :realm, :nurture, :nature

  ALL = Solution::SYMBOLS.collect do |solution|
          Realm::SYMBOLS.collect do |realm|
            self.new [solution.first, realm, solution.second].join
          end
        end.flatten
  def self.all; self::ALL; end
  def self.each(&block);self::ALL.each(&block); end
  ALL.each{|s| define_singleton_method(s.symbol) {s}}

  def problem; Problem.send(@realm.symbol + @nurture.symbol); end
  def solution; Solution.send(@nature.symbol + @nurture.symbol); end
  def behavior; realm.behaviors[solution.index]; end

  def method_missing(meth, *arguments, &block)
    if nature.respond_to?(meth)
      nature.send(meth, *arguments, &block)
    elsif realm.respond_to?(meth)
      realm.send(meth, *arguments, &block)
    else
      super
    end
  end

  def description; [attitude, adjective, nurture.problem].to_phrase; end

  def types; Type.all.select{|t| t.subtypes.include?(self)}; end

end
