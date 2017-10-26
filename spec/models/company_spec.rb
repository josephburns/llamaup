require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'validations' do
    it "is not valid without a name" do
      company = Company.new(:name => nil)
      expect(company).to_not be_valid
    end

    it "is not valid with a name but without a plan level" do
      company = Company.new(:name => 'new company', :plan_level => nil)
      expect(company).to_not be_valid
    end

    it "is not valid with valid name, invalid plan_level" do
      company = Company.new(:name => 'new company', :plan_level => 'bad plan')
      expect(company).to_not be_valid
    end

    it "is valid with valid name and plan level" do
      company = Company.new(:name => 'new company', :plan_level => 'custom')
      expect(company).to be_valid
    end
  end
end
