class Answer

  def self.first_path; "Q1"; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @question,choices = string.split(":")
    @choices = (choices || "").split("-").collect{|c| c.split("_")}
  end
  attr_reader :question, :choices

  def number; @question.last.to_i ; end
  def finished?; number == 5; end

  def yeses; @choices.select{|c| c.second == "yes"}; end
  def noes; @choices.select{|c| c.second == "no"}; end

  def new_choices(subtype, choice)
    new_yeses = new_yeses(subtype, choice).collect{|s| s.path + "_yes"}
    new_noes = new_noes(subtype, choice).collect{|s| s.path + "_no"}
    (new_yeses + new_noes).join("-")
  end

  def new_noes(subtype, choice)
    if choice == "no"
       (rejected_subtypes << subtype).uniq
    else
       rejected_subtypes.reject{|s| subtype == s}       
    end
  end

  def new_yeses(subtype, choice)
    if choice == "yes"
       (chosen_subtypes.reject{|s| subtype.peers.include?(s)} << subtype).uniq
    else
       chosen_subtypes.reject{|s| subtype == s}       
    end
  end

  def next(subtype, choice); "Q#{new_yeses(subtype, choice).size + 1}:#{new_choices(subtype, choice)}"; end

  def rejected_subtypes; rejected_paths.collect{|path| Subtype.send(path)}; end
  def rejected_paths; noes.map(&:first); end

  def all_rejected_subtypes; rejected_subtypes + chosen_subtypes.map(&:peers).flatten; end

  def chosen_subtypes; chosen_paths.collect{|path| Subtype.send(path)} ; end
  def chosen_paths; yeses.map(&:first); end

  def class(subtype)
    if chosen_subtypes.include? subtype
      "chosen"
    elsif all_rejected_subtypes.include? subtype
      "warning"
    else
      "free"
    end
  end


  def sorted; chosen_subtypes.sort_by{|s| s.attitude.index}; end
  def quad_path; sorted.map(&:realm).join; end

end
