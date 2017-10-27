require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "returns all companies" do
      10.times do
        create(:company, :name => "company#{rand(999)}" , :plan_level => 'custom')
      end 
      get :index
      json = JSON.parse(response.body)
      expect(json['data'].length).to eq(10)
    end
  end

end
