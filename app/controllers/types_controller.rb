class TypesController < ApplicationController
  def index
    set_words
    @sort_index = params[:sort].to_i || 0
    @types = Type.sort_by(@sort_index)
  end

  def show
    @type = Type.find params[:id]
    case params[:commit]
      when 'Load My Words'
        get_my_words
      when 'Reset Words'
        Rails.logger.debug 'hello'
        Function.cookies.each {|key| cookies.delete(key)}
        cookies.delete('mine')
    end
    Rails.logger.debug 'goodbye'
    render 'type'
  end

  def me
    get_my_words
    redirect_to action: 'show', id: Type.my_path
  end
end
