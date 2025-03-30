class Realm < Concept

  SYMBOL = %w{F S T N }

  ALL = SYMBOL.collect {|symbol| self.new symbol}
  SYMBOL.each do |sym|
    define_singleton_method(sym) {ALL.find{|s| s.symbol == sym}}
  end

  def +(thing)
    if thing.is_a?(Attitude)
      Subtype.all.find{|x| x.attitude == thing && x.realm == self}
    elsif thing.is_a?(Action)
      Behavior.all.find{|x| x.action == thing && x.realm == self}
    end
  end

  def subtypes; Subtype.all.select{|x| x.realm == self}; end
  def behaviors; Behavior.all.select{|x| x.realm == self}; end

end
