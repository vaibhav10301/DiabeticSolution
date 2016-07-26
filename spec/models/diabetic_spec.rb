require 'rails_helper'

RSpec.describe Diabetic  do

  it "is single digit integer value" do 
    diabetic = Diabetic.new(glucose_level: 10)
    expect(diabetic).not_to be_valid
  end

  it "should not accept float value" do 
    diabetic = Diabetic.new(glucose_level: 1.12)
    expect(diabetic).not_to be_valid
  end

  it "should not accept any character"  do 
    diabetic = Diabetic.new(glucose_level: "aa")
    expect(diabetic).not_to be_valid
  end

  it "should accept only single integer"  do 
    diabetic = Diabetic.new(glucose_level: 5)
    expect(diabetic).to be_valid
  end
end