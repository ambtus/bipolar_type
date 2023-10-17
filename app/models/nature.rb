class Nature

  def self.first_path; "Q1"; end
  def self.first; new(first_path); end

  def self.jump_path(*answers); "Q#{answers.size + 1}:#{answers.map(&:symbol).join}"; end

  def initialize(string)
    @question,@answer_paths = string.split(":")
    @answer_paths = @answer_paths || ""
  end

  def number; @question.without('Q').to_i ; end
  def index; number - 1; end
  def finished?; number > 24; end

  def all_questions; Realm::SYMBOLS.multiply(%w{a b c d e f}).flatten; end

  def answered_questions; @answer_paths.scan(/.../).collect{|x| Answer.new(x)}; end

  def available_questions; all_questions - answered_questions.map(&:question_set) ; end

  def question; Answer.new(available_questions.sample); end


  def next(answer); "Q#{number.next}:#{@answer_paths}#{answer}"; end

  def results; answered_questions.map(&:answer_set).hash_for_mode.select{|k,v| v> 3}.keys; end

  def behaviors; results.collect{|rp| Realm.send(rp.first) + Phase.all[rp.second.to_i]}; end

  def type_path; behaviors.sort.map(&:symbol).join('•'); end

end
