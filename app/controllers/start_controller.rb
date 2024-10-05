class StartController < ApplicationController

  def realms
    if params[:commit] == 'Reset All Words'
      Function.cookies.each {|key| cookies.delete(key)}
      cookies.delete('mine')
      redirect_to realms_path(anchor: 'form') and return

    elsif params[:commit] == 'Load Words'
      get_my_words
      redirect_to realms_path(anchor: 'form') and return

    elsif params[:commit] == 'Save Words'
      set_words
      dups = []
      Function.cookies.each do |key|
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
      redirect_to realms_path(new.permit(Function.cookies))+'#form' and return
    else
      set_words
      Function.cookies.each do |key|
        cookies[key] = params[key] unless params[key].blank?
      end
    end
  end

  def bipolar
    if params[:commit] == 'Reset All Words'
      State.cookies.each {|key| cookies.delete(key)}
      cookies.delete('mine')
      redirect_to bipolar_path(anchor: 'form') and return

    elsif params[:commit] == 'Load Words'
      get_my_words
      redirect_to bipolar_path(anchor: 'form') and return

    elsif params[:commit] == 'Save Words'
      set_words
      dups = []
      State.cookies.each do |key|
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
      redirect_to bipolar_path(new.permit(State.cookies))+'#form' and return
    else
      set_words
      State.cookies.each do |key|
        cookies[key] = params[key] unless params[key].blank?
      end
    end
  end

end
