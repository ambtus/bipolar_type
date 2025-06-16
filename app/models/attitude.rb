class Attitude < Concept

  SYMBOLS = %i{BL TL TR BR}

  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each do |sym|
    define_singleton_method(sym) {ALL.find{|s| s.symbol == sym}}
  end

  def top?; string.starts_with?('T'); end
  def left?; string.ends_with?('L'); end

  def gu; top? ? 'use' : 'get'; end
  def es; left? ? 'energy' : 'strength'; end
  def action; [gu, es].join('_'); end
  def name; action.titleize; end

  def first_letter; gu.first.capitalize; end
  def second_letter; es.first.capitalize; end

  def unhappy; %w{ bored anxious irritable agitated }[index]; end
  def md; top? ? 'mania' : 'depression'; end
  def episode; [unhappy, md].to_phrase.titleize; end

  def happy; %w{ enjoy avoid fix rely\ on }[index]; end
  def mode; %w{ digest flee fight rest }[index]; end
  def real; %w{ empty afraid angry tired }[index]; end

  def pejorative; %w{greed paranoia perfectionism laziness}[index]; end


  def next; self.class.rotate[index]; end
  def previous; self.class.rotate(-1)[index]; end
  def opposite; self.class.rotate(2)[index]; end
  def flip; Attitude.all.without(self).find{|a| a.string.second == self.string.second}; end
  def flop; Attitude.all.without(self).find{|a| a.string.first == self.string.first}; end

  def subtypes; Subtype.all.select{|x| x.attitude == self}; end
  def +(realm); subtypes.find{|x| x.realm == realm}; end

end
