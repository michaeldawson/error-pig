class DayErrorCount < ApplicationRecord
  validates :day, presence: true, uniqueness: true
  validates :error_count, presence: true
end
