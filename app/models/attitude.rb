class Attitude < Concept

# Issue:
# The linear wake→awake→sleep→asleep (abcd)
# is not the same as the circular
# wake→ awake↓
# ↑asleep ←sleep
# (ab - new row - dc)

  ########
  ACRONYMS = %w{a b d c}
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each do |letter|
    define_singleton_method(letter) {ALL[ACRONYMS.index(letter)]}
  end
  ########

  def self.linear; ALL.values_at(0,1,3,2); end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  def behavior
    case path
    when "a"
      "wake up"
    when "b"
      "stay active"
    when "c"
      "relax"
    when "d"
      "stay calm"
    end
  end
  def goal; "I want to #{behavior}"; end
  def problem; "I cannot #{behavior}"; end

  def state
    case path
    when "a", "c"
      "neither restless nor fatigued"
    when "b", "d"
      "both restless and fatigued"
    end
  end

  def episode
    case path
    when "a", "b"
      "depression"
    when "c", "d"
      "mania"
    end
  end

end
