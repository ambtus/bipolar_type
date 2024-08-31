class StartController < ApplicationController

  def specifics
    if params[:commit] == 'Clear Cookies'
      cookies.clear
      redirect_to specifics_path and return
    elsif params[:commit] == 'Save Cookies'
      old = YAML.load_file('config/my_words.yml')
      dups = []
      Behavior.mbtis.each do |key|
        if old[key] == params[key]
          dups << key
        end
        if params[key].blank?
          dups << key
          cookies.delete(params[key])
        end
      end
      Rails.logger.debug "dups: #{dups}"
      new = params.without('commit').without(*dups)
      Rails.logger.debug "new: #{new}"
      redirect_to specifics_path(new.permit(Behavior.mbtis)) and return
    else
      Behavior.mbtis.each do |key|
        cookies[key] = params[key] unless params[key].blank?
      end
    end
  end

end
