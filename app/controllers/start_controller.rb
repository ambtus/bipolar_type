class StartController < ApplicationController

  def balance; get_words; end

  def examples
    if params[:commit] == 'Reset All Examples'
      Behavior.mbtis.each {|key| cookies.delete(key)}
      Rails.logger.debug "cookies: #{cookies.to_h}"
      redirect_to example_path(anchor: 'form') and return
    elsif params[:commit] == 'Load Examples'
      get_my_words
      Behavior.mbtis.each {|key| cookies[key] = @words[key]}
      Rails.logger.debug "cookies: #{cookies.to_h}"
      redirect_to example_path(anchor: 'form') and return
    elsif params[:commit] == 'Save Examples'
      get_words
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
      redirect_to example_path(new.permit(Behavior.mbtis))+'#form' and return
    else
      get_words
      Behavior.mbtis.each do |key|
        cookies[key] = params[key] unless params[key].blank?
      end
    end
  end

end
