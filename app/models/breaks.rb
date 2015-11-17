class Breaks < Transition

  ########
  ALL = LETTERS.collect{|letter| self.new letter}
  ########

  def am(realm)
    case signal_location
    when "external"
      realm.fat
    when "internal"
      realm.thin
    end
  end

end
