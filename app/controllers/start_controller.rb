class StartController < ApplicationController
  def home; @title = 'Introduction'; end
  def theory; @title = 'The Theory', @class = "center", @omit = "true"; end
  def story; @title = 'My Story'; end
end
