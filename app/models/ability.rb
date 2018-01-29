class Ability
  include CanCan::Ability

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  def initialize(user)
    if user.nil?
        can :read, [Room, City]
    elsif user.role? "admin"
        can :manage, [Room, Amenity, City, Booking, Review]
        can :unauthorized_rooms, Room
        can :unconfirmed_bookings, Booking
    elsif user.role? "host"
        
        can :my_rooms, [Room]
        can :read, [Amenity, City, Room, Review]
        can :create, [Room, Booking, Review]
        can [:update, :destroy], Room do |room|
            room.user_id == user.id 
        end
        can [:update, :destroy], Booking do |booking|
            booking.room.user_id == user.id
        end 
        can :unconfirmed_bookings, Booking
        can :cancel_booking, Booking
        can :create, SpecialPrice
        can [:update, :destroy], SpecialPrice do |special_price|
            special_price.room.user_id == user.id
        end
        can :destroy, Review do |review|
            review.user_id == user.id
        end
    elsif user.role? "guest"
        can :read, [Room, Amenity, City, Booking, Review]
        can :create, [Room, Booking, Review]
        can :destroy, Booking do |booking|
            booking.user_id == user.id
        end
        can :destroy, Review do |review|
            review.user_id == user.id
        end
    end 
  end
end
