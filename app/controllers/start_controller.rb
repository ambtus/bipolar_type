class StartController < ApplicationController
  def intro; @title = 'Introduction'; end
  def theory; @title = 'The Theory'; end
  def mbti; @title = 'MBTI Comparison'; end
  def hours; @type=Type.new(params[:id]); @title = 'Hours'; end
  def months; @type=Type.new(params[:id]); @title = 'Seasons'; end
end
