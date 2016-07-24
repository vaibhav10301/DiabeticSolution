class DiabeticsController < ApplicationController
  before_filter :authenticate_user!
  	def index
		@diabetics = Diabetic.where("user_id = ?", current_user.id)
	end

	def new
		@diabetic= Diabetic.new
	end

	def create
       @diabetic= Diabetic.new(diabetic_params)
       @diabetic.user_id = current_user.id
        if @diabetic.save
            redirect_to action: :index
        else
           redirect_to action: :index  
        end    
    end

	private
    def diabetic_params
        params.require(:diabetic).permit(:glucose_level,:user_id)
    end
end
