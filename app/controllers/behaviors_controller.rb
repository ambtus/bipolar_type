class BehaviorsController < ApplicationController

  def show
    @behavior = Behavior.find params[:id]
    @name = @behavior.symbolic_name
    if params[:commit] == 'Use Other Words'
      cookies[@behavior.display] = params[@behavior.display][0,20]
    end
    if params[:commit] == 'Use Default Words'
      cookies[@behavior.display] = YAML.load_file('config/my_words.yml')[@behavior.display.downcase]
      redirect_to behavior_path(@behavior.path) and return
    end
  end

  def index
    if params[:commit] == 'Use Other Words'
      Behavior.each do |b|
        cookies[b.display] = params[b.display][0,20]
      end
      set_cookies
    end
    if params[:commit] == 'Use Default Words'
      Behavior.each {|b| cookies.delete(b.display)}
      set_cookies
      redirect_to behaviors_path and return
    end
    render 'behaviors' and return
  end

end
