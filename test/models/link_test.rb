require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  test "valid link" do
    record = Link.new
    record.link = "http://ya.ru"
    assert record.save
  end

  test "invalid link" do
    record = Link.new
    record.link = "ya.ru"
    assert_not record.save
  end


end
