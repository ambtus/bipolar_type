class Answer

  def self.first_path; 'Q1'; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @path = string
    @question,behavior_string = @path.split(':')
    @behavior_string = behavior_string || ''
  end
  attr_reader :question, :path, :behavior_string

  def number; @question.last.to_i ; end
  def index; number - 1; end
  def realm; Realm.all[index]; end
  def finished?; number > 4; end

  def behaviors; @behavior_string.scan(/.../).collect{|s| Behavior.find(s)}; end

  def next(choice); question.next + ':' + @behavior_string + choice.path; end

  def type_path;behaviors.map(&:quadrant).map(&:display).join('•'); end

end
