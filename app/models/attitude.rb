class Attitude < Concept

  SYMBOLS = %i{BL TL TR BR}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each do |sym|
    define_singleton_method(sym) {ALL.find{|s| s.symbol == sym}}
  end

  def first?; symbol == :BL; end
  def top?; string.starts_with?('T'); end
  def left?; string.ends_with?('L'); end
  def diagonal?; %i{BL TR}.include?(symbol); end

  def gu; %w{get burn use recover}[index]; end
  def es; left? ? 'energy' : 'strength'; end
  def action; [gu, es].join('_'); end
  def do_something; [gu, es].to_phrase; end

  def first_letter; gu.first.capitalize; end
  def second_letter; es.first.capitalize; end

  def daytime; %w{ morning noon afternoon evening}[index]; end
  def season; %w{ spring summer fall winter}[index]; end
  def time; [season, daytime].to_phrase.titleize; end

  def feel; %w{ hunger fear anger tired }[index]; end
  def feeling; %w{ hungry afraid angry sore }[index]; end
  def react; %w{ digest flee fight rest }[index]; end
  def name; react.capitalize; end
  def finish; %w{ refuel escape win relax }[index]; end
  def bad; %w{greedy paranoid hateful lazy}[index]; end
  def bipolar_result; %w{ explode die collapse stagnate}[index]; end

  def md; top? ? 'mania' : 'depression'; end
  def description; %w{ major euphoric irritable agitated }[index]; end
  def episode; [description, md].to_phrase.titleize; end

  def flip; Attitude.all.without(self).find{|a| a.string.second == self.string.second}; end
  def flop; Attitude.all.without(self).find{|a| a.string.first == self.string.first}; end

  def subtypes; Subtype.all.select{|x| x.attitude == self}; end
  def +(realm); subtypes.find{|x| x.realm == realm}; end

end
