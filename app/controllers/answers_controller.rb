class AnswersController < ApplicationController

  def show
    get_words
    @answer = Answer.new params[:id]
    redirect_to type_path(@answer.type_index) and return if @answer.finished?
    @sort = params[:sort]
    if @sort.blank?
      @behaviors = Aspect.all.map(&:linear_behaviors).flatten
    else
      @behaviors =  Phase.linear.map(&:behaviors).flatten
    end
    render 'answer'
  end

end
