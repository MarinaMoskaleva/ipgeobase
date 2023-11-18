# frozen_string_literal: true

require_relative "../test_helper"
# Test class for the Ipgeobase module.
class TestIpgeobase < TestCase
  BASE_URL = "http://ip-api.com/xml/"
  GOOGLE_IP = "8.8.8.8"

  def test_that_it_has_a_version_number
    refute_nil ::Ipgeobase::VERSION
  end

  def test_that_ip_is_incorrect
    assert_raises ArgumentError do
      Ipgeobase.lookup(nil)
    end
    assert_raises ArgumentError do
      Ipgeobase.lookup("")
    end
    assert_raises ArgumentError do
      Ipgeobase.lookup("invalid_ip")
    end
  end

  def test_fetches_data_from_api
    stub_request_data

    data = Ipgeobase.lookup(GOOGLE_IP)
    actual_data = [
      data.city,
      data.country,
      data.country_code,
      data.lat,
      data.lon
    ]
    assert { expected_data == actual_data }
  end

  private

  def stub_request_data
    stub_request(:get, "#{BASE_URL}#{GOOGLE_IP}")
      .to_return(status: 200, body: load_fixture("response.xml"), headers: {})
  end

  def expected_data
    [
      "Ashburn",
      "United States",
      "US",
      39.03,
      -77.5
    ]
  end
end
