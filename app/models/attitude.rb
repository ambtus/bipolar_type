class Attitude < Concept

  SYMBOL = %i{BL TL TR BR}

  ALL = SYMBOL.collect {|symbol| self.new symbol}
  SYMBOL.each do |sym|
    define_singleton_method(sym) {ALL.find{|s| s.symbol == sym}}
  end

  def self.rows; [[Attitude.TL, Attitude.TR],
                  [Attitude.BL, Attitude.BR]]; end

  def getting?; string.starts_with?('B'); end

  def gu; string.starts_with?('T') ? 'use' : 'get'; end
  def es; string.ends_with?('L') ? 'energy' : 'strength'; end

  def first_letter; gu.first.capitalize; end
  def second_letter; es.first.capitalize; end

  def action; [gu, es].join('_'); end

  def name; action.titleize; end

  def next; self.class.rotate[index]; end
  def previous; self.class.rotate(-1)[index]; end
  def opposite; self.class.rotate(2)[index]; end
  def flip; Attitude.all.without(self).find{|a| a.string.second == self.string.second}; end
  def flop; Attitude.all.without(self).find{|a| a.string.first == self.string.first}; end

  def subtypes; Subtype.all.select{|x| x.attitude == self}; end
  def +(realm); subtypes.find{|x| x.realm == realm}; end

end
