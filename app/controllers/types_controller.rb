class TypesController < ApplicationController
  def index
    @current = params[:format] || ''
    suffix = @current.blank? ? '' : ' with ' + params[:format].scan(/.../).sort.and
    @title = 'BipolarTypes' + suffix
    if @current.length == 9
      @type = Type.find_by(tlas: @current)
      @title = @type.title
      @show = 'all'
      @all = true
      render 'type'
    else
      @free = Subtype.without(@current)
      render 'types'
    end
  end

  def show
    @type = Type.find params[:id]
    @title = @type.title
    @show = params[:format] || 'all'
    @subtypes = if Realm.strings.include?(@show)
                  @realm = Realm.find(@show)
                  @realm.subtypes
                elsif Attitude.strings.include?(@show)
                  @attitude = Attitude.find(@show)
                  @attitude.subtypes
                else
                  @all = true
                  Subtype.all
                end
    Rails.logger.debug { "subtypes: #{@subtypes}" }
    render 'type'
  end

  def me
    redirect_to action: 'show', id: Type.my_path
  end
end
