require 'rails_helper'

RSpec.describe Rollbar::Reports::OccurrenceCountsByDay do
  let(:report) { described_class.new(number_of_days: 7) }

  before do
    stub_service(:rollbar_occurrence_counts, response_fixture: 'rollbar_occurrence_counts_by_day')
  end

  describe '#data' do
    it 'does a thing' do
      data = report.data

      expect(data.first.day).to eq(Date.parse('Sat, 26 Nov 2016'))
      expect(data.first.count).to eq(62)

      expect(data.count).to eq(7)
    end
  end
end
