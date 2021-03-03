class AttractionsController < ApplicationController
  def index
    @attractions = Attraction.all
  end

  def show
    @attraction = Attraction.find(params[:id])
    @ride = @attraction.rides.build(user_id: current_user.id)
  end

  def edit
    @attraction = Attraction.find(params[:id])
  end

  def update
    attraction = Attraction.find(params[:id])
    attraction.update(attraction_params)
    redirect_to attraction_path(attraction)
    # binding.pry
  end

  def new
    @attraction = Attraction.new
  end

  def create
    attraction = Attraction.create(attraction_params)
    if attraction
      redirect_to attraction_path(attraction)
    else
      render 'new'
    end
  end

  private

  def attraction_params
    params.require(:attraction).permit(:name, :min_height, :happiness_rating, :nausea_rating, :tickets)
  end
end
