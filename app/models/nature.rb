class Nature < Phrase

 def initialize(array)
    @kind = array.first
    @action = array.second
    super
  end
  attr_reader :action, :kind

  ALL = Kind::ALL.collect do |kind|
          Action::ALL.collect do |action|
            self.new [kind,action]
          end
        end.flatten
  def self.all; ALL; end

  ALL.each{|s| define_singleton_method(s.path) {s}}
  def self.paths; ALL.map(&:path); end

  def <=>(other); [kind, action] <=> [other.kind, other.action]; end

  def wings; ALL.select{|a| a.action == action || a.kind == kind} - [self]; end

  def subtypes; Subtype.all.select{|s| s.nature == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  def method_missing(meth, *arguments, &block)
    if action.respond_to?(meth)
      action.send(meth, *arguments, &block)
    elsif kind.respond_to?(meth)
      kind.send(meth, *arguments, &block)
    else
      super
    end
  end

  def generic; Phrase.new [kind, action].map(&:generic); end
  def name; Phrase.new [generic.titleize, symbol.parenthesize]; end

end
