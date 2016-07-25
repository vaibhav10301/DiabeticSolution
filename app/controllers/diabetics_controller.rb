class DiabeticsController < ApplicationController
  before_filter :authenticate_user!
	def index
	  @diabetics = Diabetic.current_user(current_user.id)
  end

  def new
  	@diabetic= Diabetic.new
  end

	def create
    @diabetic= Diabetic.new(diabetic_params)
    if @diabetic.save
      redirect_to diabetics_path, alert: "Saved successfully"
    else
      render 'new'
    end    
  end

	private
    def diabetic_params
      params.require(:diabetic).permit( :glucose_level, :user_id )
    end
end
