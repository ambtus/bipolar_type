class Behavior < Concept

  SYMBOL = Realm.all.collect do |realm|
             Action.all.collect do |action|
               action.symbol.first + realm.symbol + action.symbol.second
             end
          end.flatten

  ALL = SYMBOL.collect{|symbol| self.new symbol}

  def realm; Realm.find_by(symbol.second); end
  def action; Action.find_by(symbol.remove(symbol.second)); end

  def attitudes; [Attitude.find_by(symbol.first), Attitude.find_by(symbol.third)]; end

  def flop; realm + action.flop; end

  def method_missing(meth, *args, **kwargs, &block)
    if action.respond_to?(meth)
      action.send(meth)
    elsif realm.respond_to?(meth)
      realm.send(meth)
    else
      super(meth)
    end
  end

end
