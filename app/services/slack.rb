# Interface to post messages to slack channels. Hard-coded in slack config to post to one channel only.
class Slack
  def self.post_message(message)
    new(ENV['SLACK_WEBHOOK_URL']).post_message(message)
  end

  def initialize(webhook_url)
    @webhook_url = webhook_url
  end

  def post_message(message)
    Net::HTTP.post_form(URI(webhook_url), payload: { text: message }.to_json)
  end

  private

  attr_reader :webhook_url
end
