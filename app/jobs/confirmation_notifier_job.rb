class ConfirmationNotifierJob < ApplicationJob
  queue_as :default

  before_enqueue :find_rooms

  def perform
  	# sleep 10
  	# puts "hello"
  	# later.update_stats
    # Do something later
    # Room.where("created_at >= ?", 1.hour.ago)
    if @rooms.count > 0
    	NotificationMailer.room_summary_mailer(@rooms.map {|r| r.id})
    end


    # Mailer.deliver_now()
  end
  def find_rooms
	 @rooms = Room.where("created_at >= ?", 1.hour.ago)
  end
end
