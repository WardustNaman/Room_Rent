class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login ]
         validates_presence_of :username, :mobile, :first_name, :last_name
         validates_numericality_of :mobile
         validates_length_of :mobile, is:10
         has_many :bookings
         has_many :reviews
         has_many :rooms
         belongs_to :role
         attr_accessor :login
         validates :username,
  			:presence => true,
  			:uniqueness => {
    		:case_sensitive => false
  			} 

         after_create :assign_guest_role
         def assign_guest_role
         	self.role_id = Role.last.id
         end
         def role?(role)
         	self.role.name == role
         end
            def self.find_for_database_authentication(warden_conditions)
      			conditions = warden_conditions.dup
      			if login = conditions.delete(:login)
        		where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      			elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        		where(conditions.to_h).first
      		end
    end
end
