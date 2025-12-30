# frozen_string_literal: true

class BipolarsController < ApplicationController
  def show
    @number = 5
    @bipolar = Bipolar.find params[:id]
    @type = @bipolar.type
    @title = @bipolar.title
    render 'bipolar'
  end

  def me
    redirect_to action: 'show', id: Bipolar.mine.path
  end
end
