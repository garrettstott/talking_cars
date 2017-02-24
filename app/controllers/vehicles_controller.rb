class VehiclesController < ApplicationController

  before_action :authenticate_user!

  def create
    @vehicle = current_user.vehicles.new(vehicle_params)
    if @vehicle.save
      flash[:success] = "#{@vehicle.year} #{@vehicle.make} #{@vehicle.model} Saved"
      redirect_back(fallback_location: user_show_path(current_user))
    else
      flash[:error] = "There were errors saving your vehicle. #{@vehicle.errors.full_messages.to_sentence}"
      redirect_back(fallback_location: user_show_path(current_user))
    end
  end

  def update
    @vehicle = Vehicle.find(params[:id])
    name = "#{@vehicle.year} #{@vehicle.make} #{@vehicle.model}"
    if @vehicle.update(vehicle_params)
      flash[:success] = "#{name} was updated successfully"
      redirect_back(fallback_location: user_show_path(current_user))
    else
      flash[:error] = "There were errors updating #{name} #{@vehicle.errors.full_messages.to_sentence}"
      redirect_back(fallback_location: user_show_path(current_user))
    end
  end

  def destroy
    @vehicle = Vehicle.find(params[:id])
    name = "#{@vehicle.year} #{@vehicle.make} #{@vehicle.model}"
    if @vehicle.destroy
      flash[:success] = "#{name} was deleted successfully"
      redirect_back(fallback_location: user_show_path(current_user))
    else
      flash[:error] = "There were errors deleting #{name} #{@vehicle.errors.full_messages.to_sentence}"
      redirect_back(fallback_location: user_show_path(current_user))
    end
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:year, :make, :model, :trim, :transmission, :engine, :exterior_color, :interior_color, :comments)
  end
end
