class TypesController < ApplicationController
  def index
    @sort_index = params[:sort].to_i || 0
    @types = Type.sort_by(@sort_index)
    render 'types'
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
    redirect_to action: 'show', id: Type.my_path
  end
end
