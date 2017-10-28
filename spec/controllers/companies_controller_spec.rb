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

  describe "get #with_modern_plan" do
    it "returns http success" do
      get :with_modern_plan
      expect(response).to have_http_status(:success)
    end
    it "returns only those companies under the modern plan" do
      for i in 0..4
        create(:company, :name => "company#{i}", :plan_level => 'custom')
        create(:company, :name => "company#{i+i}", :plan_level => 'legacy')
        create(:company, :name => "company#{i+i+i}", :plan_level => 'basic')
      end
      get :with_modern_plan
      json = JSON.parse(response.body)
      expect(json['data'].length).to eq(5)
    end
  end

  describe "get #not_trialing" do
    it "returns http success" do
      get :not_trialing
      expect(response).to have_http_status(:success)
    end
    it "returns companies that are not trialing" do
      for i in 0..4
        create(:company, :name => "company#{i}", :plan_level => 'custom')
        create(:company, :name => "company#{i+i}", :plan_level => 'legacy')
      end
      # set the date back on half (5) of these to where they are not in trial per the not_trialing method - all customers assumed in trial when starting, expires in configured numbers of days (e.g. 30) per company model trial_status method
      for company in Company.where(:plan_level => 'legacy')
        company.update(created_at: Date.today - 60.days)
      end
      get :not_trialing
      json = JSON.parse(response.body)
      expect(json['data'].length).to eq(5)
    end
  end

  describe "get #created_last_month" do
    it "returns http success" do
      get :created_last_month
      expect(response).to have_http_status(:success)
    end
    it "returns companies that were created last month" do
      for i in 0..4
        company = create(:company, :name => "company#{i}", :plan_level => 'custom')
        # set back the clock for 3 of them
        if (i % 2 == 0)
          company.update(created_at: Date.today - 1.month)
        end
      end
      get :created_last_month
      json = JSON.parse(response.body)
      expect(json['data'].count).to eq(3)
    end
  end
end
