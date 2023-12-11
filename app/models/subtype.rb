class Subtype < Concept

  def initialize(string)
    @symbol = string
    @action = Action.send(string.first)
    @realm = Realm.send(string.second)
    @role = Role.send(string.third)
  end
  attr_reader :symbol, :realm, :role, :action

  ########
  ALL = Realm::SYMBOLS.collect do |realm|
          Role::SYMBOLS.collect do |role|
            Action::SYMBOLS.collect do |action|
              self.new [action, realm, role].join
            end
          end
        end.flatten
  SYMBOLS = ALL.map(&:symbol)
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def problem; role + action; end

  def <=>(other); self.problem <=> other.problem; end

  def actual; problem.actual(realm); end
  def desired; problem.desired(realm); end

  def method_missing(meth, *arguments, &block)
    if problem.respond_to?(meth)
      problem.send(meth, *arguments, &block)
    elsif realm.respond_to?(meth)
      realm.send(meth, *arguments, &block)
    else
      super
    end
  end

end

