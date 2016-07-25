require 'rails_helper'

RSpec.describe DiabeticsController do

	describe "Get Index" do

		it "renders the index template" do
            get :index
            expect(response).to render_template("index")
        end
        it "renders the new template" do
            get :new
            expect(response).to have_http_status(200)
        end
        it "should redirect to index page after creation" do
        	post :create , :diabetic => {glucose_level: 5}
        	expect(response).to redirect_to(diabetics_path)
        end

        it "assign a new diabetic" do
            get :new
            expect(assigns(:diabetic)).to be_a_new(Diabetic)
        end
	end
end

