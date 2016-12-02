require 'rails_helper'

RSpec.describe DayErrorCount do
  let(:day_error_count) { described_class.new(valid_attributes) }
  let(:valid_attributes) {
    {
      day: Date.today,
      error_count: 1
    }
  }

  describe 'Validation' do
    it 'should be valid with valid attributes' do
      expect(day_error_count).to be_valid
    end
  end
end
