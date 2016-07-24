class Diabetic < ActiveRecord::Base
  belongs_to :user
  validates_numericality_of :glucose_level , :only_integer => true,  
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 9,
    :message => "Please enter single digit integer value."

    validate :user_quota, :on => :create  

   private 
    def user_quota
   	  a = Diabetic.where("user_id = ?", current_user.id).where(:created_at => (Time.zone.now.beginning_of_day..Time.zone.now)).to_a
      if a.count > 4 
        errors.add(:base, "Exceeds daily limit")
      end
    end

end
