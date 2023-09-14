class SolutionsController < ApplicationController
  def index; @solutions = Solution.all; end
  def show
    @solution = Solution.send params[:id]
    @subtypes = @solution.subtypes
  end
end
