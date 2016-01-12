class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif %w{realms attitudes}.include? params[:id]
      render params[:id]
    else
      [Realm, Attitude, Quad].each do |klass|
        if klass.paths.include?(params[:id])
          @object = klass.send(params[:id])
          render :show and return
        end
      end
      raise "#{params[:id]} is not a realm, attitude, or quad"
    end
  end

end
