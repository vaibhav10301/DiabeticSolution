class Diabetic < ActiveRecord::Base
  belongs_to :user
  
  validates_numericality_of :glucose_level , :only_integer => true,  
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 9,
    :message => "Please enter single digit integer value."


  validate :user_quota, :on => :create  
   
  scope :current_user, -> (user_id){where(:user_id => user_id)} 
  
  def self.daily_report user_id
    daily_report_min = Diabetic.where(:user_id => user_id).group("date_format(created_at, '%m%d')").minimum(:glucose_level)
    daily_report_max = Diabetic.where(:user_id => user_id).group("date_format(created_at, '%m%d')").maximum(:glucose_level)
    daily_report_avg = Diabetic.where(:user_id => user_id).group("date_format(created_at, '%m%d')").average(:glucose_level)
  end

  def self.month_to_date_report end_date,user_id
    month_to_date=[]
    month_to_date << Diabetic.where(:user_id => user_id).where(:created_at => (end_date.beginning_of_month..end_date)).minimum(:glucose_level)
    month_to_date << Diabetic.where(:user_id => user_id).where(:created_at => (end_date.beginning_of_month..end_date)).maximum(:glucose_level)
    month_to_date << Diabetic.where(:user_id => user_id).where(:created_at => (end_date.beginning_of_month..end_date)).average(:glucose_level)
    month_to_date
  end

  def self.monthly_report user_id
    monthly_report_min = Diabetic.where(:user_id => user_id).group("date_format(created_at, '%M')").minimum(:glucose_level)
    monthly_report_max = Diabetic.where(:user_id => user_id).group("date_format(created_at, '%M')").maximum(:glucose_level)
    monthly_report_avg = Diabetic.where(:user_id => user_id).group("date_format(created_at, '%M')").average(:glucose_level)
  end

  private 
    def user_quota
   	  daily_limit = Diabetic.where("user_id = ?", self.user_id).where(:created_at => (Time.zone.now.beginning_of_day..Time.zone.now)).to_a
      if daily_limit.count > 3
        errors.add(:base, "Exceeds daily limit. You can enter only 4 times in a day")
      end
    end
end
