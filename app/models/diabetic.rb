class Diabetic < ActiveRecord::Base
  belongs_to :user
  validates_numericality_of :glucose_level , :only_integer => true,  
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 9,
    :message => "Please enter single digit integer value."


    #validate :user_quota, :on => :create  
   
  scope :current_user, -> (user_id){where(:user_id => user_id)} 

  private 
    def user_quota
   	  daily_limit = Diabetic.where("user_id = ?", self.user_id).where(:created_at => (Time.zone.now.beginning_of_day..Time.zone.now)).to_a
      if daily_limit.count > 3
        errors.add(:base, "Exceeds daily limit. You can enter only 4 times in a day")
      end
    end
end
