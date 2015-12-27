class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif params[:id] == "outline"
      render :outline
    else
      [Realm, Attitude, Quad].each do |klass|
        if klass.paths.include?(params[:id])
          @object = klass.send(params[:id])
        end
      end
    end
  end

end
