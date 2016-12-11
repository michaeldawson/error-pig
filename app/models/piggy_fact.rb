class PiggyFact < ApplicationRecord
  validates :fact, presence: true

  def self.best_fact
    fact = find_by(last_used: nil)
    return unless fact.present?
    fact.update!(last_used: Time.zone.now)
    fact
  end
end
