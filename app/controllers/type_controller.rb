class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif %w{overview bipolar realms attitudes}.include? params[:id]
      render params[:id]
    elsif Attitude.paths.include?(params[:id]) 
        @attitude = Attitude.send(params[:id])
        render :attitude
    else
      [Realm, Quad].each do |klass|
        if klass.paths.include?(params[:id])
          @object = klass.send(params[:id])
          render :show and return
        end
      end
      raise "#{params[:id]} is not a realm or quad path"
    end
  end

end
