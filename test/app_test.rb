ENV['APP_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'
require_relative '../app'

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app = GiftingCircleSim

  def setup = Seeds.reset!

  def test_seed_creates_one_circle_of_seven
    assert_equal 1, Circle.count
    assert_equal 7, User.count
    assert_equal 7, User.insiders.count
  end

  def test_next_round_splits_circle
    Circle.next_round!

    assert_equal 3, Circle.count
    assert_equal 15, User.count
    assert_equal 1, User.received.count
    assert_equal 8, User.sent.count
    active = Circle.all.select(&:active?)
    assert_equal 2, active.size
    active.each do |c|
      assert_equal [1, 2, 2, 3, 3, 3, 3], c.users.map(&:level).sort
    end
  end

  def test_rounds_double_active_circles
    3.times { Circle.next_round! }
    assert_equal 8, Circle.all.count(&:active?)
    assert_equal 7, User.received.count
  end

  def test_home_page
    get '/'
    assert last_response.ok?
    assert_includes last_response.body, 'First Circle'
    assert_includes last_response.body, 'Number of users: 7'
  end

  def test_actions
    post '/action/next'
    assert last_response.redirect?
    assert_equal 3, Circle.count

    post '/action/reset'
    assert_equal 1, Circle.count
  end

  def test_currency_format
    helper = GiftingCircleSim.new!
    assert_equal '$40,000', helper.number_to_currency(40_000)
    assert_equal '-$5,000', helper.number_to_currency(-5000)
    assert_equal '$0', helper.number_to_currency(0)
  end
end
