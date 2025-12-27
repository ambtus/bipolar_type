# frozen_string_literal: true

class NaturesController < ApplicationController
  def show
    @number = 4
    @nature = Nature.find params[:id]
    @title = "#{@nature.title} Nature"
    @manic_realm = @nature.realms.third
    render 'nature'
  end
end
