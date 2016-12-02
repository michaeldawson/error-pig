require 'rails_helper'

RSpec.describe WeekReport do
  let(:week_report) { described_class.new(this_week_end) }
  let(:this_week_end) { Time.now } # The end of this week, not this 'weekend'

  context 'when this week, we had a lot more errors than last week' do
    let(:last_week_end) { this_week_end - 7.days }

    before do
      allow(WeekErrorCount).to receive(:new).with(this_week_end).and_return(double(:week_error_count, total_errors: 10))
      allow(WeekErrorCount).to receive(:new).with(last_week_end).and_return(double(:week_error_count, total_errors: 2))
    end

    it 'posts an appropriate message to slack' do
      expect(Slack).to receive(:post_message).with(
        "This week, we had 10 errors, a big increase of 400% from last week's 2. Let's make next week a great one!"
      )

      week_report.perform
    end
  end
end
