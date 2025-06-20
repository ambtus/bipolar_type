class TypesController < ApplicationController

  def index
    @current = params[:format] || ''
    if @current.length == 12
      type = Type.find_by_tlas(@current)
      redirect_to action: 'show', id: type.path
    else
      @free = Subtype.without(@current)
      render 'types'
    end
  end

  def show
    @type = Type.find params[:id]
    @show = params[:format] || 'all'
    @subtypes = if Realm.strings.include?(@show)
        @realm =  Realm.find(@show)
        @realm.subtypes
      elsif Attitude.strings.include?(@show)
        @attitude = Attitude.find(@show)
        @attitude.subtypes
      else
        Subtype.all
    end
    Rails.logger.debug {"subtypes: #{@subtypes}"}
    render 'type'
  end

  def me
    redirect_to action: 'show', id: Type.my_path
  end
end
