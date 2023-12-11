class Problem < Concept

  def initialize(string)
    @symbol = string
    @action = Action.send(string.first)
    @role = Role.send(string.second)
  end
  attr_reader :symbol, :role, :action

  ########
  ALL = Role::SYMBOLS.collect do |role|
          Action::SYMBOLS.collect do |action|
            self.new [action, role].join
          end
        end.flatten
  SYMBOLS = ALL.map(&:symbol)
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def subtypes; Subtype.select{|x| x.problem == self}; end
  def +(realm); subtypes.find{|x| x.realm == realm}; end

  def issue; Words.issue[symbol]; end
  def imbalance; Words.imbalance[symbol]; end
  def goal; Words.goal[symbol]; end

  def actual(realm); realm.gsub(issue); end
  def desired(realm); realm.gsub(goal); end

  def method_missing(meth, *arguments, &block)
    if role.respond_to?(meth)
      role.send(meth, *arguments, &block)
    elsif action.respond_to?(meth)
      action.send(meth, *arguments, &block)
    else
      super
    end
  end

end

