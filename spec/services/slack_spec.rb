require 'rails_helper'

RSpec.describe Slack do
  describe '.post_message' do
    let(:message) { 'Hey slackers - get back to work.' }
    let!(:stubbed_request) { stub_request(:post, ENV['SLACK_WEBHOOK_URL']) }

    it 'sends a message to slack' do
      Slack.post_message(message)
      expect(stubbed_request.with(body: { payload: { text: message }.to_json })).to have_been_made.once
    end
  end
end
