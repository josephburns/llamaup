require 'rails_helper'

RSpec.describe Lesson, type: :model do
  describe 'associations' do
    it 'should belong_to company' do
      company = create(:company, :plan_level => 'custom', :name => 'some company')
      lesson = create(:lesson, :company => company, :name => 'alesson', :active => true)
      expect(lesson.company).to be(company)
    end
    it 'should not allow creation w/o a company' do
      lesson = Lesson.new(:name => 'a lesson', :active => true)
      expect(lesson).to_not be_valid
    end
  end

  describe 'validations' do
    it 'name should not be valid if it contains a character other than letter or number' do
      company = create(:company, :plan_level => 'custom', :name => 'some company')
      lesson = Lesson.new(:company => company, :name => 'a - 234@#$lesson', :active => true)
      expect(lesson).to_not be_valid
    end
    
    it 'name should be valid if it just contains letters or numbers' do
      company = create(:company, :plan_level => 'custom', :name => 'some company')
      lesson = Lesson.new(:company => company, :name => 'a234lesson', :active => true)
      expect(lesson).to be_valid
    end
    
    it 'name should be invalid if it is empty' do
      company = create(:company, :plan_level => 'custom', :name => 'some company')
      lesson = Lesson.new(:company => company, :name => '', :active => true)
      expect(lesson).to_not be_valid
    end
    
    it 'name should be invalid if it does not contain an active status' do
      company = create(:company, :plan_level => 'custom', :name => 'some company')
      lesson = Lesson.new(:company => company, :name => 'a234lesson')
      expect(lesson).to_not be_valid
    end
  end
end
