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

  describe "get #alphabetically" do
    it "returns http success" do
      get :alphabetically
      expect(response).to have_http_status(:success)
    end
    it "returns companies in alphabetical order" do
      semi_rando_array = []
      10.times do
        semi_rando_name = ('a'..'z').to_a.shuffle[0,10].join
        # pull it out into an array to compare later
        semi_rando_array << semi_rando_name
        create(:company, :name => semi_rando_name, :plan_level => 'custom')
      end
      get :alphabetically
      json = JSON.parse(response.body)
      response_names = []
      for i in 0..9
        response_names << json['data'][i]['name']
      end
      expect(response_names).to eq(semi_rando_array.sort)
    end
  end

end
