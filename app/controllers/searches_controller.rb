class SearchesController < ApplicationController
  def new
    @search = Search.new
    @locations = Car.all.distinct.pluck(:location)
  end

  def create
    @search = Search.create(search_params)
    redirect_to @search
  end

  def show
    @search = Search.find(params[:id])
  end

  private
  def search_params
    params.require(:search).permit(:name, :style, :location, :carstatus)
  end
end
