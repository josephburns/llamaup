require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'name validations' do
    before(:each) do
      @company = Company.new(plan_level: 'custom')
    end
    
    it 'is not valid without a name' do
      @company.name = nil
      expect(@company).to_not be_valid
    end

    it 'is valid with a name of the right size' do
      @company.name = 'some company'
      expect(@company).to be_valid
    end
    
    it 'is not valid with a name that is too short' do
      @company.name = 'a'
      expect(@company).to_not be_valid
    end
    it 'is not valid with a name that is too long' do
      @company.name = 'a'
      255.times do
        @company.name = @company.name + 'a'
      end
      expect(@company).to_not be_valid
    end
  end

  describe 'plan validations' do
    before(:each) do
      @company = Company.new(:name => 'a valid name')
    end

    it 'is invalid with no plan' do
      expect(@company).to_not be_valid
    end
    it 'is valid with a valid plan' do
      @company.plan_level = 'custom'
      expect(@company).to be_valid
    end
    it 'is invalid with an invalid plan' do
      @company.plan_level = 'bad plan'
      expect(@company).to_not be_valid
    end
  end

  describe :trials_status do
    it 'trials_status returns true if within trial period' do
      company = create(:company, :name => 'a valid name', :plan_level => 'custom')
      expect(company.trial_status).to be_truthy
    end
    it 'trials_status returns false if after trial period' do
      company = create(:company, :name => 'a valid name', :plan_level => 'custom')
      company.created_at = Date.today - 60
      expect(company.trial_status).to_not be_truthy
    end
  end
end
