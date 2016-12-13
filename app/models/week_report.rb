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
    [errors_message, final_encouragement, piggy_fact_message].compact.join("\n")
  end

  def errors_message
    "Last week, we had #{this_weeks_errors} errors, #{delta_message} #{last_weeks_errors} the week before."
  end

  def piggy_fact_message
    return unless piggy_fact.present?
    "\n By the way, did you know... #{piggy_fact.fact}"
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

  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
  # Bite me. If this app becomes wildy profitable, I'll fix it.
  def delta_message
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
      Encouragement.negative
    else
      Encouragement.positive
    end
  end

  def piggy_fact
    @piggy_fact ||= PiggyFact.best_fact
  end
end
