class TypeController < ApplicationController

  def show
    if params[:id].blank?
      render :start
    elsif %w{theory realms attitudes}.include? params[:id]
      render params[:id]
    else
      [Realm, Attitude, Subtype, Quad].each do |klass|
        if klass.paths.include?(params[:id])
          @object = klass.send(params[:id])
          render klass.name.downcase
          break
        end
      end
    end
  end

end
