module ApplicationHelper

  def friendly_time(time)
    time.strftime("%m/%d/%y, %I:%M %p")
  end
end
