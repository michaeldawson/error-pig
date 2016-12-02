# The 'stub_service' helper can be used to stub out external services to return the contents of a fixture file, or any
# other response body or status. When used without arguments, `stub_service(:facebook)`, it will open the file at
# spec/fixtures/services/facebook, and return its contents with status 200 for all requests to the endpoint specified
# in the SERVICES_MAP. As you can see, various options can be overriden when setting up this stub.

module WebMockHelpers
  SERVICES_MAP = {
    rollbar_occurrence_counts: { url: %r{https://api.rollbar.com/api/1/reports/occurrence_counts} },
  }.freeze

  # rubocop:disable Metrics/ParameterLists
  # Having a lot of arguments isn't very pretty, but in this case, you need only override the ones you're interested in!
  def stub_service(name, status: 200, method: :get, headers: {}, query: nil, response_body: nil, response_fixture: nil)
    service = SERVICES_MAP[name]
    raise "No service #{name}" unless service.present?

    response_body = load_fixture(response_fixture || name) if response_body.nil?
    headers = service[:default_headers] if headers.blank?

    stub = stub_request(method, service[:url])
    stub.with(query: query) if query.present?
    stub.to_return(status: status, body: response_body, headers: headers)
  end

  def assert_service_requested(method, name)
    expect(a_request(method, SERVICES_MAP[name][:url])).to have_been_made
  end

  def load_fixture(fixture)
    filepath = File.join('spec', 'fixtures', 'services', fixture.to_s)
    File.read(filepath).strip
  end
end

RSpec.configure do |config|
  config.include WebMockHelpers
end
