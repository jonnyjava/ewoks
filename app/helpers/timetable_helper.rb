module TimetableHelper
  def morning_times
    times = base_times
    (0..11).each do |h|
      times << "0#{h}:00".last(5)
      times << "0#{h}:30".last(5)
    end
    times
  end

  def afternoon_times
    times = base_times
    (12..23).each do |h|
      times << "#{h}:00"
      times << "#{h}:30"
    end
    times << '24:00'
    times
  end

  def base_times
    ['', 'Cerrado']
  end
end
