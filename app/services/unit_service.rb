class UnitService
  def initialize params
    @params = params
  end

  def auto_create_unit
    @params[:morning_count_unit].to_i.times do |i|
      time_start = convert_to_second(@params[:morning_time_start]) + i * (@params[:morning_time_unit].to_i + @params[:morning_time_relax].to_i) * 60
      time_end = time_start + @params[:morning_time_unit].to_i * 60
      Unit.create(
        numunit: i + 1,
        time_start: second_to_string(time_start),
        time_end: second_to_string(time_end)
      )
    end
    @params[:afternoon_count_unit].to_i.times do |i|
      time_start = convert_to_second(@params[:afternoon_time_start]) + i * (@params[:afternoon_time_unit].to_i +
          @params[:afternoon_time_relax].to_i) * 60
      time_end = time_start + @params[:afternoon_time_unit].to_i * 60
      Unit.create(
        numunit: i + 1 + @params[:morning_count_unit].to_i,
        time_start: second_to_string(time_start),
        time_end: second_to_string(time_end)
      )
    end
  end

  def convert_to_second time
    time = time.split(":").map(&:to_i)
    time[0] * 3600 + time[1] * 60 + time[2]
  end

  def second_to_string second
    second = second.to_i
    h = (second / 3600).floor
    m = ((second - (h * 3600)) / 60).floor
    s = second - (h * 3600) - (m * 60)
    "#{format('%02d', h)}:#{format('%02d', m)}:#{format('%02d', s)}"
  end
end
