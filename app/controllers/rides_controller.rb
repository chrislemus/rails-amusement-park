class RidesController < ApplicationController
  def create
    ride = Ride.new(ride_params)
    user = current_user
    attraction = ride.attraction
    message = ''

    user.tickets -= attraction.tickets
    message += "You do not have enough tickets to ride the #{attraction.name}!" if user.tickets < 0 
    message += "You are not tall enough to ride the #{attraction.name}" if user.height < attraction.min_height
    
    if message.empty?
      user.nausea = attraction.nausea_rating
      user.happiness = attraction.happiness_rating
      user.save
      ride.save
      message = "Thanks for riding the #{attraction.name}!"
    end
    redirect_to user_path(user), flash: { message: message }
  end

  private

  def ride_params
    params.require(:ride).permit(:attraction_id, :user_id)
  end
end
