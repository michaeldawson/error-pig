# Returns a list of error counts from Rollbar by day. It returns `number_of_days` days in the past (up to 366).

module Rollbar
  module Reports
    class OccurrenceCountsByDay
      PATH = 'reports/occurrence_counts'.freeze

      def initialize(number_of_days: 7, environments: 'production')
        @number_of_days = number_of_days
        @environments = environments
      end

      def data
        result = Rollbar::API.request(PATH, request_params)['result']
        result.map do |timestamp, count|
          OpenStruct.new(
            day: Date.strptime(timestamp.to_s, '%s'),
            count: count,
          )
        end
      end

      private

      attr_reader :number_of_days, :environments

      def request_params
        {
          buckets: number_of_days,
          environments: environments
        }
      end
    end
  end
end
