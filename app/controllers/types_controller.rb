class TypesController < ApplicationController

  def show
    @type = Type.find_by params[:id]
    @bl=@type.realms.first
    @tl=@type.realms.second
    @tr=@type.realms.third
    @br=@type.realms.fourth
    @realm = params[:format] && Realm.find_by(params[:format])
    if @realm.blank? && params[:format]
      case params[:format]
      when 'bold'
        @subtypes = @type.subtypes
      when 'italic'
        @subtypes = @type.subtypes.map(&:opposite)
      when 'plain'
        @subtypes = @type.subtypes.map(&:flip)
      when 'strike'
        @subtypes = @type.subtypes.map(&:flop)
      end
      Rails.logger.debug "subtypes #{@subtypes}"
    end
    render 'type'
  end

  def me
    redirect_to action: 'show', id: Type.my_path
  end
end
