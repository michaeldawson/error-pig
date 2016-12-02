namespace :report do
  task weekly: :environment do
    WeekReport.new(Time.now.in_time_zone('Melbourne')).perform
  end
end
