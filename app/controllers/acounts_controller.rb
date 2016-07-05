class AcountsController < ApplicationController

  def new
  	@todoist = Todoist.new
  end
end