class TypesController < ApplicationController

  def show
    @type = Type.find params[:id]
    Rails.logger.debug 'start cookies'
    words = Rails.application.config_for(:words)
    words.keys.each do |k|
      if params.has_key? k
        if params[k].blank? || (params[k] == words[k])
          cookies.delete(k)
        else
          cookies[k] = params[k]
        end
      end
    end
    Rails.logger.debug 'stop cookies'
    @url = type_path(@type.path, cookies.to_hash.without('settings'))
    render 'type'
  end

  def me
    redirect_to action: 'show', id: Type.my_path
  end
end
