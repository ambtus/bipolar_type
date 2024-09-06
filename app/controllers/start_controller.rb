class StartController < ApplicationController

  def words
    get_words
    if params[:commit] == 'Clear All Cookies'
      Behavior.mbtis.each {|key| cookies.delete(key)}
      redirect_to word_path and return
    elsif params[:commit] == 'Change Words'
      dups = []
      Behavior.mbtis.each do |key|
        if @words[key] == params[key]
          dups << key
        end
        if params[key].blank?
          dups << key
          Rails.logger.debug "removing #{key}"
          cookies.delete(key)
        end
      end
      Rails.logger.debug "dups: #{dups}"
      new = params.without('commit').without(*dups)
      Rails.logger.debug "new: #{new}"
      redirect_to word_path(new.permit(Behavior.mbtis)) and return
    else
      Behavior.mbtis.each do |key|
        cookies[key] = params[key] unless params[key].blank?
      end
    end
  end

end
