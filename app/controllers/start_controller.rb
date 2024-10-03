class StartController < ApplicationController

  def realms
    if params[:commit] == 'Reset All Verbs'
      Function.cookies.each {|key| cookies.delete(key)}
      cookies.delete('mine')
      redirect_to realms_path(anchor: 'form') and return

    elsif params[:commit] == 'Load Verbs'
      get_my_verbs
      redirect_to realms_path(anchor: 'form') and return

    elsif params[:commit] == 'Save Verbs'
      set_verbs
      dups = []
      Function.cookies.each do |key|
        if @verbs[key] == params[key]
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
      set_verbs
      Function.cookies.each do |key|
        cookies[key] = params[key] unless params[key].blank?
      end
    end
  end

end
