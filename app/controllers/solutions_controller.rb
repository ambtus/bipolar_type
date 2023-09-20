class SolutionsController < ApplicationController
  def index; end
  def show
    if params[:id].length == 2
      @solution = GenericSolution.send params[:id]
    else
      @solution = Solution.send params[:id]
    end
    @name = @solution.name
  end
end
