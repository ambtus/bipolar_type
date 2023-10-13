class Type

  def self.my_path; 'UAE•GPE•GMS•UFS' ; end
  def self.my_type; self.new my_path; end
  def nurture_path; Rails.application.routes.url_helpers.nurture_path(Nurture.jump_path(behaviors)); end

  def initialize(string)
    parts = string.split('•')
    @behaviors = parts[0,4].collect{|x| Behavior.send(x)}
    @behaviors.check_constraints Behavior, 4, 4
    @realms = @behaviors.map(&:realm)
    @realms.check_constraints Realm, 4, 4
    @phases = @behaviors.map(&:phase)
    @phases.check_constraints Phase, 4, 4
    @hour = Hours.send(parts.fifth) rescue Hours.generic
    set_symbol
  end
  attr_reader :symbol, :behaviors, :realms, :phases, :hour

  def inspect; @symbol; end
  def name; inspect; end

  def set_symbol
     hour_symbol = @hour.generic? ? nil : @hour.symbol
     @symbol = [*behaviors.map(&:symbol), hour_symbol].compact.join('•');
     self
  end

  def set_hour(avian); @hour = avian; set_symbol; end
  def hours_range(phase); hour.range(phase); end
  def start_time(phase); hour.start_time(phase); end

  def description
    [behaviors.first.partial_episode, 'with', behaviors.second.partial_episode].to_phrase
  end

  def reds;   behaviors.values_at(1,3); end
  def ambers; behaviors.values_at(2).map(&:balancer) +
              behaviors.values_at(3).map(&:displacer) +
              behaviors.values_at(0,2).map(&:opposite) ; end
  def greens; behaviors.values_at(0,1).map(&:balancer) +
              behaviors.values_at(0,1).map(&:displacer); end

  def blues; Behavior.all - reds - ambers - greens; end

  def colors; [greens, ambers, reds]; end
  def color_hash; [colors, (0..2).to_a].transpose.to_h; end

  def quick(phase, index); color_hash.invert[index].select{|b| b.phase == phase}; end

  def color_index;  h={}; color_hash.each {|k,v| k.each{|b| h[b] = v}}; h; end
  def color(behavior); %w{green amber red}[color_index[behavior]]; end

  def advice(b); ['Do ', 'And do ', 'But don’t '][color_index[b]] + b.aka.squish.unwrap; end

end

