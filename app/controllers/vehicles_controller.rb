class VehiclesController < ApplicationController

  before_action :authenticate_user!

  def create
    @vehicle = current_user.vehicles.new(vehicle_params)
    if @vehicle.save
      flash[:success] = "#{@vehicle.year} #{@vehicle.make} #{@vehicle.model} Saved"
      redirect_to :back
    else
      flash[:error] = "There were errors saving your vehicle. #{@vehicle.errors.full_messages.to_sentence}"
      redirect_to :back
    end
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:year, :make, :model, :trim, :transmission, :engine, :exterior_color, :interior_color, :comments)
  end
end
