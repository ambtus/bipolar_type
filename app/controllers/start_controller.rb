class StartController < ApplicationController
  def theory; @title = 'The Theory'; end
  def hours
    @type=Type.new(params[:id])
    @title = 'Hours'
    @initial = params[:id].split('•').size == 4
  end
end
