class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def convert_to_second? time
    time = time.split(":").map(&:to_i)
    time[0]*3600 + time[1]*60 + time[2]
  end
end
