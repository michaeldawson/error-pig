class WeekReport
  def initialize(week_end)
    @week_end = week_end
  end

  def perform
    Slack.post_message(message)
  end

  private

  attr_reader :week_end

  def message
    "This week, we had #{this_weeks_errors} errors, #{increase_or_decrease_message} last week's #{last_weeks_errors}. #{final_encouragement}"
  end

  def this_weeks_errors
    @this_weeks_errors ||= WeekErrorCount.new(week_end).total_errors
  end

  def last_weeks_errors
    @last_weeks_errors ||= WeekErrorCount.new(week_end - 7.days).total_errors
  end

  def percentage_difference
    @percentage_difference ||= begin
      greater = [this_weeks_errors, last_weeks_errors].max
      lesser = [this_weeks_errors, last_weeks_errors].min

      (((greater.to_f / lesser) - 1).abs * 100).round
    end
  end

  def increase_or_decrease_message
    if this_weeks_errors > last_weeks_errors
      if percentage_difference > 25
        "a big increase of #{percentage_difference}% from"
      elsif percentage_difference < 5
        "a slight increase of #{percentage_difference}% from"
      else
        "up #{percentage_difference}% from"
      end
    elsif last_weeks_errors > this_weeks_errors
      if percentage_difference > 25
        "a huge decrease of #{percentage_difference}% from"
      elsif percentage_difference < 5
        "a slight decrease of #{percentage_difference}% from"
      else
        "down #{percentage_difference}% from"
      end
    else
      "no change (what are the odds!?!) from"
    end
  end

  def final_encouragement
    if this_weeks_errors > last_weeks_errors
      "Let's make next week a great one!"
    else
      "Let's keep it up!"
    end
  end
end
