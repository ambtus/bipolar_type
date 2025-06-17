class TypesController < ApplicationController

  def index
    render 'types'
  end

  def show
    @type = Type.find params[:id]
    @bl=@type.realms.first
    @tl=@type.realms.second
    @tr=@type.realms.third
    @br=@type.realms.fourth

    @show = params[:format] || 'do'
    Rails.logger.debug "format #{@show}"
    case @show
    when 'bold'
      @subtypes = @type.subtypes
    when 'italic'
      @subtypes = @type.subtypes.map(&:opposite)
    when 'plain'
      @subtypes = @type.subtypes.map(&:flip)
    when 'strike'
      @subtypes = @type.subtypes.map(&:flop)
    when 'do'
      @subtypes = @type.subtypes + @type.subtypes.map(&:flip)
    when 'do not'
      @subtypes = @type.subtypes.map(&:opposite) + @type.subtypes.map(&:flop)
    when 'all'
      @subtypes = Subtype.all
    else
      @subtypes = Realm.find(@show).subtypes
    end
    Rails.logger.debug "subtypes #{@subtypes}"
    render 'type'
  end

  def me
    redirect_to action: 'show', id: Type.my_path
  end
end
