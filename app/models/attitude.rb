class Attitude < Concept

  SYMBOLS = %i{BL TL TR BR}

  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each do |sym|
    define_singleton_method(sym) {ALL.find{|s| s.symbol == sym}}
  end

  def self.linear; ALL.values_at(2,1,3,0); end

  def top?; string.starts_with?('T'); end
  def left?; string.ends_with?('L'); end
  def diagonal?; %w{BL TR}.include?(string); end

  def gu; top? ? 'use' : 'get'; end
  def es; left? ? 'energy' : 'strength'; end
  def action; [gu, es].join('_'); end

  def first_letter; gu.first.capitalize; end
  def second_letter; es.first.capitalize; end

  def real; %w{ hunger fear anger exhaustion }[index]; end # I feel
  def prep; %w{ for    of     at     of   }[index]; end
  def react; %w{ digest flee fight rest }[index]; end
  def name; react.capitalize; end
  def finish; %w{ refuel escape win recover }[index]; end

  def unhappy; %w{ appetite anxiety irritation lethargy }[index]; end

  def ms; diagonal? ? 'mild' : 'severe'; end
  def md; top? ? 'mania' : 'depression'; end
  def episode; [ms, md].to_phrase.titleize; end

  def bad; %w{greedy paranoid hateful lazy}[index]; end

  def flip; Attitude.all.without(self).find{|a| a.string.second == self.string.second}; end
  def flop; Attitude.all.without(self).find{|a| a.string.first == self.string.first}; end

  def subtypes; Subtype.all.select{|x| x.attitude == self}; end
  def +(realm); subtypes.find{|x| x.realm == realm}; end

end
