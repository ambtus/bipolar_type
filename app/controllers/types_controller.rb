class TypesController < ApplicationController

  def index
    @unhappy = params[:format] || 'bored'
    @types = Type.sort_by(@unhappy)
    render 'types'
  end

  def show
    @type = Type.find params[:id]
    @legend = {
      "dos"=>"do this",
      "donts"=>"instead of that",
      "mores"=>"so you can do more of this",
      "episodes"=>"and less of that"
    }
    @solution = %w{mores dos donts episodes}

    @show = params[:format] || 'dos'
    Rails.logger.debug "format #{@show}: included? #{@legend.keys.include?(@show)}"
    @subtypes = if @legend.keys.include?(@show)
        @type.send(@show)
      elsif Realm.strings.include?(@show)
        @realm = true
        Realm.find(@show).subtypes
      elsif Attitude.strings.include?(@show)
        Attitude.find(@show).subtypes
      else
        Subtype.all
    end
    Rails.logger.debug "subtypes: #{@subtypes}"
    render 'type'
  end

  def me
    redirect_to action: 'show', id: Type.my_path
  end
end
