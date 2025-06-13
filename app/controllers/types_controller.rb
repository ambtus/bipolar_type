class TypesController < ApplicationController

  def show
    @type = Type.find_by params[:id]
    @bl=@type.realms.first
    @tl=@type.realms.second
    @tr=@type.realms.third
    @br=@type.realms.fourth

    @show = params[:format] || 'bold'
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
    when 'all'
      @subtypes = Subtype.all
    else
      @subtypes = Realm.find_by(@show).subtypes
    end
    Rails.logger.debug "subtypes #{@subtypes}"
    render 'type'
  end

  def me
    redirect_to action: 'show', id: Type.my_path
  end
end
