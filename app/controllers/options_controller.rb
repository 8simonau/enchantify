class OptionsController < ApplicationController
  def new
    @option = Option.new
  end

  def create
    # TODO
    @option = Option.new
    @option.category = "Personnage"
    @option.name = params[:name]
  end
end
