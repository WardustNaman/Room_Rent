class NotificationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.order_confirmation.subject
  #
  def order_confirmation(room)
    @room = room
    mail to: "#{@room.user.email}", subject: "Room Confirmation Pending"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.welcome_email.subject
  #
  def booking_created(booked_record)
    @booking = booked_record
    mail to: "#{@booking.user.email}", subject: "Your Booking Status"
  end

  def booking_confirmation(booking_record)
    @booking = booking_record
    mail to: "#{@booking.user.email}", subject: "Confirm Booking"
  end

  def booking_status(confirmation)
    @booking = confirmation
    mail to: "#{@booking.user.email}", subject: "Your Booking Confirmation"
  end

  def room_summary_mailer(room_ids)
    @rooms = Room.where(id: room_ids)
    mail(to: "naman.garg1995@gmail.com", subject: "#{@rooms.count} created in last 1 hour")
  end
  
end
