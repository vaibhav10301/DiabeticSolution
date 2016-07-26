class ReportsController < ApplicationController
  def report
    if request.post?
      if params[:report_type]=="Daily Report"
        @report_type =Diabetic.daily_report current_user.id

      elsif params[:report_type]=="Month to Date report"
        @report= Diabetic.month_to_date_report params[:end_date].to_date, current_user.id
      
      else
        @report=Diabetic.monthly_report current_user.id
      end
    else
    #get request code
    end 
  end
end
