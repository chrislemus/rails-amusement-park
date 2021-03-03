class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    # ride = Ride.new(ride_params)
    attraction = self.attraction
    user = self.user
    message = ''
    message += "You do not have enough tickets to ride the #{attraction.name}." if user.tickets < attraction.tickets

    if user.height < attraction.min_height
      message += ' 'if !message.empty?
      message += "You are not tall enough to ride the #{attraction.name}." 
    end

    if message.empty?
      user.tickets -= attraction.tickets
      user.nausea += attraction.nausea_rating
      user.happiness += attraction.happiness_rating
      user.save
      self.save
      message = "Thanks for riding the #{attraction.name}!"
    else
      message = 'Sorry. ' + message 
    end
    

    message
  end
end
