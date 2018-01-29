require 'test_helper'

class NotificationMailerTest < ActionMailer::TestCase
  test "order_confirmation" do
    mail = NotificationMailer.order_confirmation
    assert_equal "Order confirmation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "booking_created" do
    mail = NotificationMailer.booking_created
    assert_equal "Booking_created", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "booking_confirmation" do
    mail = NotificationMailer.booking_confirmation
    assert_equal "Booking_confirmation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "booking_status" do
    mail = NotificationMailer.booking_status
    assert_equal "Booking_status", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
