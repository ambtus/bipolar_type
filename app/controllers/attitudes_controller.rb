class AttitudesController < ApplicationController
  def index; end
  def show
    @attitude = Attitude.send params[:id]
    @mbti = @attitude.mbti
    @subtypes = @attitude.subtypes
  end
end
