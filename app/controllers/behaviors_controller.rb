class BehaviorsController < ApplicationController

  def show
    @behavior = Behavior.find params[:id]
    @name = @behavior.symbolic_name
    if params[:commit] == 'Use Other Words'
      cookies[@behavior.mbti] = params[@behavior.mbti][0,20]
    end
    if params[:commit] == 'Use Examples'
      cookies[@behavior.mbti] = YAML.load_file('config/my_words.yml')[@behavior.mbti.downcase]
      redirect_to behavior_path(@behavior.path) and return
    end
  end

  def index
    if params[:commit] == 'Use Other Words'
      Behavior.each do |b|
        cookies[b.mbti] = params[b.mbti][0,20]
      end
      set_cookies
    end
    if params[:commit] == 'Use Examples'
      Behavior.each {|b| cookies.delete(b.mbti)}
      set_cookies
      redirect_to behaviors_path and return
    end
    render 'behaviors' and return
  end

end
