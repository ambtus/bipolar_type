class StartController < ApplicationController
  def index; end
  def show; @types = Type.all; end
end
