namespace :report do
  # Set up a daily task that returns early unless it's on a Monday. This is to get around Heroku's limitations with its
  # free scheduler. It runs on a Monday morning, and passes a day from last week to get last week's report.
  task daily: :environment do
    return unless Time.now.in_time_zone('Melbourne').to_date.monday?

    WeekReport.new(5.days.ago).perform
  end
end
