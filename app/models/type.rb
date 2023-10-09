class Type

  def self.my_path; 'UAE•GMS•UFS•GPE•1' ; end
  def self.my_type; self.new my_path; end

  def initialize(string)
    parts = string.split('•')
    @natures = parts[0,4].collect{|x| Behavior.send(x)}.sort
    @natures.check_constraints Behavior, 4, 4
    @realms = @natures.map(&:realm)
    @realms.check_constraints Realm, 4, 4
    @phases = @natures.map(&:phase)
    @phases.check_constraints Phase, 4, 4
    @bipolar = parts.fifth.to_i rescue 1
    @hours = Hours.send(parts.sixth) rescue Hours.generic
    set_symbol
  end
  attr_reader :symbol, :natures, :realms, :phases, :hours, :bipolar

  def inspect; @symbol; end
  def name; inspect; end

  def set_symbol
     hours_symbol = @hours.generic? ? nil : @hours.symbol
     @symbol = [*natures.map(&:symbol), @bipolar, hours_symbol].compact.join('•');
     self
  end

  def set_hours(avian); @hours = avian; set_symbol; end
  def hours_range(phase); hours.range(phase); end

  def set_bipolar(i); @bipolar = i; set_symbol; end

  def description
    case bipolar
    when 1
      "#{by_phase[1].realm.name} Mania with #{by_phase[3].realm.name} Depression"
    when 2
      "#{by_phase[0].realm.name} Depression with #{by_phase[2].realm.name} Mania"
    end
  end

  def by_phase; Phase.all.collect{|p| natures.find{|b| b.phase == p}}; end

  def by_bipolar
    case bipolar
    when 1
      [natures.second, natures.fourth, natures.first, natures.third]
    when 2
      [natures.first, natures.third, natures.second, natures.fourth]
    end
  end

  def reds; by_bipolar.values_at(2,3); end
  def greens; by_bipolar.values_at(0,1,2).map(&:balancer) + [by_bipolar.third.displacer]; end
  def golds; by_bipolar.values_at(0,1) + by_bipolar.values_at(2,3).map(&:opposite); end
  def blues; by_bipolar.values_at(0,1,3).map(&:displacer) + by_bipolar.values_at(0,1).map(&:opposite) + [by_bipolar.fourth.balancer]; end

  def red(phase); reds.select{|b| b.phase == phase}; end
  def green(phase); greens.select{|b| b.phase == phase}; end
  def gold(phase); golds.select{|b| b.phase == phase}; end
  def blue(phase); blues.select{|b| b.phase == phase}; end
end

