# Fetch counts of errors on each day for the week, and store them as 'day error counts'.
class WeekErrorCount
  def initialize(week_day)
    @week_end = week_day.end_of_week(:sunday).to_date
  end

  def total_errors
    fetch_day_error_counts unless day_error_counts.count == 7
    day_error_counts.sum(:error_count)
  end

  private

  attr_reader :week_end

  def week_start
    week_end.beginning_of_week(:sunday).to_date
  end

  def day_error_counts
    @day_error_counts ||= DayErrorCount.where(day: week_start..week_end)
  end

  def fetch_day_error_counts
    days_to_fetch = (Date.today.to_date - week_start.to_date).to_i
    raise "Can't report more than 365 days ago" if days_to_fetch > 365
    puts "Fetching data on errors for the past #{days_to_fetch} days"

    Rollbar::Reports::OccurrenceCountsByDay.new(number_of_days: days_to_fetch).data.each do |data|
      DayErrorCount.find_or_initialize_by(day: data.day).update!(error_count: data.count)
    end
  end
end
