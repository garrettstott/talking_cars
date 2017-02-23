class SharedController < ApplicationController
  def home
    flash.now[:notice] = 'This is a test of the flash messages.'
    @edmunds = HTTParty.get('http://api.edmunds.com/api/vehicle/v2/makes?fmt=json&api_key=jstqruuvgg5bhzrk9v393svu')
    @makes = @edmunds['makes']
  end
end
